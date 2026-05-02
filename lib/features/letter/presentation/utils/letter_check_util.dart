import 'package:falletter_mobile_v2/features/letter/data/model/get_letter_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<GetLetterModel>> getNewLetters(List<GetLetterModel> letters) async {
  final prefs = await SharedPreferences.getInstance();
  final seenIds = prefs.getStringList('readLetters') ?? [];

  final delivered = letters.where((l) => l.isDelivered).toList();

  return delivered
      .where((l) => !seenIds.contains(l.id.toString()))
      .toList();
}

Future<void> markAsSeen(int id) async {
  final prefs = await SharedPreferences.getInstance();
  final seen = prefs.getStringList('readLetters') ?? [];

  if (!seen.contains(id.toString())) {
    seen.add(id.toString());
    await prefs.setStringList('readLetters', seen);
  }
}