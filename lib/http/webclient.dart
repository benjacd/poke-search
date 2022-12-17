import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:lite_dex/model/pokemon.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint('REQUEST');
    debugPrint('URL: ${data.url}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint('\nRESPONSE');
    debugPrint('STATUS CODE: ${data.statusCode}');
    debugPrint('HEADERS: ${data.headers}');
    debugPrint('BODY: ${data.body}');
    return data;
  }
}

Future<List<Pokemon>> fetchPokemons() async {
  Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: const Duration(seconds: 5),
  );

  final List<Pokemon> pokemonList = List.empty(growable: true);

  String nextUrl = 'https://pokeapi.co/api/v2/pokemon?limit=10';
  for (int i = 0; i != 5; i++) {
    final Response response = await client.get(Uri.parse(nextUrl));
    final List<dynamic> results = jsonDecode(response.body)['results'];
    for (final dynamic result in results) {
      final url = result['url'] as String;
      client.get(Uri.parse(url)).then(
            (value) => pokemonList.add(
              Pokemon.fromJson(
                jsonDecode(value.body),
              ),
            ),
          );
    }
    nextUrl = jsonDecode(response.body)['next'];
  }

  return pokemonList;
}
