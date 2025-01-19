import 'package:fitness/Utils/snack_bar.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/common_widget/round_textfield.dart';
import 'package:fitness/main.dart';
import 'package:fitness/view/login/Repo/login_repo.dart';
import 'package:fitness/view/login/complete_profile_view.dart';
import 'package:fitness/view/login/signup_view.dart';
import 'package:fitness/view/login/what_your_goal_view.dart';
import 'package:fitness/view/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isCheck = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Confirm Exit"),
            content: Text("Do you want to exit?"),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), // Dismiss the dialog
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text("Exit"),
                style: TextButton.styleFrom(
                  foregroundColor:
                      Colors.red, // Optional: Color for Exit button
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await ApiService.loginUser(email, password);

    if (response != null) {
      // Credentials are correct, navigate to the next screen
      prefs.setBool('islogin', true);
      prefs.setString(
          'fullname', response['sFirstName'] + ' ' + response['sLastName']);
      prefs.setString('email', response['sEmail']);
      prefs.setString('gender', response['cGender']);
      prefs.setString('weight', response['fWeight'].toString());
      prefs.setString('height', response['iHeight'].toString());

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => prefs.getString('selectedgoal') == null
              ? WhatYourGoalView()
              : MainTabView(),
        ),
      );
    } else {
      // Show snackbar with error message
      Utils.showSnackBar(
          context, 'Wrong credentials', Colors.red, Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: TColor.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: media.height * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Hey there,",
                    style: TextStyle(color: TColor.gray, fontSize: 16),
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    controller: _emailController,
                    hitText: "Email",
                    icon: "assets/img/email.png",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    controller: _passwordController,
                    hitText: "Password",
                    icon: "assets/img/lock.png",
                    obscureText: true,
                    // rigtIcon: TextButton(
                    //     onPressed: () {},
                    //     child: Container(
                    //         alignment: Alignment.center,
                    //         width: 20,
                    //         height: 20,
                    //         child: Image.asset(
                    //           "assets/img/show_password.png",
                    //           width: 20,
                    //           height: 20,
                    //           fit: BoxFit.contain,
                    //           color: TColor.gray,
                    //         ))),
                    rigtIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.visibility,
                        color: TColor.gray,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot your password?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: TColor.gray,
                            fontSize: 10,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                  const Spacer(),
                  RoundButton(
                      title: "Login",
                      onPressed: () {
                        _login();
                      }),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.,
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        color: TColor.gray.withOpacity(0.5),
                      )),
                      Text(
                        "  Or  ",
                        style: TextStyle(color: TColor.black, fontSize: 12),
                      ),
                      Expanded(
                          child: Container(
                        height: 1,
                        color: TColor.gray.withOpacity(0.5),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {},
                  //       child: Container(
                  //         width: 50,
                  //         height: 50,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           color: TColor.white,
                  //           border: Border.all(
                  //             width: 1,
                  //             color: TColor.gray.withOpacity(0.4),
                  //           ),
                  //           borderRadius: BorderRadius.circular(15),
                  //         ),
                  //         child: Image.asset(
                  //           "assets/img/google.png",
                  //           width: 20,
                  //           height: 20,
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: media.width * 0.04,
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {},
                  //       child: Container(
                  //         width: 50,
                  //         height: 50,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           color: TColor.white,
                  //           border: Border.all(
                  //             width: 1,
                  //             color: TColor.gray.withOpacity(0.4),
                  //           ),
                  //           borderRadius: BorderRadius.circular(15),
                  //         ),
                  //         child: Image.asset(
                  //           "assets/img/facebook.png",
                  //           width: 20,
                  //           height: 20,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: media.width * 0.04,
                  // ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Don’t have an account yet? ",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => SignUpView())));
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
