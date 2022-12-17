import 'package:flutter/material.dart';
import 'package:lite_dex/http/webclient.dart';
import 'package:lite_dex/resources/constants.dart';
import 'package:lite_dex/screens/pokemon_info.dart';
import 'package:lite_dex/model/pokemon.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemons;

  const PokemonList({Key? key, required this.pokemons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pokémon'),
      ),
      body: ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pokemons[index].name),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PokemonInfo(pokemon: pokemons[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FindPokemonByName extends StatefulWidget {
  const FindPokemonByName({Key? key}) : super(key: key);

  @override
  State<FindPokemonByName> createState() => _FindPokemonByNameState();
}

class _FindPokemonByNameState extends State<FindPokemonByName>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                fetchPokemons().then((pokemons) => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PokemonList(pokemons: pokemons),
                      ),
                    ));
              },
              child: const Text('Mostrar los 10 Pokémon'),
            ),
          ),
        ],
      ),
    );
  }
}
