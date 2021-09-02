import 'dart:io';

import 'package:momentum_bank/app/login/model/login_response.dart';
import 'package:momentum_bank/app/login/view_model/login_view_model.dart';
import 'package:momentum_bank/app/utils/apis/app_exception.dart';
import 'package:momentum_bank/app/utils/apis/process_api_response.dart';
import 'package:momentum_bank/app/utils/app_constants.dart';
import 'package:momentum_bank/app/utils/base_service.dart';

class ClientDetailsService extends BaseService {
  Future fetchClientDetails() async {
    dynamic responseJson;
    try {
      LoginResponse _loginResponse = LoginViewModel().getLoggedInUser();
      String _url = '${AppConstants.API_BASE_CLIENT_URL}${_loginResponse.localId}.json?auth=${_loginResponse.idToken}';
      print(AppConstants.API_BASE_CLIENT_URL);
      print('request: $_url');

      final response = await client.get(
        Uri.parse(_url),
      );
      responseJson = ProcessApiResponse().returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
}
