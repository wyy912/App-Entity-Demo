//
//  AppEntityExtension.swift
//  AppEntityExtension
//
//  Created by wahson on 2024/10/30.
//

import AppIntents

struct AppEntityExtension: AppIntent {

    static var title: LocalizedStringResource { "AppEntityExtension" }

    /// The description of the action.
    static var description: IntentDescription = IntentDescription("description")

    /// Authentication policies to apply when running an app intent.
    static var authenticationPolicy = IntentAuthenticationPolicy.alwaysAllowed

    /// Wheter or not the app should be open or not.
    static var openAppWhenRun = false

    @Parameter(title: "Pokemon")
    var pokemon: PokemonAppEntity?

    func perform() async throws -> some ReturnsValue<PokemonAppEntity> {
        let pokemonToCatch: PokemonAppEntity
        if let pokemon = pokemon {
            pokemonToCatch = pokemon
        } else {
            pokemonToCatch = try await withTaskGroup(of: PokemonAppEntity.self) { group in
                group.addTask {
                    PokemonAppEntity(id: "id1", name: "PokemonAppEntity1")
                }
                group.addTask {
                    PokemonAppEntity(id: "id2", name: "PokemonAppEntity2")
                }

                var entities: [PokemonAppEntity] = []
                for await entity in group {
                    entities.append(entity)
                }
                return entities.first!
            }
        }
        return .result(
            value: pokemonToCatch
        )

    }
}
