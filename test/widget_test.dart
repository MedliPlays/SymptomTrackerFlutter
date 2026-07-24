// Widget-level smoke tests live alongside feature work. Data-format
// compatibility is covered by backup_format_test.dart.
import 'package:flutter_test/flutter_test.dart';
import 'package:symptom_tracker/src/features/charts/charts_data.dart';

void main() {
  test('ChartData handles empty input', () {
    final data = ChartData.build(const [], const {});
    expect(data.isEmpty, isTrue);
    expect(data.totalCount, 0);
  });
}
