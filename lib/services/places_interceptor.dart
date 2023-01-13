
import 'package:dio/dio.dart';


const accessToken= 'pk.eyJ1Ijoid2lsbXhyMjAiLCJhIjoiY2xjcDUybnZ1MWhrMTNxcjBhbG1vNnl3MiJ9.ivXPRVMZtids54Fo_2oXCQ';


class PlacesInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
    'access_token':accessToken,
    'language': 'es',
    });





    super.onRequest(options, handler);
  }



}