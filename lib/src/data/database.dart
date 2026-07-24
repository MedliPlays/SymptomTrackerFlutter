import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

/// Opens the on-device sembast database (pure-Dart, no native code — works on
/// iOS, Android, macOS, Linux and Windows without per-platform setup).
Future<Database> openAppDatabase() async {
  final dir = await getApplicationDocumentsDirectory();
  final path = '${dir.path}/eir_symptom_tracker.db';
  return databaseFactoryIo.openDatabase(path);
}
