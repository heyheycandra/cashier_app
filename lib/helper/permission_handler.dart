import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  // final PermissionHandler _permissionHandler = PermissionHandler();

  // Future<bool> _requestPermission(PermissionGroup permission) async {
  //   var status = await _permissionHandler.checkPermissionStatus(permission);

  //   if (status != PermissionStatus.granted) {
  //     await _permissionHandler.requestPermissions([permission]);
  //     status = await _permissionHandler.checkPermissionStatus(permission);
  //   }

  //   return status == PermissionStatus.granted;
  // }

  // /// Requests the users permission to read their location when the app is in use
  // Future<bool> requestLocationPermission() async {
  //   // return _requestPermission(PermissionGroup.locationWhenInUse);
  //   return await Permission.locationWhenInUse.serviceStatus.isEnabled;
  // }

  /// Requests the users permission to read their contacts.
  Future<bool> requestContactsPermission({Function()? onPermissionDenied}) async {
    //var granted = await _requestPermission(PermissionGroup.contacts);
    var granted = await Permission.contacts.shouldShowRequestRationale;
    if (!granted && onPermissionDenied != null) {
      onPermissionDenied();
    }
    return granted;
  }

  Future<bool> requestStoragePermission({Function()? onPermissionDenied}) async {
    // var granted = await _requestPermission(PermissionGroup.storage);
    // if (await Permission.storage.request().isGranted) {
    //   setState(() {
    //     permissionGranted = true;
    //   });
    // } else if (await Permission.storage.request().isPermanentlyDenied) {
    //   await openAppSettings();
    // } else if (await Permission.storage.request().isDenied) {
    //   setState(() {
    //     permissionGranted = false;
    //   });
    // }

    late PermissionStatus status;
    await Permission.storage.request().then((result) {
      status = result;
    });
    // = await Permission.storage.status;
    if (status.isDenied && onPermissionDenied != null) {
      onPermissionDenied();
      // return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return status.isGranted;
  }

  Future<bool> requestNotifPermission({Function()? onPermissionDenied}) async {
    // var granted = await _requestPermission(PermissionGroup.storage);
    var granted = await Permission.notification.status;
    if (granted.isDenied && onPermissionDenied != null) {
      onPermissionDenied();
      return false;
    }
    return true;
  }

  Future<bool> requestCameraPermission({Function()? onPermissionDenied}) async {
    // var granted = await _requestPermission(PermissionGroup.camera);
    var granted = await Permission.camera.status;
    // if (!granted) {
    if (granted.isDenied && onPermissionDenied != null) {
      onPermissionDenied();
      return false;
    }
    return true;
  }
}
