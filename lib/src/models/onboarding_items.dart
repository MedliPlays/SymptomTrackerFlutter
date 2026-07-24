import 'package:uuid/uuid.dart';

import 'symptom_type.dart';

const _uuid = Uuid();

/// Preset symptom types offered during onboarding / "Choose from a list".
///
/// Mirrors the original iOS app's static list. Ids are generated fresh each
/// call so re-importing a preset produces a new distinct type.
List<SymptomType> buildOnboardingItems() => [
  _preset('Headache', true),
  _preset('Stomach ache', true),
  _preset('Constipation', true),
  _preset('Diarrhea', true),
  _preset('Nausea', true),
  _preset('Vomiting', true),
  _preset('Fatigue', true),
  _preset('Anxiety', true),
  _preset('Start of menstruation', false),
  _preset('End of menstruation', false),
  _preset('Start of ovulation', false),
  _preset('End of ovulation', false),
];

SymptomType _preset(String name, bool hasSeverity) =>
    SymptomType(id: _uuid.v4().toUpperCase(), name: name, hasSeverity: hasSeverity);
