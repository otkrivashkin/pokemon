import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/models/pokemon/pokemon.dart';
import 'package:pokemon_app/services/http_service.dart';

final pokemonDataProvider = FutureProvider.autoDispose.family<Pokemon?,
    String>((ref, url) async {
  HttpService _httpService = GetIt.instance.get<HttpService>();
  Response? res = await _httpService.get(url);
  if(res != null && res.data != null) {
    return Pokemon.fromJson(res.data);
  }
  return null;
});