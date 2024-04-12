import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/components/c_elevated_button.dart';
import 'package:wallet_app/pages/auth/login/verification_page.dart';
import 'package:wallet_app/utils/constants.dart';

import '../../../components/c_text_form_field.dart';
import '../../../components/secondary_button.dart';
import '../../../providers/password_provider.dart';
import '../../../utils/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  final _passwordController = TextEditingController();

  Future<void> doUserLogin(BuildContext context) async {
    final emailOrPhoneNumber = ''; // Get email or phone number from text field
    final password = _passwordController.text.trim();

    try {
      // Sign in with email and password
      final response = await context.read<SupabaseClient>().auth.signInWithPassword(email: emailOrPhoneNumber, password: password);


        Navigator.of(context).pushReplacementNamed(RouteGenerator.captureIdentityCardPage);

    }

    catch (error) {
      // Login failed, show an error
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
            const VerificationPage(email: 'email'),
          ));
      // showError(error.toString(), context);
    }
  }

  void showError(String errorMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new CElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 200.h),
                Text(
                  'Holla, Welcome Back!',
                  style: largeTextStyle,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Login or create an account and experience something amazing',
                  style: xSmallTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60.h),
                CTextFormField(
                  hintText: 'E-mail/Phone Number',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller:TextEditingController(),
                ),
                SizedBox(height: 20.h),
                Consumer<PasswordProvider>(
                  builder: (context, pp, child) {
                    return CTextFormField(
                      textControllor: _passwordController,
                      obscureText: pp.isObscure,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          pp.toggleIsObscure();
                        },
                        icon: Icon(
                          pp.isObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: primaryColor,
                        ),
                      ), controller: _passwordController,
                    );
                  },
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Forgot Password',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF767D88),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: CElevatedButton(
                    child: const Text('Sign In'),
                    onPressed: () {
                      doUserLogin(context);
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Text('Or Sign In with', style: xSmallTextStyle),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: SecondaryButton(
                    child: const Text('Google'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 24.h),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteGenerator.registerPage);
                  },
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Not Register? ', style: xSmallTextStyle),
                          TextSpan(
                            text: 'Create an Account',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF160D07),
                            ),
                          ),
                        ],
                      ),
                    ),
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
