

import AppIntents

/// The `EntityPropertyQuery` of the `PokemonAppEntity`.
@available(iOS 16.0, *)
struct PKMNIntentsQuery: EntityQuery {
    // MARK: - Entities Methods

    /// Find an entity by his ID.
    /// For example a user may have chosen a Pokemon from a list when tapping on a parameter that accepts Pokemon. The ID of that Pokemon is now hardcoded into the `Shortcut`.
    /// - Parameter identifiers: The list of IDs for the Pokemons that the user selected.
    /// - Returns: The list of `[PokemonAppEntity]` found.
    func entities(for identifiers: [String]) async throws -> [PokemonAppEntity] {
        return await withTaskGroup(of: PokemonAppEntity.self) { group in
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
            return entities.filter { identifiers.contains($0.id) }
        }
    }

    /// Returns all Pokemon. This is what populates the list when you tap on a parameter that accepts a Pokemon.
    func suggestedEntities() async throws -> [PokemonAppEntity] {
        return await withTaskGroup(of: PokemonAppEntity.self) { group in
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
            return entities
        }
    }
}
