abstract class RoutePaths {
  static const main = '/main';
  static const letter = '/letter';
  static const answer = '/answer';
  static const notice = '/notice';
  static const mypage = '/mypage';

  static const gender = '/signup/gender';
  static const verifyCode = '/signup/gender/verifyCode';
  static const schoolNumber = '/signup/gender/schoolNumber';
  static const signupComplete = '/signup/gender/complete';
  static const joinAgree = '/signup/gender/joinAgree';
  static const email = '/signup/gender/email';
  static const password = '/signup/gender/password';

  static const sendLetter = '${RoutePaths.mypage}/sendLetter';
  static const getLetter = '${RoutePaths.mypage}/getLetter';
  static const brickHistory = '${RoutePaths.mypage}/brickHistory';
  static const themeSelect = '${RoutePaths.mypage}/themeSelect';
  static const notificationSetting = '${RoutePaths.mypage}/notificationSetting';
}