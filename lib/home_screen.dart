import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/api.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<TextEditingController> controllers = [];


// api hitting function 
  Future<void> getStockReport() async {
    try {
      final _api = Api();

      var body = {
        {
          "latLong": "1:12:2,21:1:3",
          "deviceId": "AC-ED-5C-67-68-17",
          "deviceName": "Mobile",
          "pin": "1212",
          "mode": "Android",
          "merchantID": "14",
          "branch_id": "1",
          "active": "A"
        }
      };

      ApiResponse response = await _api.sendRequest
              .post('/api/v1/report/getStockReport', data: jsonEncode(body))
          as ApiResponse;

      print(response.respString);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getStockReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            children: [
              buildTextField(),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      // if we want to make dynamic number of Textfiled rather than only 5 text field
                      controllers.add(TextEditingController());
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Text("Add more"),
                  )),
              SizedBox(
                height: 30,
              ),
              showTextFieldValue()
            ],
          ),
        ),
      )),
    );
  }

  Widget buildTextField() {
    return Column(
      // in place of lenght use contollers.lengh if you want to make it dynamic rather than only 5
      children: List.generate(5, (index) {
        controllers.add(TextEditingController());
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextField(
            controller: controllers[index],
          ),
        );
      }),
    );
  }

  Widget showTextFieldValue() {
    return Column(
      children: List.generate(controllers.length, (index) {
        return Container(
          child: Column(
            children: [
              Text("$index value"),
              SizedBox(
                height: 10,
              ),
              Text(controllers[index].text.trim())
            ],
          ),
        );
      }),
    );
  }
}
