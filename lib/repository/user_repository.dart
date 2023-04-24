

import '../data/network/network_api_services.dart';
import '../res/app_urls.dart';

class UserRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<dynamic> userApi() async {
    dynamic response = await _apiServices.getApi(AppUrls.baseUrl);
    return response;
  }
}
