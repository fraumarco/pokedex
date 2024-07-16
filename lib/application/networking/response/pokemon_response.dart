import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PokemonResponse {
  int? count;
  String? next;
  String? previous;
  List<PokemonResultResponse>? results;

  PokemonResponse({this.count, this.next, this.previous, this.results});

  PokemonResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <PokemonResultResponse>[];
      json['results'].forEach((v) {
        results!.add(PokemonResultResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@JsonSerializable()
class PokemonResultResponse {
  String? name;
  String? url;

  PokemonResultResponse({this.name, this.url});

  PokemonResultResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
