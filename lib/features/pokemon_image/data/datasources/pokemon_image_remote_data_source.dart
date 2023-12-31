import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../../../../core/constants/constants.dart';
import '../models/pokemon_image_model.dart';
import 'package:path_provider/path_provider.dart';

abstract class PokemonImageRemoteDataSource {
  Future<PokemonImageModel> getPokemonImage({required PokemonImageParams pokemonImageParams});
}

class PokemonImageRemoteDataSourceImpl implements PokemonImageRemoteDataSource {
  final Dio dio;

  PokemonImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<PokemonImageModel> getPokemonImage({required PokemonImageParams pokemonImageParams}) async {
    Directory directory = await getApplicationDocumentsDirectory();
    if (kDebugMode) {
      print(directory.path);
    }

    try{
      directory.deleteSync(recursive: true);
    }on FileSystemException catch (e){
      //directory = await Directory('$directory/cleanArchFolder').create(recursive: false);
      print("You got :${e.message} error message from ${directory.path}");
    }

    final pathFile = isShiny ? '${directory.path}/${pokemonImageParams.name}_shiny.png': '${directory.path}/${pokemonImageParams.name}.png';
    final response = await dio.download(
      pokemonImageParams.imageUrl,
      pathFile
    );

    if (response.statusCode == 200) {
      return PokemonImageModel.fromJson(json: {kPath: pathFile});
    } else {
      throw ServerException();
    }
  }
}
