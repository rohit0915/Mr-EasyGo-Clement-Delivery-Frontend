import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:muvit_driver/view/auth/otp_verification_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/first_btn.dart';
import '../../components/social_btn.dart';
import '../intro/get_controllers/login_screen_get_controller.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenGetController getController = Get.put(LoginScreenGetController());
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/easy_go_logo.png",
          height: 30.h,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login Using Number or email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.h),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return ElevatedButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 10.h),
                            ),
                            elevation: WidgetStatePropertyAll(
                                getController.isLoginWithNumber.value ? 5 : 0),
                            shadowColor:
                                const WidgetStatePropertyAll(Colors.grey),
                            backgroundColor: WidgetStatePropertyAll(
                                getController.isLoginWithNumber.value
                                    ? Get.theme.cardColor
                                    : Get.theme.secondaryHeaderColor),
                            shape: const WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            getController.isLoginWithNumber.value = true;
                          },
                          child: Text(
                            "Mobile",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16.sp),
                          ),
                        );
                      }),
                    ),
                    Expanded(
                      child: Obx(() {
                        return ElevatedButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 10.h),
                            ),
                            elevation: WidgetStatePropertyAll(
                                !getController.isLoginWithNumber.value ? 5 : 0),
                            shadowColor:
                                const WidgetStatePropertyAll(Colors.grey),
                            backgroundColor: WidgetStatePropertyAll(
                                !getController.isLoginWithNumber.value
                                    ? Get.theme.cardColor
                                    : Get.theme.secondaryHeaderColor),
                            shape: const WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            getController.isLoginWithNumber.value = false;
                          },
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16.sp),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return Text(
                    getController.isLoginWithNumber.value
                        ? "Mobile Number"
                        : "Email Address",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.h),
                  );
                }),
                SizedBox(
                  height: 10.h,
                ),
                Obx(() {
                  return getController.isLoginWithNumber.value
                      ? TextFormField(
                          controller: _controller,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixText:
                                _controller.text.isNotEmpty ? "+91 " : "",
                            prefixStyle: TextStyle(
                                color: _controller.text.isNotEmpty
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 15.sp),
                            hintText: "+91 Enter Mobile Number",
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        )
                      : TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.email_outlined, color: Colors.grey),
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        );
                }),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return Visibility(
                    visible: !getController.isOtp.value,
                    child: Text(
                      "Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.h),
                    ),
                  );
                }),
                Obx(() {
                  return Visibility(
                    visible: !getController.isOtp.value,
                    child: SizedBox(
                      height: 10.h,
                    ),
                  );
                }),
                Obx(() {
                  return Visibility(
                    visible: !getController.isOtp.value,
                    child: TextFormField(
                      obscureText: getController.isViewPassword.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline_rounded,
                            color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Obx(() {
                            return Icon(
                              getController.isViewPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            );
                          }),
                          onPressed: () {
                            getController.isViewPassword.value =
                                !getController.isViewPassword.value;
                          },
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const ResetPasswordScreen());
                  },
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forget Password?",
                        style: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Center(
                  child: SizedBox(
                    width: 320.w,
                    child: Obx(() {
                      return FirstBtn(
                          text:
                              getController.isOtp.value ? "GET OTP" : "LOG IN",
                          onTap: () async {
                            if (!await Permission.location.isGranted) {
                              await Permission.location.request();
                            }
                            if (!getController.isOtp.value) {
                              getController.isOtp.value = true;
                            } else {
                              Get.to(() => const OtpVerificationScreen(
                                    isForgetPassword: false,
                                    isSignUp: false,
                                  ));
                            }
                          });
                    }),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Text("Or"),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                SocialBtn(
                  image: "assets/images/google.png",
                  text: "Continue with Google",
                  onTap: () {},
                ),
                SizedBox(
                  height: 20.h,
                ),
                SocialBtn(
                  image: "assets/images/apple_white.png",
                  text: "Continue with Apple",
                  onTap: () {},
                ),
                SizedBox(
                  height: 20.h,
                ),
                SocialBtn(
                  image: "assets/images/facebook.png",
                  text: "Continue with Facebook",
                  onTap: () {},
                ),
                SizedBox(
                  height: 20.h,
                ),
                SocialBtn(
                  image: "assets/images/twitter_white.png",
                  text: "Continue with Twitter",
                  onTap: () {},
                ),
                SizedBox(
                  height: 20.h,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "By proceeding further you agree to our ",
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      const TextSpan(
                        text: "Terms & conditions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " and ",
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      const TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
