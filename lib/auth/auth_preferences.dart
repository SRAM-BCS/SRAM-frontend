import 'package:shared_preferences/shared_preferences.dart';
import 'package:summer_project/auth/model/student_user_model.dart';

class UserPreferences {
  void saveUser(StudentUserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("id", user.id as int);
    prefs.setString("name", user.name);
    prefs.setString("email", user.email);
    prefs.setString("batch", user.batch);
  }

  Future<StudentUserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt("id");
    String? name = prefs.getString("name");
    String? email = prefs.getString("email");

    return StudentUserModel(
        name: '',
        rollNo: '',
        batch: '',
        yearOfAddmission: 0,
        password: '',
        profileImage: '',
        id: id.toString(),
        email: '');
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("type");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
