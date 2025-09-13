import 'package:get/get.dart';
import '../models/report_summary.dart';

class ReportRepository {
  // سهل: قائمة قابلة للملاحظة تحوي التقارير (يمكنك لاحقاً ت persist)
  final RxList<ReportSummary> _reports = <ReportSummary>[].obs;

  List<ReportSummary> get allReports => _reports;
  ReportSummary? get latest => _reports.isNotEmpty ? _reports.last : null;

  void addReport(ReportSummary r) => _reports.add(r);

  void clear() => _reports.clear();
}
