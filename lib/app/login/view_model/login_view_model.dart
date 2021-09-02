import 'package:momentum_bank/app/login/model/login_repository.dart';
import 'package:momentum_bank/app/login/model/login_request.dart';
import 'package:momentum_bank/app/login/model/login_response.dart';
import 'package:momentum_bank/app/utils/app_constants.dart';
import 'package:momentum_bank/app/utils/app_preferences.dart';

class LoginViewModel {
  Future<LoginResponse> loginUser({String username, String password, bool returnSecureToken}) async {
    LoginResponse loginResponse;
    try {
      LoginRequest _request = LoginRequest(
        email: username,
        password: password,
        returnSecureToken: returnSecureToken,
      );
      loginResponse = await LoginRepository().loginUser(loginRequest: _request);
    } catch (e) {
      print(e);
    }
    return loginResponse;
  }

  LoginResponse getLoggedInUser() {
    return LoginResponse.fromJson(appPreferences.read(key: AppConstants.PREF_LOGIN_RESPONSE));
  }
}
