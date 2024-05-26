import 'dart:convert';

// Función para convertir un JSON string en una lista de objetos `Agents`
List<Agents> agentsFromJson(String str) {
  final jsonData = json.decode(str);
  print(jsonData);
  // Verificar que jsonData es una lista
  if (jsonData is List) {
    return List<Agents>.from(jsonData.map((x) => Agents.fromJson(x)));
  } else {
    throw Exception('El formato del JSON no es el esperado');
  }
}

class Agents {
  final String username;
  final String uid;
  final String profile;

  Agents({
    required this.username,
    required this.uid,
    required this.profile,
  });

  factory Agents.fromJson(Map<String, dynamic> json) => Agents(
        username: json["username"],
        uid: json["uid"],
        profile: json["profile"],
      );
}
