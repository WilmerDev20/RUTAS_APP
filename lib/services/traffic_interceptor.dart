
import 'package:dio/dio.dart';


const accesToken='pk.eyJ1Ijoid2lsbXhyMjAiLCJhIjoiY2xjcDUybnZ1MWhrMTNxcjBhbG1vNnl3MiJ9.ivXPRVMZtids54Fo_2oXCQ';
class TrafficInterceptor extends Interceptor{

@override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({ 
      'alternatives':true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accesToken,
    });
    super.onRequest(options, handler);
  }

}