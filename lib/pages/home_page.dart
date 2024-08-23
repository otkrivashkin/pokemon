import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: _buildUI(context),
    );
  }
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
        children: [_pokemonList(context)],
      ),
    ),
  ));
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
              itemCount: 0,
              itemBuilder: (context, index) {
                return ListTile();
              }),
        )
      ],
    ),
  );
}
