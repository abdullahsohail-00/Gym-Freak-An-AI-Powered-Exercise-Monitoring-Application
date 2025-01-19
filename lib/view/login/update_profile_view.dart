import 'dart:convert';
import 'package:fitness/Utils/base_url.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/common_widget/round_textfield.dart';
import 'package:fitness/main.dart';
import 'package:fitness/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Utils/snack_bar.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  bool ispressed = false;

  String? _selectedGender;
  List<String> genders = ["M", "F"];
  bool _isPasswordVisible = false;

  bool isCheck = false;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    final response = await http.get(
      Uri.parse(BaseURL + 'Hdl_Profile.ashx?email=${prefs.getString('email')}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isNotEmpty) {
        setState(() {
          _firstname.text = data[0]['sFirstName'];
          _lastname.text = data[0]['sLastName'];
          _email.text = data[0]['sEmail'];
          _password.text = data[0]['sPassword'];
          _selectedGender = data[0]['cGender'];
          _weightController.text = data[0]['fWeight'].toString();
          _heightController.text = data[0]['iHeight'].toString();
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to fetch data"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void deleteprof() async {
    setState(() {
      ispressed = true;
    });
    final response = await http.get(
      Uri.parse(BaseURL + 'Hdl_delete.ashx?email=${prefs.getString('email')}'),
    );
    if (response.statusCode == 200) {
      _updateprofile();
    } else {
      setState(() {
        ispressed = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something Went Wrong please try again"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _updateprofile() async {
    setState(() {
      ispressed = true;
    });

    Map<String, String> queryParams = {
      'First': _firstname.text,
      'Last': _lastname.text,
      'Email': _email.text,
      'Password': _password.text,
      'Gender': _selectedGender!,
      'Weight': _weightController.text,
      'Height': _heightController.text,
    };

    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = '${BaseURL}Hdl_SignUp.ashx?$queryString';

    try {
      var response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        setState(() {
          ispressed = false;
        });
        Utils.showSnackBar(
          context,
          'Please Login to Update Profile',
          Colors.red,
          Colors.white,
        );
        prefs.setBool('islogin', false);
        prefs.setString('fullname', "");
        prefs.setString('email', "");
        prefs.setString('gender', "");
        prefs.setString('weight', "");
        prefs.setString('height', "");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginView()));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Update Profile",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                RoundTextField(
                  controller: _firstname,
                  hitText: "First Name",
                  icon: "assets/img/user_text.png",
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  controller: _lastname,
                  hitText: "Last Name",
                  icon: "assets/img/user_text.png",
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  controller: _email,
                  hitText: "Email",
                  icon: "assets/img/email.png",
                  keyboardType: TextInputType.emailAddress,
                  enabled: false, // Email should not be editable for update
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                // Gender Dropdown
                // DropdownButtonHideUnderline(
                //   child: DropdownButton(
                //     items: ["Male", "Female"]
                //         .map((name) => DropdownMenuItem(
                //               value: name,
                //               child: Text(
                //                 name,
                //                 style:
                //                     TextStyle(color: TColor.gray, fontSize: 14),
                //               ),
                //             ))
                //         .toList(),
                //     onChanged: (value) {
                //       setState(() {
                //         _selectedGender = value;
                //       });
                //     },
                //     isExpanded: true,
                //     hint: Text(
                //       "Choose Gender",
                //       style: TextStyle(color: TColor.gray, fontSize: 12),
                //     ),
                //     value: _selectedGender,
                //   ),
                // ),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: TColor.gray),
                    ),
                    filled: true,
                    fillColor: TColor.gray.withOpacity(0.1),
                  ),
                  hint: Text("Gender"),
                  items: genders.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                // Height TextField
                RoundTextField(
                  controller: _heightController,
                  hitText: "Height (cm)",
                  icon: "assets/img/hight.png",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                // Weight TextField
                RoundTextField(
                  controller: _weightController,
                  hitText: "Weight (kg)",
                  icon: "assets/img/weight.png",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                // Weight TextField
                RoundTextField(
                  controller: _password,
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
                  height: media.width * 0.4,
                ),
                ispressed
                    ? Center(
                        child: CircularProgressIndicator(
                          color: TColor.primaryColor1,
                        ),
                      )
                    : RoundButton(
                        title: "Update",
                        onPressed: () {
                          deleteprof();
                        }),
                SizedBox(
                  height: media.width * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
