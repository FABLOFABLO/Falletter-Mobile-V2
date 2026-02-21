import 'package:falletter_mobile_v2/models/my_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoProvider = Provider<UserInfoModel>((ref) {
  return dummy;
});

final dummy = UserInfoModel(
  id: 1,
  email: 'fablo',
  schoolNumber: '1216',
  name: '최승우',
  gender: 'MALE',
  theme: 'BLUE',
  profileImage: '',
  attendDay: 4,
);