// here we will perform httt requests , using various API for the current price in usdt or any other currency
// 'https://api.coingecko.com/api/v3/coins/


import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getPrice(String id)async{

try{
  String url=   'https://api.coingecko.com/api/v3/coins/'+id;
   
  var response= await http.get(Uri.parse(url));
  var json= jsonDecode(response.body);
  log(json.toString());
  var value= json["market_data"]["current_price"]["usd"].toString();

  return double.parse(value); 
}
catch(e){

print(e.toString());
return 0.0;

}


}