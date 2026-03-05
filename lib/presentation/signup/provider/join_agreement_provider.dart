import 'package:falletter_mobile_v2/presentation/signup/view/join_agreement_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgreeNotifier extends StateNotifier<Map<Agree, bool>> {
  AgreeNotifier() : super({
    Agree.all: false,
    Agree.use: false,
    Agree.privacy: false,
    Agree.community: false,
    Agree.push: false,
  });

  bool get isCheckedToggle =>
      (state[Agree.use] ?? false) &&
          (state[Agree.privacy] ?? false) &&
          (state[Agree.community] ?? false);

  void checkBoxList(Agree type) {
    final isChecked = Map<Agree, bool>.from(state);

    if (type == Agree.all) {
      bool allTrue = !(isChecked[Agree.all] ?? false);
      isChecked.updateAll((key, value) => allTrue);
    } else {
      isChecked[type] = !(isChecked[type] ?? false);
      isChecked[Agree.all] =
          isChecked[Agree.use]! &&
              isChecked[Agree.privacy]! &&
              isChecked[Agree.community]! &&
              isChecked[Agree.push]!;
    }
    state = isChecked;
  }
}

final agreeProvider = StateNotifierProvider<AgreeNotifier, Map<Agree, bool>>((ref) {
  return AgreeNotifier();
});