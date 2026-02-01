import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/message.dart';

class FirebaseService {
  final DatabaseReference _reference = FirebaseDatabase.instance.ref('chat/general');

  // Enviar mensaje
  Future<void> enviarMensaje(Message mensaje) async {
    try {
      await _reference.push().set(mensaje.toMap());
    } catch (e) {
      debugPrint('Error enviando mensaje: $e');
      rethrow;
    }
  }

  // Obtener stream de mensajes en tiempo real
  Stream<List<Message>> getMensajesStream() {
    return _reference.orderByChild('timestamp').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data == null) return <Message>[];
      
      return data.entries.map((entry) {
        final messageData = Map<String, dynamic>.from(entry.value as Map);
        return Message.fromMap(messageData, entry.key.toString());
      }).toList();
    });
  }

  // Referencia para compatibilidad
  DatabaseReference get mensajesRef => _reference;
}