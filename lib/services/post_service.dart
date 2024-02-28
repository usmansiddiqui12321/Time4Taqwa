import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/models/create_donation_model.dart';

class PostService {
  Future<CreatePostModel> createPost({
    required String title,
    required String amount,
    required String mosqueName,
    required String description,
    required String email,
    required List<File?> images,
  }) async {
    var url = Uri.parse(AppUrls.createpost);
    var request = http.MultipartRequest('POST', url);
    for (int i = 0; i < images.length; i++) {
      var multipartFile = await http.MultipartFile.fromPath(
        'images[]',
        images[i]!.path,
        filename: images[i]!.path.split('/').last,
        contentType: MediaType(
          'image',
          images[i]!.path.split('.').last,
        ),
      );
      request.files.add(multipartFile);
    }
    request.fields['title'] = title;
    request.fields['amount'] = amount;
    request.fields['mosqueName'] = mosqueName;
    request.fields['email'] = email;
    request.fields['description'] = description;
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonData = jsonDecode(response.body);
    var message = jsonData['message'];
    log("Api Called: $url");
    log("status: ${response.statusCode}");
    log("Api Response: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CreatePostModel.fromJson(jsonData);
    } else {
      log("From Post Service");
      CustomWidgets.customsnackbar(
          message: "Something went wrong", isError: true);
      throw message;
    }
  }

  Future<void> editPost({
    required String title,
    required String amount,
    required String mosqueName,
    required String description,
    required String postId,
    required String email,
    required List images,
  }) async {
    var url = Uri.parse('${AppUrls.editpost}$postId');
    var request = http.MultipartRequest('PUT', url);

    for (int i = 0; i < images.length; i++) {
      if (images[i] is String) {
        request.fields['images[$i]'] = images[i].toString();
      } else if (images[i] is File) {
        var multipartFile = await http.MultipartFile.fromPath(
          'images[]',
          images[i].path,
          filename: images[i].path.split('/').last,
          contentType: MediaType(
            'image',
            images[i].path.split('.').last,
          ),
        );
        request.files.add(multipartFile);
      }
    }

    // Set fields outside the loop
    request.fields['title'] = title;
    request.fields['amount'] = amount;
    request.fields['mosqueName'] = mosqueName;
    request.fields['email'] = email;
    request.fields['description'] = description;

    // request.headers.addAll(header);

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var jsonData = jsonDecode(response.body);
      var message = jsonData['message'];
      log("Api Called: $url");
      log("status: ${response.statusCode}");
      log("Api Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // return CreatePostModel.fromJson(jsonData);
      } else {
        log("From Post Service");
        CustomWidgets.customsnackbar(
          message: "Something went wrong",
          isError: true,
        );
        throw message;
      }
    } catch (error) {
      // Handle exceptions
      if (kDebugMode) {
        print("Error: $error");
      }
      CustomWidgets.customsnackbar(
        message: "Error: $error",
        isError: true,
      );
      rethrow;
    }
  }

  Future<String?> deletePostservice({required id}) async {
    var url = Uri.parse('${AppUrls.deletedonationurl}$id');
    var response = await http.delete(url);
    var jsonData = jsonDecode(response.body);
    log("Api Called: $url");
    log("status: ${response.statusCode}");
    log("Api Response: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      CustomWidgets.customsnackbar(
          message: "Deleted Successfully", isError: false);
      return jsonData.toString();
    } else {
      CustomWidgets.customsnackbar(
          message: "Something went wrong", isError: true);

      log("From delete${response.statusCode}");
      // throw jsonData['succ'];
    }
    return null;
  }
}
