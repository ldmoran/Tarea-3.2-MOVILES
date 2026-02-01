class Message {
  final String id;
  final String texto;
  final String autor;
  final String senderId;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.texto,
    required this.autor,
    required this.senderId,
    required this.timestamp,
  });

  // Convertir a Map para Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'texto': texto,
      'autor': autor,
      'senderId': senderId,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  // Crear desde Map de Firebase
  factory Message.fromMap(Map<String, dynamic> map, String documentId) {
    return Message(
      id: documentId,
      texto: map['texto'] ?? '',
      autor: map['autor'] ?? '',
      senderId: map['senderId'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] ?? 0),
    );
  }

  // Mantener compatibilidad con el formato anterior
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? '',
      texto: json['texto'] ?? '',
      autor: json['autor'] ?? '',
      senderId: json['senderId'] ?? '',
      timestamp: json['timestamp'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'Message(id: $id, texto: $texto, autor: $autor, timestamp: $timestamp)';
  }
}