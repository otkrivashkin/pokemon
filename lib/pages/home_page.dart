import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/controllers/home_page_controller.dart';
import 'package:pokemon_app/models/data/home_page_data.dart';
import 'package:pokemon_app/models/pokemon/pokemon_list_result.dart';
import 'package:pokemon_app/providers/pokemon_providers.dart';
import 'package:pokemon_app/widgets/pokemon_card.dart';
import 'package:pokemon_app/widgets/pokemon_list_tile.dart';

import '../providers/home_page_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _pokemonListScrollController = ScrollController();
  late HomePageController _homePageController;
  late HomePageData _homePageData;
  late List<String> _favoritePokemons;

  @override
  void initState() {
    super.initState();
    _pokemonListScrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _pokemonListScrollController.removeListener(_scrollListener);
    _pokemonListScrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_pokemonListScrollController.offset >=
            _pokemonListScrollController.position.maxScrollExtent * 1 &&
        !_pokemonListScrollController.position.outOfRange) {
      _homePageController.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    _homePageController = ref.watch(homePageControllerProvider.notifier);
    _homePageData = ref.watch(homePageControllerProvider);
    _favoritePokemons = ref.watch(favoritePokemonsProvider);
    return Scaffold(
      body: _buildUI(
        context,
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_favoritePokemonList(context), _pokemonList(context)],
        ),
      ),
    ));
  }

  Widget _favoritePokemonList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Favorites",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .5,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _favoritePokemons.isNotEmpty ? SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.48,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _favoritePokemons.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      String pokemonUrl = _favoritePokemons[index];
                      return PokemonCard(pokemonUrl: pokemonUrl);
                    }),) : Text('No favorites'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _pokemonList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Pokemons',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: ListView.builder(
                controller: _pokemonListScrollController,
                itemCount: _homePageData.data?.results?.length ?? 0,
                itemBuilder: (context, index) {
                  PokemonListResult pokemon =
                      _homePageData.data!.results![index];
                  return PokemonListTile(
                    pokemonUrl: pokemon.url!,
                  );
                }),
          )
        ],
      ),
    );
  }
}
