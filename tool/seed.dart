// Dev-only seeder: populates a sembast db at the given path with sample data
// so the populated screens can be inspected in a simulator.
//
//   dart run tool/seed.dart <documents_dir>
import 'package:sembast/sembast_io.dart';
import 'package:symptom_tracker/src/data/symptom_repository.dart';
import 'package:symptom_tracker/src/models/symptom.dart';
import 'package:symptom_tracker/src/models/symptom_type.dart';

Future<void> main(List<String> args) async {
  final dir = args.first;
  final db =
      await databaseFactoryIo.openDatabase('$dir/eir_symptom_tracker.db');
  final repo = SymptomRepository(db);
  await repo.deleteAll();

  final headache = SymptomType(id: 'T-HEADACHE', name: 'Headache');
  final nausea = SymptomType(id: 'T-NAUSEA', name: 'Nausea');
  final fatigue = SymptomType(id: 'T-FATIGUE', name: 'Fatigue');
  final period = SymptomType(
      id: 'T-PERIOD', name: 'Start of menstruation', hasSeverity: false);
  for (final t in [headache, nausea, fatigue, period]) {
    await repo.upsertType(t);
  }

  final now = DateTime.now();
  var i = 0;
  Symptom mk(SymptomType t, int daysAgo, int hour, double sev, [String notes = '']) =>
      Symptom(
        id: 'S${i++}',
        timestamp: now.subtract(Duration(days: daysAgo)).copyWith(hour: hour),
        typeId: t.id,
        severity: t.hasSeverity ? sev : 0,
        notes: notes,
      );

  final samples = <Symptom>[
    mk(headache, 0, 9, 6, 'woke up with it'),
    mk(nausea, 0, 13, 4),
    mk(headache, 1, 10, 7),
    mk(fatigue, 1, 20, 5),
    mk(headache, 2, 8, 5),
    mk(nausea, 3, 15, 6),
    mk(fatigue, 4, 19, 8, 'exhausted'),
    mk(headache, 5, 11, 4),
    mk(period, 6, 7, 0),
    mk(headache, 6, 22, 9, 'migraine'),
    mk(nausea, 7, 12, 3),
    mk(fatigue, 8, 18, 6),
    mk(headache, 9, 9, 5),
  ];
  for (final s in samples) {
    await repo.upsertSymptom(s);
  }
  await repo.setOnboardingComplete();
  await db.close();
  // ignore: avoid_print
  print('Seeded ${samples.length} symptoms into $dir');
}
