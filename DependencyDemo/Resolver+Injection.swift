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
                                      userRepository: resolve())
        }.scope(.unique)

        register(URLSession.self) {
            return URLSession.shared
        }.scope(.unique)

        register(UserDefaults.self) {
            return UserDefaults.standard
        }.scope(.unique)

        register(UserRepository.self) {
            return UserRepositoryImpl(api: resolve(),
                                      settings: resolve())
        }.scope(.unique)
    }
}
