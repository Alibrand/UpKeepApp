import 'package:get/get.dart';
import 'package:upkeepapp/helpers/firebase_helper.dart';
import 'package:upkeepapp/model/FireUser.dart';
import 'package:upkeepapp/screens/home_screen.dart';
import 'package:upkeepapp/screens/login_screen.dart';

import '../screens/admin_home_screen.dart';
import 'base_controller.dart';

class AuthController extends BaseController {
  final _fireHelper = FireBaseHelper();

  var currentUser = FireUser().obs;

  userRegisterProfile(FireUser user) async {
    isLoading.value = true;
    fireResponse.value = await _fireHelper.createUserWithEmailPassword(
        user.email, user.password);
    if (fireResponse.value.status == "OK") {
      String uid = fireResponse.value.data;
      Map<String, dynamic> userinfo = user.toMap();
      userinfo.addAll({'user_id': uid});
      fireResponse.value = await _fireHelper.saveUserProfile(userinfo);
      showSnackBar();
      await userSignIn(user.email, user.password);
      return;
    }
    showSnackBar();

    isLoading.value = false;
  }

  userSignIn(String email, String password) async {
    isLoading.value = true;
    fireResponse.value =
        await _fireHelper.signInWithEmailAndPassword(email, password);
    if (fireResponse.value.status == "OK") {
      currentUser.value = fireResponse.value.data;
      showSnackBar();
      Get.to(() => const HomeScreen());
    } else if (fireResponse.value.status == "Admin") {
      Get.to(() => const AdminHomeScreen());
    } else {
      showSnackBar();
    }

    isLoading.value = false;
  }

  userResetPassword(String email) async {
    isLoading.value = true;
    fireResponse.value = await _fireHelper.resetPassword(email);
    showSnackBar();
    isLoading.value = false;
  }

  userSignOut() {
    _fireHelper.signOut();
    Get.offAll(() => const LoginScreen());
  }
}
