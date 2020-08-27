import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
//// User Variables
  String _uid;
  String _fullName;
  String _email;
  List<dynamic> _permissions;

  setUserData(String uid, String fullName, String email, List<dynamic> permissions) {
    _uid = uid;
    _fullName = fullName;
    _email = email;
    _permissions = permissions;

    notifyListeners();
  }

  // Returns the UID for the user
  String get uid {
    return _uid;
  }

//// Returns a string of the users full name
  String get fullName {
    return _fullName;
  }

//// Returns a string of the users email
  String get email {
    return _email;
  }

//// Permissions
  bool permCSM() {
    bool _hasPassed = false;
    _permissions.forEach((element) {
      if (element == 'csm') {
        _hasPassed = true;
      }
    });
    return _hasPassed;
  }

  bool permSermonNotes() {
    bool _hasPassed = false;
    _permissions.forEach((element) {
      if (element == 'sermon-notes') {
        _hasPassed = true;
      }
    });
    return _hasPassed;
  }

  bool permEvents() {
    bool _hasPassed = false;
    _permissions.forEach((element) {
      if (element == 'events') {
        _hasPassed = true;
      }
    });
    return _hasPassed;
  }

  bool permNotices() {
    bool _hasPassed = false;
    _permissions.forEach((element) {
      if (element == 'notices') {
        _hasPassed = true;
      }
    });
    return _hasPassed;
  }

  bool permAdmin() {
    bool _hasPassed = false;
    _permissions.forEach((element) {
      if (element == 'admin') {
        _hasPassed = true;
      }
    });
    return _hasPassed;
  }
}
