import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final String id;
  final String referenceId; // bookingId or orderId
  final double amount;
  final String paymentMethod; // "CreditCard", "Cash"
  final String status; // "Pending", "Paid", "Failed"
  final DateTime createdAt;

  const Payment({
    required this.id,
    required this.referenceId,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        referenceId,
        amount,
        paymentMethod,
        status,
        createdAt,
      ];
}
