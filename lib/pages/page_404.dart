import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Page404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "找不到相应页面",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "关闭",
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
