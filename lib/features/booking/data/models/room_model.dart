import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/room.dart';

class RoomModel extends Room {
  const RoomModel({
    required super.id,
    required super.roomNumber,
    required super.type,
    required super.pricePerNight,
    required super.images,
    required super.amenities,
  });

  factory RoomModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return RoomModel(
      id: doc.id,
      roomNumber: data['roomNumber'] ?? '',
      type: data['type'] ?? '',
      pricePerNight: (data['pricePerNight'] ?? 0).toDouble(),
      images: List<String>.from(data['images'] ?? []),
      amenities: List<String>.from(data['amenities'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'roomNumber': roomNumber,
      'type': type,
      'pricePerNight': pricePerNight,
      'images': images,
      'amenities': amenities,
    };
  }
}
