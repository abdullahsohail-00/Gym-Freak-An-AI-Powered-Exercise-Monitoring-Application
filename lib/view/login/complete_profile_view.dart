// ignore_for_file: use_build_context_synchronously

import 'package:fitness/Utils/base_url.dart';
import 'package:fitness/Utils/snack_bar.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/view/login/what_your_goal_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

class CompleteProfileView extends StatefulWidget {
  CompleteProfileView(
      {super.key,
      required this.Email,
      required this.Firstname,
      required this.Lastname,
      required this.Password});
  String Firstname;
  String Lastname;
  String Email;
  String Password;

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  TextEditingController txtDate = TextEditingController();

  TextEditingController txtWeight = TextEditingController();
  TextEditingController txtHeight = TextEditingController();
  String? selectedGender;
  bool ispressed = false;

  void _register() async {
    String firstName = widget.Firstname;
    String lastName = widget.Lastname;
    String email = widget.Email;
    String password = widget.Password;
    String weight = txtWeight.text;
    String height = txtHeight.text;

    if (selectedGender == null || weight.isEmpty || height.isEmpty) {
      Utils.showSnackBar(
        context,
        'Please fill out all fields',
        Colors.red,
        Colors.white,
      );
      return;
    }
    setState(() {
      ispressed = true;
    });

    Map<String, String> queryParams = {
      'First': firstName,
      'Last': lastName,
      'Email': email,
      'Password': password,
      'Gender': selectedGender!,
      'Weight': weight,
      'Height': height,
    };

    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = '${BaseURL}Hdl_SignUp.ashx?$queryString';

    try {
      var response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        setState(() {
          ispressed = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WhatYourGoalView(),
          ),
        );
      } else {
        setState(() {
          ispressed = false;
        });
        Utils.showSnackBar(
          context,
          'Something went wrong',
          Colors.red,
          Colors.white,
        );
      }
    } catch (e) {
      setState(() {
        ispressed = false;
      });
      Utils.showSnackBar(
        context,
        'Something went wrong',
        Colors.red,
        Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/img/complete_profile.png",
                  width: media.width,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  "Let’s complete your profile",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "It will help us to know more about you!",
                  style: TextStyle(color: TColor.gray, fontSize: 12),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: TColor.lightGray,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset(
                                  "assets/img/gender.png",
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                  color: TColor.gray,
                                )),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  items: ["Male", "Female"]
                                      .map((name) => DropdownMenuItem(
                                            value: name,
                                            child: Text(
                                              name,
                                              style: TextStyle(
                                                  color: TColor.gray,
                                                  fontSize: 14),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                  isExpanded: true,
                                  hint: Text(
                                    "Choose Gender",
                                    style: TextStyle(
                                        color: TColor.gray, fontSize: 12),
                                  ),
                                  value: selectedGender,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: media.width * 0.04,
                      // ),
                      // RoundTextField(
                      //   controller: txtDate,
                      //   hitText: "Date of Birth",
                      //   icon: "assets/img/date.png",
                      // ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextField(
                              keyboardType: TextInputType.phone,
                              controller: txtWeight,
                              hitText: "Your Weight",
                              icon: "assets/img/weight.png",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: TColor.secondaryG,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "KG",
                              style:
                                  TextStyle(color: TColor.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextField(
                              keyboardType: TextInputType.phone,
                              controller: txtHeight,
                              hitText: "Your Height",
                              icon: "assets/img/hight.png",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: TColor.secondaryG,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "CM",
                              style:
                                  TextStyle(color: TColor.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.07,
                      ),
                      ispressed
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                            )
                          : RoundButton(
                              title: "Next >",
                              onPressed: () {
                                _register();
                              }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
