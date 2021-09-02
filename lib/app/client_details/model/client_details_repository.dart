import 'client_details_response.dart';
import 'client_details_service.dart';

class ClientDetailsRepository {
  ClientDetailsService _service = ClientDetailsService();

  Future<ClientDetailsResponse> fetchClientDetails() async {
    dynamic response = await _service.fetchClientDetails();
    return ClientDetailsResponse.fromJson(response);
  }
}
