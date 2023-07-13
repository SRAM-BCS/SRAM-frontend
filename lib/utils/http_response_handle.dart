import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import '../common/widgets/toast.dart';

void httpResponseHandle({
  required String onSuccessMsgTag,
  required String onSuccessMsg,
  required http.Response response,
  required VoidCallback onSuccess,
}) {
  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 204 ||
      response.statusCode == 202) {
    dev.log(onSuccessMsg, name: onSuccessMsgTag);
    dev.log(response.statusCode.toString(), name: "Response Status Code");
    dev.log(response.body, name: "Response Body");

    onSuccess();
  } else if (response.statusCode == 400 ||
      response.statusCode == 401 ||
      response.statusCode == 404 ||
      response.statusCode == 405 ||
      response.statusCode == 500 ||
      response.statusCode == 415) {
    dev.log(response.statusCode.toString(),
        name: "Response Status Code - Error");
    dev.log(response.body, name: "Response Body - Error");
    showToast(
        msg: jsonDecode(response.body)['message'] ??
            "Something went wrong! Please try again later.");
  } else {
    dev.log(response.statusCode.toString(),
        name: "Response Status Code - Error");
    showToast(msg: "Something went wrong!");
  }
}
