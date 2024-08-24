import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/models/pokemon/pokemon.dart';
import 'package:pokemon_app/providers/pokemon_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonUrl;

  PokemonListTile({required this.pokemonUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonUrl));
    return pokemon.when(data: (data) {
      return _tile(context, false, data);
    }, error: (error, stackTrace) {
      return Text('Error: $error');
    }, loading: () {
      return _tile(context, true, null);
    });
  }

  Widget _tile(BuildContext context, bool isLoading, Pokemon? pokemon) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        leading: pokemon != null ? CircleAvatar(backgroundImage: NetworkImage(pokemon.sprites!.frontDefault!),) : CircleAvatar(),
        title: Text(pokemon != null ? pokemon.name!.toUpperCase() : 'Currently loading pokemon'),
        subtitle: Text('Has ${pokemon?.moves?.length.toString() ?? 0} moves'),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border),),
      ),
    );
  }
}
