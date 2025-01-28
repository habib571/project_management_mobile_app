import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/responses/api_response.dart';
import '../constants/constants.dart';

Future<ApiResponse> executeGetRequest<ApiResponse>({
  required String apiUrl,
  String? bearerToken,
  bool decodeResult = true,
  required ApiResponse Function(dynamic result ,int statusCode) onRequestResponse,
  void Function(int statusCode, String responseBody)? onError,
}) async {
  final response = await http.get(
    Uri.parse(Constants.baseUrl + apiUrl),
    headers: <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
      if (bearerToken != null) 'Authorization': 'Bearer $bearerToken'
    },
  );

  final jsonResult = decodeResult
      ? jsonDecode(response.body)
      : response.body;
  int statusCode = response.statusCode;
  return onRequestResponse(jsonResult ,statusCode);
}

Future<ApiResponse> executePostRequest<ApiResponse>({
  required String apiUrl,
  Map<String, dynamic>? body,
  String? bearerToken,
  required ApiResponse Function(dynamic result, int statusCode)
  onRequestResponse,
}) async {
  final requestBody = body != null ? jsonEncode(body) : null;
  final response = await http.post(
    Uri.parse(Constants.baseUrl + apiUrl),
    headers: <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
      if (bearerToken != null) 'Authorization': 'Bearer $bearerToken'
    },
    body: requestBody
  );

  final jsonResult = jsonDecode(response.body);
  int statusCode = response.statusCode;
  return onRequestResponse(jsonResult ,statusCode);
}

Future<ApiResponse> executePatchRequest<ApiResponse>({
  required String apiUrl,
  Map<String,dynamic>? body,
  String? bearerToken,
  required ApiResponse Function(dynamic result, int statusCode) onRequestResponse,
}) async {
  final requestBody = body != null ? jsonEncode(body) : null;
  final response = await http.patch(
    Uri.parse(Constants.baseUrl + apiUrl),
    headers: <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
      if (bearerToken != null) 'Authorization': 'Bearer $bearerToken'
    },
    body: requestBody
  );
  final jsonResult = jsonDecode(response.body);
  int statusCode = response.statusCode;
  return onRequestResponse(jsonResult ,statusCode);
}
