import 'package:flutter/material.dart';

class PokemonListTile extends StatelessWidget {

  final String pokemonUrl;

  PokemonListTile({required this.pokemonUrl});

  @override
  Widget build(BuildContext context) {
    return _tile(context);
  }

  Widget _tile(BuildContext context) {
    return ListTile(title: Text(pokemonUrl),);
  }
}

