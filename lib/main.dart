import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_app/providers/date_provider.dart';
import 'package:wallet_app/providers/confirm_password_provider.dart';
import 'package:wallet_app/providers/password_provider.dart';
import 'package:wallet_app/utils/constants.dart';
import 'package:wallet_app/utils/pallete.dart';
import 'package:wallet_app/utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FaceCamera.initialize(); // You can keep this if necessary

  // Initialize Supabase with your project URL and Anon key
  await Supabase.initialize(
    url: "https://isjkgctgkfgxpedgpped.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlzamtnY3Rna2ZneHBlZGdwcGVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI1NTIyNjQsImV4cCI6MjAxODEyODI2NH0.WEGs8t5-q05iG3_Ocprf4UMXveRVZIin0bXoPw5wisE",
  );

  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => PasswordProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ConfirmPasswordProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => DateProvider(),
          ),
          Provider<SupabaseClient>.value(
            value: Supabase.instance.client,
          ),
        ],
        child: MaterialApp(
          title: 'Wallet App',
          theme: ThemeData(
            primarySwatch: Palette.primaryPaletteColor,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: primaryColor,
              selectionColor: primaryColor,
              selectionHandleColor: primaryColor,
            ),
          ),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          initialRoute: RouteGenerator.splashPage,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
