import 'package:falletter_mobile_v2/models/letter_count_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final letterCountProvider = Provider<LetterCountModel>(
      (ref) => dummy,
);

final dummy = LetterCountModel(letterCount: 1, userId: 1);