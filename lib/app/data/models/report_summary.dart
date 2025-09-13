import 'shipment_entry.dart';

class ReportSummary {
  final int totalShipments;
  final int deliveredCount;
  final int receivedCount;
  final int cancelledCount;
  final int prepaidShipmentsCount;
  final double totalCodAmount; // مجموع مبالغ الدفع عند الاستلام
  final double amountToDriver; // محسوب عبر نسبة العمولة/قيمة مستحقة للمندوب
  final double netAmount; // المتبقي (totalCodAmount - amountToDriver)
  final DateTime createdAt;

  ReportSummary({
    required this.totalShipments,
    required this.deliveredCount,
    required this.receivedCount,
    required this.cancelledCount,
    required this.prepaidShipmentsCount,
    required this.totalCodAmount,
    required this.amountToDriver,
    required this.netAmount,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // يحسب الملخص من لائحة الشحنات - يمكنك تمرير driverCommissionPercent (افتراضي 0.08 = 8%)
  factory ReportSummary.fromEntries(
    List<ShipmentEntry> entries, {
    double driverCommissionPercent = 0.08,
  }) {
    final total = entries.length;
    final delivered = entries
        .where((e) => e.result == ShipmentResult.delivered)
        .length;
    final received = entries
        .where((e) => e.result == ShipmentResult.received)
        .length;
    final cancelled = entries
        .where((e) => e.result == ShipmentResult.cancelled)
        .length;
    final prepaid = entries.where((e) => e.isPrepaid).length;
    final totalCod = entries.fold<double>(0.0, (p, e) => p + (e.codAmount));
    final amountToDriver = double.parse(
      (totalCod * driverCommissionPercent).toStringAsFixed(2),
    );
    final net = double.parse((totalCod - amountToDriver).toStringAsFixed(2));

    return ReportSummary(
      totalShipments: total,
      deliveredCount: delivered,
      receivedCount: received,
      cancelledCount: cancelled,
      prepaidShipmentsCount: prepaid,
      totalCodAmount: totalCod,
      amountToDriver: amountToDriver,
      netAmount: net,
    );
  }

  Map<String, dynamic> toJson() => {
    'totalShipments': totalShipments,
    'deliveredCount': deliveredCount,
    'receivedCount': receivedCount,
    'cancelledCount': cancelledCount,
    'prepaidShipmentsCount': prepaidShipmentsCount,
    'totalCodAmount': totalCodAmount,
    'amountToDriver': amountToDriver,
    'netAmount': netAmount,
    'createdAt': createdAt.toIso8601String(),
  };

  factory ReportSummary.fromJson(Map<String, dynamic> json) => ReportSummary(
    totalShipments: json['totalShipments'] ?? 0,
    deliveredCount: json['deliveredCount'] ?? 0,
    receivedCount: json['receivedCount'] ?? 0,
    cancelledCount: json['cancelledCount'] ?? 0,
    prepaidShipmentsCount: json['prepaidShipmentsCount'] ?? 0,
    totalCodAmount: (json['totalCodAmount'] is num)
        ? (json['totalCodAmount'] as num).toDouble()
        : 0.0,
    amountToDriver: (json['amountToDriver'] is num)
        ? (json['amountToDriver'] as num).toDouble()
        : 0.0,
    netAmount: (json['netAmount'] is num)
        ? (json['netAmount'] as num).toDouble()
        : 0.0,
    createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
  );
}
