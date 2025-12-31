import 'package:falletter_mobile_v2/core/config/app_env.dart';

class ApiEndpoints {
  /// Base URL
  static const baseUrl = AppEnv.baseUrl;

  /// Auth
  static const emailVerify = "/auth/email/verify";
  static const emailMatch = "/auth/email/match";

  /// User
  static const signup = "/user/signup";
  static const signin = "/user/signin";
  static const logout = "/user/logout";
  static const users = "/user/users";
  static const student = "/user/student";

  /// Community
  static const post = "/community/posts";

  /// Comment
  static const comment = "/comment";

  /// Item
  static const letterCount = "/item/letter/count";
  static const letterUpdate = "/item/letter/update";
  static const brickCount = '/item/brick/count';
  static const brickUpdate = "/item/brick/update";

  /// Letter
  static const sent = "/letter/sent";
  static const sentAll = "/letter/sent/all";
  static const receivedAll = "/letter/received/all";
  static const received = "/letter/received";

  /// History
  static const brickSave = "/history/brick/save";
  static const brickUsed = "/history/brick/used";

  /// Answer
  static const choose = "/answer/choose";
  static const chosen = "/answer/chosen";

  /// Question
  static const all = "/question/all";

  /// Hint
  static const save = "/hint/save";
  static const hint = "/hint";
  static const update = "/hint/update";

  /// Admin
  static const letterUnPassed = "/admin/letter/unpassed";
  static const notice = "/admin/notice";
  static const community = "/admin/community";
  static String warnUser(String userId) => "/admin/user/$userId/warning";
  static String blockUser(String userId) => "/admin/user/$userId/block";
  static const user = "/admin/user";
  static const userAll = "/admin/user/all";
}