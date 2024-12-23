import 'dart:async';
import 'package:dio/dio.dart';

class GetApi{

Future getApiData(idQuote, idBase) async {

final String api = 'https://rest.coinapi.io/v1/exchangerate/$idBase/$idQuote?apikey=d0e0bb2a-6367-4a39-8154-c6f518b0d905';

Dio dio = Dio();

try{
  Response response = await dio.get(api);

  if(response.statusCode == 200){
    print('Status: 200');

    double rate = response.data['rate'];

    print('rate: $rate');
    print('idBase: $idBase');
    print('idQuote: $idQuote');

    return {
      'rate': rate,
      'idBase': idBase,
      'idQuote': idQuote
    };
   
  } 

} catch(e){
  print('Error: $e');
}

}


}
  





