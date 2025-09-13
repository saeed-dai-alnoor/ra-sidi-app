import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetController extends GetxController {
  var connectionStatus = 0.obs; // 0 = لا يوجد اتصال، 1 = WiFi، 2 = Mobile
  var hasInternet = false.obs;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<InternetConnectionStatus>? _internetCheckerSubscription;

  // لمنع تكرار Snackbar
  bool _isSnackbarVisible = false;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    _internetCheckerSubscription?.cancel();
    super.onClose();
  }

  Future<void> initConnectivity() async {
    try {
      // تأخير بسيط للتأكد من جاهزية الشبكة
      await Future.delayed(const Duration(milliseconds: 500));

      // فحص الإنترنت الفعلي عند البداية
      bool isConnected = await InternetConnectionChecker.instance.hasConnection;
      hasInternet.value = isConnected;

      // تحديث نوع الشبكة
      List<ConnectivityResult> results = await _connectivity
          .checkConnectivity();
      if (results.isNotEmpty) {
        _updateConnectionStatus(results.first);
      }

      // الاشتراك في تغييرات الشبكة
      _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
        results,
      ) {
        if (results.isNotEmpty) {
          _updateConnectionStatus(results.first);
        }
      });

      // الاشتراك في تغييرات الإنترنت الفعلي
      _internetCheckerSubscription = InternetConnectionChecker
          .instance
          .onStatusChange
          .listen((status) async {
            bool actualConnection =
                await InternetConnectionChecker.instance.hasConnection;
            hasInternet.value = actualConnection;

            // عرض Snackbar فقط إذا كان التغيير حقيقي
            if (!actualConnection ||
                status == InternetConnectionStatus.connected) {
              _showSnackBar(status, actualConnection);
            }
          });
    } catch (e) {
      // print("Error checking connectivity: $e");
      connectionStatus.value = 0;
      hasInternet.value = false;
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      default:
        connectionStatus.value = 0;
        break;
    }
  }

  void _showSnackBar(InternetConnectionStatus status, bool actualConnection) {
    if (_isSnackbarVisible) return;
    if (Get.context == null) return;

    // لا تظهر No Internet إذا كان الانترنت فعليًا موجود
    if (status == InternetConnectionStatus.disconnected && actualConnection) {
      return;
    }

    _isSnackbarVisible = true;

    if (status == InternetConnectionStatus.disconnected) {
      Get.snackbar(
        "لا يوجد إنترنت",
        "أنت حالياً غير متصل بالإنترنت",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(0),
      );
    } else if (status == InternetConnectionStatus.connected) {
      Get.snackbar(
        "تم استعادة الاتصال",
        "أنت الآن متصل بالإنترنت",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(0),
      );
    }

    Future.delayed(const Duration(seconds: 3), () {
      _isSnackbarVisible = false;
    });
  }
}
