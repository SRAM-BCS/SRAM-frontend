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
      response.statusCode == 204) {
    dev.log(onSuccessMsg, name: onSuccessMsgTag);
    dev.log(response.statusCode.toString(), name: "Response Status Code");

    onSuccess();
  } else if (response.statusCode == 400 ||
      response.statusCode == 500 ||
      response.statusCode == 501) {
    dev.log(response.statusCode.toString(),
        name: "Response Status Code - Error");
    showToast(msg: "Something went wrong!");
  } else {
    dev.log(response.statusCode.toString(),
        name: "Response Status Code - Error");
    showToast(msg: "Something went wrong!");
  }
}
