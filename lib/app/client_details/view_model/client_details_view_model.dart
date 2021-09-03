import 'package:momentum_bank/app/client_details/model/client_details_repository.dart';
import 'package:momentum_bank/app/client_details/model/client_details_response.dart';

class ClientDetailsViewModel {
  Future<ClientDetailsResponse> fetchClientDetails() async {
    ClientDetailsResponse _response;
    try {
      _response = await ClientDetailsRepository().fetchClientDetails();
    } catch (e) {
      print(e);
    }
    return _response;
  }

  Future updateClientAccounts({List<int> accountList}) async {
    dynamic _response;
    try {
      _response = await ClientDetailsRepository().updateClientAccounts(accountList: accountList);
    } catch (e) {
      print(e);
    }
    return _response;
  }
}
