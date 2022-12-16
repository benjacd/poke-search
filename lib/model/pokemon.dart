import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Pokemon {
  final int id;
  final String name;
  final String image;
  final int height;
  final int weight;
  final List<String> type;
  final List<String> ability;

  const Pokemon(
      {required this.id,
      required this.name,
      required this.image,
      required this.height,
      required this.weight,
      required this.type,
      required this.ability});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    var typelist = List.from(json['types'])
        .map((e) => (e['type']['name']) as String)
        .toList();
    var abilitylist = List.from(json['abilities'])
        .map((e) => (e['ability']['name']) as String)
        .toList();
    return Pokemon(
      id: json['id'],
      name: json['name'],
      image: json['sprites']['other']['dream_world']['front_default'],
      height: json['height'],
      weight: json['weight'],
      type: typelist,
      ability: abilitylist,
    );
  }
}
