// import 'package:cashier_app_mobile/helper/app_exception.dart';
import 'package:cashier_app_mobile/services/api_url.dart';
import 'package:cashier_app_mobile/services/net_util.dart';
import 'package:flutter/foundation.dart';

class RestApi extends UrlApi {
  final NetworkUtil _util = NetworkUtil();
  Future<dynamic> register({required Map<String, dynamic> body}) {
    return _util
        .post(auth + '/signup',
            headers: {
              // 'accept': 'aplication/json',
              'accept': '*/*',
              'Content-Type': 'aplication/json',
              'X-CSRF-TOKEN': '',
            },
            body: body)
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    });
  }

  Future<dynamic> login({required Map<String, dynamic> body}) {
    return _util
        .post(auth + '/signin',
            headers: {
              'accept': 'aplication/json',
              // 'accept': '*/*',
              // 'Content-Type': 'aplication/json',
              'X-CSRF-TOKEN': '',
            },
            body: body)
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value['data'];
    });
  }

  Future<dynamic> logout({required Map<String, dynamic> body, required String token}) {
    return _util
        .post(auth + '/logout',
            headers: {
              'accept': 'aplication/json',
              // 'accept': '*/*',
              // 'Content-Type': 'aplication/json',
              'X-CSRF-TOKEN': '',
              'Authorization': token,
            },
            body: body)
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    });
  }

  Future<dynamic> getUser({required String token}) {
    return _util.get(
      user,
      headers: {
        'accept': 'aplication/json',
        // 'accept': '*/*',
        // 'Content-Type': 'aplication/json',
        'X-CSRF-TOKEN': '',
        'Authorization': token,
      },
    ).then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    });
  }

  Future<dynamic> addTransaction({
    required String token,
    required Map<String, dynamic> body,
  }) {
    return _util
        .post(
      transaction + '/tambah',
      headers: {
        'accept': 'aplication/json',
        // 'accept': '*/*',
        // 'Content-Type': 'aplication/json',
        'X-CSRF-TOKEN': '',
        'Authorization': token,
      },
      body: body,
    )
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value['data'];
    });
  }

  Future<dynamic> transactionHistory({
    required String token,
    required String userId,
  }) {
    return _util.get(
      transaction + '/$userId/semua',
      headers: {
        'accept': 'aplication/json',
        // 'accept': '*/*',
        // 'Content-Type': 'aplication/json',
        'X-CSRF-TOKEN': '',
        'Authorization': token,
      },
    ).then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value['data'];
    });
  }

  Future<dynamic> activeTransactions({
    required String token,
    required Map<String, dynamic> body,
  }) {
    return _util
        .post(
      transaction + '/tiket-aktif',
      headers: {
        'accept': 'aplication/json',
        // 'accept': '*/*',
        // 'Content-Type': 'aplication/json',
        'X-CSRF-TOKEN': '',
        'Authorization': token,
      },
      body: body,
    )
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value['data'];
    });
  }

  Future<dynamic> getAllProducts({
    required String token,
    required String userId,
  }) {
    return _util.get(
      baseUrl + '/semua-paket',
      headers: {
        'accept': 'aplication/json',
        // 'accept': '*/*',
        // 'Content-Type': 'aplication/json',
        'X-CSRF-TOKEN': '',
        'Authorization': token,
      },
    ).then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value['data'];
    });
  }

  Future<dynamic> updateProfile({
    required String token,
    required Map<String, dynamic> body,
  }) {
    return _util
        .post(auth + '/update-profile',
            headers: {
              // 'accept': 'aplication/json',
              'accept': '*/*',
              'Content-Type': 'aplication/json',
              'X-CSRF-TOKEN': '',
              'Authorization': token,
            },
            body: body)
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    });
  }

  Future<dynamic> updatePassword({
    required String token,
    required Map<String, dynamic> body,
  }) {
    return _util
        .post(auth + '/change-password',
            headers: {
              // 'accept': 'aplication/json',
              'accept': '*/*',
              'Content-Type': 'aplication/json',
              'X-CSRF-TOKEN': '',
              'Authorization': token,
            },
            body: body)
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    });
  }

  Future<dynamic> deleteSingleHist({
    required String token,
    required String cartId,
  }) {
    return _util.delete(
      transaction + '/$cartId/delete',
      headers: {
        // 'accept': 'aplication/json',
        'accept': '*/*',
        'Content-Type': 'aplication/json',
        'X-CSRF-TOKEN': '',
        'Authorization': token,
      },
    ).then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    });
  }

  Future<dynamic> statusDetail({required String token, required String kodeTransaksi}) {
    return _util.get(
      transaction + '/$kodeTransaksi/status',
      headers: {
        // 'accept': 'aplication/json',
        'accept': '*/*',
        'Content-Type': 'aplication/json',
        'X-CSRF-TOKEN': '',
        'Authorization': token,
      },
    ).then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    });
  }

  Future<dynamic> payLater({required String token, required Map<String, dynamic> body}) {
    return _util
        .post(
      transaction + '/paylater',
      headers: {
        // 'accept': 'aplication/json',
        'accept': '*/*',
        'Content-Type': 'aplication/json',
        'X-CSRF-TOKEN': '',
        'Authorization': token,
      },
      body: body,
    )
        .then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      return value['data'];
    });
  }
}
