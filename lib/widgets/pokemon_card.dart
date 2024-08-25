import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/models/pokemon/pokemon.dart';
import 'package:pokemon_app/providers/pokemon_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonCard extends ConsumerWidget {
  final String pokemonUrl;
  late FavoritePokemonsProvider _favoritePokemonsProvider;

  PokemonCard({super.key, required this.pokemonUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _favoritePokemonsProvider = ref.watch(favoritePokemonsProvider.notifier);
    final pokemon = ref.watch(pokemonDataProvider(pokemonUrl));
    return pokemon.when(data: (data) {
      return _card(context, false, data);
    }, error: (error, stackTrace) {
      return Text("Error $error");
    }, loading: () {
      return _card(context, true, null);
    });
  }

  Widget _card(BuildContext context, bool isLoading, Pokemon? pokemon) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.03,
            vertical: MediaQuery.sizeOf(context).height * 0.01),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.03,
            vertical: MediaQuery.sizeOf(context).height * 0.01),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2,
                blurRadius: 26,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokemon?.name?.toUpperCase() ?? 'Pokemon',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '#${pokemon?.id}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Expanded(
                child: CircleAvatar(
              backgroundImage: pokemon != null
                  ? NetworkImage(pokemon.sprites!.frontDefault!)
                  : null,
              radius: MediaQuery.sizeOf(context).height * .05,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${pokemon?.moves?.length ?? 0} moves",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      _favoritePokemonsProvider.removeFavoritePokemon(pokemonUrl);
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
