import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestPermissions(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    for (var permission in permissions) {
      if (statuses[permission] != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<bool> hasRequiredPermissions(List<Permission> permissions) async {
    for (var permission in permissions) {
      PermissionStatus permissionStatus = await permission.status;
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<bool> requestCameraPermission() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.request();
    if (cameraPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestMicrophonePermission() async {
    PermissionStatus microphonePermissionStatus =
        await Permission.microphone.request();
    if (microphonePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestLocationPermission() async {
    PermissionStatus locationPermissionStatus =
        await Permission.location.request();
    if (locationPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestStoragePermission() async {
    PermissionStatus storagePermissionStatus =
        await Permission.storage.request();
    if (storagePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestCalendarPermission() async {
    PermissionStatus calendarPermissionStatus =
        await Permission.calendar.request();
    if (calendarPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestContactsPermission() async {
    PermissionStatus contactsPermissionStatus =
        await Permission.contacts.request();
    if (contactsPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestPhonePermission() async {
    PermissionStatus phonePermissionStatus = await Permission.phone.request();
    if (phonePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestSensorsPermission() async {
    PermissionStatus sensorsPermissionStatus =
        await Permission.sensors.request();
    if (sensorsPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestSMSPermission() async {
    PermissionStatus smsPermissionStatus = await Permission.sms.request();
    if (smsPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestSpeechPermission() async {
    PermissionStatus speechPermissionStatus = await Permission.speech.request();
    if (speechPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestLocationAlwaysPermission() async {
    PermissionStatus locationAlwaysPermissionStatus =
        await Permission.locationAlways.request();
    if (locationAlwaysPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestLocationWhenInUsePermission() async {
    PermissionStatus locationWhenInUsePermissionStatus =
        await Permission.locationWhenInUse.request();
    if (locationWhenInUsePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestBluetoothPermission() async {
    PermissionStatus bluetoothPermissionStatus =
        await Permission.bluetooth.request();
    if (bluetoothPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestRemindersPermission() async {
    PermissionStatus locationAccuracyPermissionStatus =
        await Permission.reminders.request();
    if (locationAccuracyPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestMediaLibraryPermission() async {
    PermissionStatus mediaLibraryPermissionStatus =
        await Permission.mediaLibrary.request();
    if (mediaLibraryPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasCameraPermission() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;
    if (cameraPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasMicrophonePermission() async {
    PermissionStatus microphonePermissionStatus =
        await Permission.microphone.status;
    if (microphonePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasLocationPermission() async {
    PermissionStatus locationPermissionStatus =
        await Permission.location.status;
    if (locationPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasStoragePermission() async {
    PermissionStatus storagePermissionStatus = await Permission.storage.status;
    if (storagePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasCalendarPermission() async {
    PermissionStatus calendarPermissionStatus =
        await Permission.calendar.status;
    if (calendarPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasContactsPermission() async {
    PermissionStatus contactsPermissionStatus =
        await Permission.contacts.status;
    if (contactsPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasPhonePermission() async {
    PermissionStatus phonePermissionStatus = await Permission.phone.status;
    if (phonePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasSensorsPermission() async {
    PermissionStatus sensorsPermissionStatus = await Permission.sensors.status;
    if (sensorsPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasSMSPermission() async {
    PermissionStatus smsPermissionStatus = await Permission.sms.status;
    if (smsPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasSpeechPermission() async {
    PermissionStatus speechPermissionStatus = await Permission.speech.status;
    if (speechPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasLocationAlwaysPermission() async {
    PermissionStatus locationAlwaysPermissionStatus =
        await Permission.locationAlways.status;
    if (locationAlwaysPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasLocationWhenInUsePermission() async {
    PermissionStatus locationWhenInUsePermissionStatus =
        await Permission.locationWhenInUse.status;
    if (locationWhenInUsePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasBluetoothPermission() async {
    PermissionStatus bluetoothPermissionStatus =
        await Permission.bluetooth.status;
    if (bluetoothPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasRemindersPermission() async {
    PermissionStatus locationAccuracyPermissionStatus =
        await Permission.reminders.status;
    if (locationAccuracyPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasMediaLibraryPermission() async {
    PermissionStatus mediaLibraryPermissionStatus =
        await Permission.mediaLibrary.status;
    if (mediaLibraryPermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
