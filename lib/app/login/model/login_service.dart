import 'dart:convert';
import 'dart:io';

import 'package:momentum_bank/app/utils/apis/app_exception.dart';
import 'package:momentum_bank/app/utils/apis/process_api_response.dart';
import 'package:momentum_bank/app/utils/app_constants.dart';
import 'package:momentum_bank/app/utils/base_service.dart';

import 'login_request.dart';

class LoginService with BaseService {
  Future loginUser({LoginRequest loginRequest}) async {
    dynamic responseJson;
    try {
      print(AppConstants.API_LOGIN_USER);
      print('request: ' + json.encode(loginRequest));

      final response = await client.post(
        Uri.parse(AppConstants.API_LOGIN_USER),
        headers: {"content-type": "application/json"},
        body: jsonEncode(
          loginRequest.toJson(),
        ),
      );
      responseJson = ProcessApiResponse().returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
}
