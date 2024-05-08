import 'package:dio/dio.dart';

import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  final Dio _dio = Dio();

  static const baseUrl = 'https://paytelrms.com';

  final Map<String, dynamic> headers = {"Content-type": "application/json"};

  Api() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = headers;
  }

  Dio get sendRequest => _dio;
}

class ApiResponse {
  String? respcode;
  String? respmsg;
  List<RespString>? respString;

  ApiResponse({this.respcode, this.respmsg, this.respString});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    respcode = json['respcode'];
    respmsg = json['respmsg'];
    if (json['respString'] != null) {
      respString = <RespString>[];
      json['respString'].forEach((v) {
        respString!.add(new RespString.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respcode'] = this.respcode;
    data['respmsg'] = this.respmsg;
    if (this.respString != null) {
      data['respString'] = this.respString!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RespString {
  String? itemId;
  String? itemName;
  String? itemPrice;
  String? dietary;
  String? itemCode;
  String? variation;
  String? combo;
  String? addons;
  String? stockStatus;

  RespString(
      {this.itemId,
      this.itemName,
      this.itemPrice,
      this.dietary,
      this.itemCode,
      this.variation,
      this.combo,
      this.addons,
      this.stockStatus});

  RespString.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    dietary = json['dietary'];
    itemCode = json['item_code'];
    variation = json['variation'];
    combo = json['combo'];
    addons = json['addons'];
    stockStatus = json['stock_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['item_price'] = this.itemPrice;
    data['dietary'] = this.dietary;
    data['item_code'] = this.itemCode;
    data['variation'] = this.variation;
    data['combo'] = this.combo;
    data['addons'] = this.addons;
    data['stock_status'] = this.stockStatus;
    return data;
  }
}
