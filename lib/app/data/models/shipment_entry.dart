enum ShipmentResult { delivered, received, cancelled }

class ShipmentEntry {
  final int shipmentNumber;
  final ShipmentResult result;
  final bool isPrepaid; // true = مسبوقة الدفع
  final double codAmount; // مبلغ الدفع عند الاستلام (إذا كان COD)

  ShipmentEntry({
    required this.shipmentNumber,
    required this.result,
    this.isPrepaid = false,
    this.codAmount = 0.0,
  });

  Map<String, dynamic> toJson() => {
    'shipmentNumber': shipmentNumber,
    'result': result.toString().split('.').last,
    'isPrepaid': isPrepaid,
    'codAmount': codAmount,
  };

  factory ShipmentEntry.fromJson(Map<String, dynamic> json) {
    ShipmentResult parseResult(String s) {
      switch (s) {
        case 'delivered':
          return ShipmentResult.delivered;
        case 'received':
          return ShipmentResult.received;
        case 'cancelled':
        default:
          return ShipmentResult.cancelled;
      }
    }

    return ShipmentEntry(
      shipmentNumber: json['shipmentNumber'] ?? 0,
      result: parseResult(json['result'] ?? 'cancelled'),
      isPrepaid: json['isPrepaid'] ?? false,
      codAmount: (json['codAmount'] is num)
          ? (json['codAmount'] as num).toDouble()
          : 0.0,
    );
  }
}
