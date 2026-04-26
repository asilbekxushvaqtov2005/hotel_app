import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String id;
  final String roomNumber;
  final String type; // e.g. "Single", "Double", "Suite"
  final double pricePerNight;
  final List<String> images;
  final List<String> amenities;

  const Room({
    required this.id,
    required this.roomNumber,
    required this.type,
    required this.pricePerNight,
    required this.images,
    required this.amenities,
  });

  @override
  List<Object?> get props => [id, roomNumber, type, pricePerNight, images, amenities];
}
