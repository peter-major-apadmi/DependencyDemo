//
//  Resolver+Injection.swift
//  DependencyDemo
//
//  Created by Peter Major on 19/03/2021.
//

import Resolver

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {

        registerViewControllers()

        register(AppNavigator.self) {
            return AppNavigatorImpl(settings: resolve())
        }.scope(.application)

        register(CognitoService.self) {
            return CognitoServiceImpl(api: resolve(),
                                      settings: resolve())
        }.scope(.unique)

        register(DogApi.self) {
            return DogApiImpl(session: resolve())
        }.scope(.application)

        register(Settings.self) {
            return SettingsImpl(userDefaults: resolve())
        }.scope(.unique)

        register(SignOutCommand.self) {
            return SignOutCommandImpl(cognitoService: resolve(),
                                      cachingDecorators: resolve())
        }.scope(.unique)

        register(URLSession.self) {
            return URLSession.shared
        }.scope(.unique)

        register(UserDefaults.self) {
            return UserDefaults.standard
        }.scope(.unique)

        // we're want to add a cache using a decorator
        // so rather than register the repository with the UserRepository protocol
        // we'll register the decorator with the UserRepository protocol
        // we'll still use the container to build the underlying repository for the decorator
        // we'll also register the all caching decorators so that they can be cleared easily in the SignOutCommand

        register {
            return UserRepositoryImpl(api: resolve(),
                                      settings: resolve())
        }.scope(.unique)

        register {
            return UserRepositoryCachingDecorator(userRepository: resolve(UserRepositoryImpl.self))
        }.implements(UserRepository.self)
         .scope(.application)

        register([ICachingDecorator].self) {
            return [
                resolve(UserRepositoryCachingDecorator.self)
            ]
        }

        /* original registration
        register(UserRepository.self) {
            return UserRepositoryImpl(api: resolve(),
                                      settings: resolve())
        }.scope(.unique)
        */
    }
}
