import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:supabase/supabase.dart';
import 'package:wallet_app/components/c_elevated_button.dart';
import 'package:wallet_app/providers/confirm_password_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//
import '../../../components/c_text_form_field.dart';
import '../../../components/phone_number_field.dart';
import '../../../providers/password_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';


import 'package:uuid/uuid.dart'; // For generating UUIDs

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key});

  // Declare TextEditingController for username
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();


  final supabase = SupabaseClient(
  'https://isjkgctgkfgxpedgpped.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlzamtnY3Rna2ZneHBlZGdwcGVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI1NTIyNjQsImV4cCI6MjAxODEyODI2NH0.WEGs8t5-q05iG3_Ocprf4UMXveRVZIin0bXoPw5wisE',
  );



  Future<void> doUserRegistration(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();

    try {
      // Sign up with email and password
      final response = await context.read<SupabaseClient>().auth.signUp(email: email, password: password);

      // Check if the response is not null
      if (response != null) {
        // Registration successful, navigate to the next page
        // Save additional user data to the users table
        await supabase.from('users').insert({
          'id': response.user!.id,
          'username': username,
          'email': email,
          'password': password,
        });

        Navigator.of(context).pushNamed(RouteGenerator.captureIdentityCardPage);
      } else {
        // Registration failed, show a generic error message
        showError('An error occurred during registration', context);
      }
    } catch (error) {
      // Registration failed, show an error message
      showError(error.toString(), context);
    }
  }
  // Define showError function
  void showError(String errorMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            ElevatedButton(
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
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: arrowBackColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Step 1 of 4',
              style: smallTextStyle,
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
        leadingWidth: 50.w,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Text('Creating New Account', style: largeTextStyle),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Fill in your data correctly and completely, so you can proceed to the next step',
                style: xSmallTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 60,
              ),
              CTextFormField(
                controller: _usernameController,
                hintText: 'Username', // Add hint text for username field
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              CTextFormField(
                controller: _emailController,
                hintText: 'Email',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              PhoneNumberField(
                controller: _phoneNumberController,
                hintText: 'Phone Number',
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<PasswordProvider>(
                builder: (context, pp, child) {
                  return CTextFormField(
                    controller: _passwordController,
                    obscureText: pp.isObscure,
                    textInputAction: TextInputAction.next,
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
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CTextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                hintText: 'Confirm Password',
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'By continuing I agree, that finmal will use my data as stated in the ',
                        style: xSmallTextStyle,
                      ),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF160D07),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            String url = 'https://google.com'; // Replace with your privacy policy URL
                            if (await canLaunchUrl(url as Uri)) {
                              await launchUrl(url as Uri);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                child: CElevatedButton(
                  onPressed: () {
                    doUserRegistration(context);
                  },
                  child: const Text('Continue'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

