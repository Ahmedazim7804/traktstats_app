import 'package:traktstats/provider/operationMode.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<T?> getDataFromApi<T>(String endpoint) async {
  String baseurl = Model.baseurl;
  var response = await http.get(Uri.parse('$baseurl/$endpoint'));
  
  if (T != String) {
    final data = jsonDecode(response.body);
    return data;
  }
  return response.body as T;
}

T? getDataFromFile<T>(String endpoint) {
  List<String> nested = endpoint.split('/');

  dynamic data;
  for (String element in nested) {
    if (data == null) {
      data = Model.fileData[element];
    } else {
      data = data[element];
    }
  }
  
  return data as T;
}

Future<T> getData<T>(String endpoint) async {
  if (Model.operationMode == OperationModes.file) {
    return getDataFromFile(endpoint);
  }
  else {
    final aa = await getDataFromApi<T>(endpoint);
    return aa as T;
  }
}