import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

Future<ApiResponse> executePutRequest<ApiResponse>({
  required String apiUrl,
  Map<String,dynamic>? body,
  String? bearerToken,
  required ApiResponse Function(dynamic result, int statusCode) onRequestResponse,
}) async {
  final requestBody = body != null ? jsonEncode(body) : null;
  final response = await http.put(
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

Future<ApiResponse> executePutImageRequest<ApiResponse>({
  required String apiUrl,
  required XFile imageFile,
  String? bearerToken,
  required ApiResponse Function(dynamic result, int statusCode) onRequestResponse,
}) async {

    final uri = Uri.parse(Constants.baseUrl + apiUrl);
    final request = http.MultipartRequest('PUT', uri);
    request.headers['Accept'] = 'application/json';
    if (bearerToken != null) {
      request.headers['Authorization'] = 'Bearer $bearerToken';
    }

    final file = await http.MultipartFile.fromPath(
      'file',
      imageFile.path,
    );
    request.files.add(file);

    final response = await http.Response.fromStream(await request.send());
    final jsonResult = jsonDecode(response.body);
    return onRequestResponse(jsonResult, response.statusCode);
}

Future<ApiResponse> executeDeleteRequest<ApiResponse>({
  required String apiUrl,
  String? bearerToken,
  required ApiResponse Function(dynamic result, int statusCode) onRequestResponse,
}) async {
  final response = await http.delete(
      Uri.parse(Constants.baseUrl + apiUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
        if (bearerToken != null) 'Authorization': 'Bearer $bearerToken'
      },
  );
  final jsonResult = response.body;
  int statusCode = response.statusCode;
  return onRequestResponse(jsonResult ,statusCode);

}
