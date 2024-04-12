// ignore_for_file: library_private_types_in_public_api
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet_app/utils/constants.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/routes.dart';
import '../card/card_page.dart';
import '../dashboard/dashboard_page.dart';
import '../profile/profile_page.dart';
import '../wallet/wallet_page.dart';
import 'package:wallet_app/pages/card/card/ui/app.dart';
class NavigationPage extends  StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    WalletPage(),
    CardPage(),
    ProfilePage()
  ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
     
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: Colors.black,
        backgroundColor: Colors.transparent,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.home),
            title: const Text("Home",style: TextStyle(fontFamily: 'Oregon'),),
            unselectedColor: Colors.grey.shade700,
            selectedColor: Colors.black,
          ),
          SalomonBottomBarItem(

            icon: const Icon(Iconsax.activity),
            title: const Text("Statistics",style: TextStyle(fontFamily: 'Oregon'),),
            unselectedColor: Colors.grey.shade700,
            selectedColor: Colors.black,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.card),
            title: const Text("Cards",style: TextStyle(fontFamily: 'Oregon'),),
            unselectedColor: Colors.grey.shade700,
            selectedColor: Colors.black,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.user),
            title: const Text("Account",style: TextStyle(fontFamily: 'Oregon'),),
            unselectedColor: Colors.grey.shade700,
            selectedColor: Colors.black,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: SvgPicture.asset('assets/svg/scan_icon.svg'),
        onPressed: () {
          Navigator.of(context).pushNamed(
            RouteGenerator.scanPage,
          );
        },
      ),
    );
  }
}
