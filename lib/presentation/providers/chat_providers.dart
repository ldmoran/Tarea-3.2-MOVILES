import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/firebase_service.dart';
import '../../domain/models/message.dart';

// Instancia del servicio Firebase
final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

// Provider para el stream de mensajes
final mensajesProvider = StreamProvider<List<Message>>((ref) {
  final service = ref.read(firebaseServiceProvider);
  return service.getMensajesStream();
});

// Provider para el estado del controlador de texto
final messageControllerProvider = StateProvider<String>((ref) => '');

// Provider para el nombre del usuario
final userNameProvider = StateProvider<String>((ref) => 'Usuario');