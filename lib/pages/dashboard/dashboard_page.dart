// ignore_for_file: library_private_types_in_public_api
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wallet_app/pages/card/mobile/mobileCard.dart';
import 'package:wallet_app/pages/card/cardsWidget.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wallet_app/models/actions/actions.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/routes.dart';
import 'package:wallet_app/utils/constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final String userName = "Mundie";
  bool showWelcomeMessage = true;
  late Timer messageTimer;
  final PageController _pageController = PageController();
  int toggleIndex = 0;

  @override
  void initState() {
    super.initState();
    messageTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        showWelcomeMessage = false;
      });
    });
  }

  @override
  void dispose() {
    messageTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(

            expandedHeight: 65,
            // collapsedHeight: ,
            pinned: true,
            backgroundColor: Colors.white,
            // backgroundColor: Colors.grey.shade50,
            elevation: 2,
        leading: const Text('finmal',style: TextStyle(fontWeight:FontWeight.w900,fontSize: 14),),
        actions: [
              Container(
                margin: const EdgeInsets.only(top:10,right: 8),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(13),
                  color: Colors.white,
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Iconsax.notification,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        RouteGenerator.notificationPage,
                      );
                    },
                  ),
                ),
              ),

            ],

            flexibleSpace:   Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: AnimatedOpacity(
                    opacity: showWelcomeMessage ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 6000),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          userName,
                          style: const TextStyle(
                            fontFamily: 'Oregon',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Center(
                  child: ToggleSwitch(
                    centerText: true,
                    minWidth:120,
                    customTextStyles: const [ TextStyle(fontWeight: FontWeight.bold)],
                    initialLabelIndex: toggleIndex,
                    cornerRadius: 10.0,
                    activeFgColor: Colors.white,
                    activeBgColor: const [Colors.green],
                    inactiveBgColor: Colors.white,
                    inactiveFgColor: Colors.black,
                    labels: const ['Cards', 'Mobile'],
                    // activeBgColor: [Colors.black],
                    onToggle: (index) {
                      setState(() {
                        toggleIndex = index ?? 0;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height:10),
              Expanded(
                child: toggleIndex == 0 ? const CarouselBank() : CarouselMobile(),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Container(
                padding :const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                  left:15,
                  right:15
                ),
              decoration: BoxDecoration(
                color:Colors.black87,
                borderRadius: BorderRadius.circular(10)
              ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionsPush(
                      iconData: Iconsax.direct_up,
                      text: 'Pay',

                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RouteGenerator.transferPage,
                        );
                      },
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white70,
                    ),
                    ActionsPush(
                      iconData: Iconsax.direct_down,
                      text: 'Request',

                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RouteGenerator.loginFingerprintPage,
                        );
                      },
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white70,
                    ),
                    ActionsPush(
                      iconData: Iconsax.link,
                      text: 'Link',
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RouteGenerator.withdrawPage,
                        );
                      },
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white70,
                    ),
                    ActionsPush(
                      iconData: Iconsax.archive_tick,
                      text: 'Bills',

                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RouteGenerator.paymentPage,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),

            ]),
          ),

          SliverToBoxAdapter(
            child:Container(
            height: 700,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(25.0),
              ),
            ),
  child: ListView(

    children: const[
     
      SizedBox(
        height: 10,
      ),
      RecentWidget(),

    ],
  ),
),

          ),
        ],
      ),
    );
  }
}

class RecentWidget extends StatefulWidget {
  const RecentWidget({super.key});

  @override
  State<RecentWidget> createState() => _RecentWidgetState();
}

enum SortType {
  dateDesc,
  dateAsc,
  transferDesc,
  receivedDesc,
}

class Transaction {
  final String id;
  final String categoryIcon;
  final String name;
  final double price;
  final DateTime dateTime;
  final bool isTransfer;

  Transaction({
    required this.id,
    required this.categoryIcon,
    required this.name,
    required this.price,
    required this.dateTime,
    required this.isTransfer,
  });
}

class _RecentWidgetState extends State<RecentWidget> {

  List<Transaction> _transactions = [];

  bool _showAll = false;

  SortType _sortType = SortType.dateDesc;

  get title => null;
  @override
  void initState() {
    super.initState();
    _transactions = [
      Transaction(
        id: "1",
        categoryIcon: "assets/images/finmal.png",
        name: "Groceries",
        price: -25.50,
        dateTime: DateTime.now().subtract(const Duration(days: 1)),

        isTransfer: false,

      ),

      Transaction(

        id: "2",

        categoryIcon: "assets/images/finmal.png",

        name: "Clothes",

        price: -39.99,

        dateTime: DateTime.now().subtract(const Duration(days: 2)),

        isTransfer: false,

      ),

      Transaction(

        id: "3",

        categoryIcon: "assets/images/finmal.png",

        name: "Taxi",

        price: -15.00,

        dateTime: DateTime.now().subtract(const Duration(days: 3)),

        isTransfer: false,

      ),

      // Add more transactions as needed

    ];

  }



  void sortBy(SortType type) {

    setState(() {

      _sortType = type;

      _sortTransactions();

    });

  }



  void showAll() {

    setState(() {

      _showAll = true;

    });

  }



  void _sortTransactions() {

    switch (_sortType) {

      case SortType.dateDesc:

        _transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));

        break;

      case SortType.dateAsc:

        _transactions.sort((a, b) => a.dateTime.compareTo(b.dateTime));

        break;

      case SortType.transferDesc:

        _transactions.sort((a, b) => a.isTransfer == b.isTransfer ? 0 : a.isTransfer ? -1 : 1);

        break;

      case SortType.receivedDesc:

        _transactions.sort((a, b) => a.isTransfer == b.isTransfer ? 0 : a.isTransfer ? 1 : -1);

        break;

    }

  }

  @override
  Widget build(BuildContext context) {
    List<Transaction> displayedTransactions = _showAll
        ? _transactions

        : _transactions.sublist(0, _transactions.length < 3 ? _transactions.length : 3);

    _sortTransactions();



    return Column(

      mainAxisAlignment: MainAxisAlignment.start,

      children: [

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.only(
            left:15,
            right:10,
          ),
          child: Row(
          
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
            children: [
          
              const Align(
                
                alignment: Alignment.centerLeft,
          
                child: Text(
          
                  'Recent Transactions',
          
                  style: TextStyle(
          
                    fontSize: 14,
          
                    fontWeight: FontWeight.w900,
          
                    color: Colors.black,
          
                  ),
          
                ),
          
              ),
          
              _showAll
          
                  ? Row(   children: [
          
                IconButton(
          
                  onPressed: () => sortBy(SortType.dateAsc),
          
                  icon: Icon(
          
                    _sortType == SortType.dateAsc
          
                        ? Icons.arrow_upward
          
                        : Icons.arrow_downward,
          
                    color: Colors.green,
          
                  ),
          
                ),
          
                IconButton(
          
                  onPressed: () => sortBy(SortType.transferDesc),
          
                  icon: Icon(
          
                    _sortType == SortType.transferDesc
          
                        ? Icons.arrow_downward
          
                        : Icons.arrow_upward,
          
                    color: Colors.green,
          
                  ),
          
                ),
          
              ],
          
              )
          
                  : TextButton(
                onPressed: showAll,
                child: Text(
                  _showAll ? 'View Less' : 'View All',
          
                  style: const TextStyle(
          
                    fontSize: 14,
          
                    fontWeight: FontWeight.w300,
          
                    color: Colors.green,
          
                  ),
          
                ),
          
              ),
          
            ],
          
          ),
        ),

        Container(
          margin: const EdgeInsets.all(14),

          decoration: const BoxDecoration(


          ),

          child: SingleChildScrollView(

            child: Column(

              children: [
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 14,
                  padding: REdgeInsets.all(0),
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      'You Saving',
                      style: smallTextStyle,
                    ),
                    subtitle: Text(
                      'June 7 , 2023 at 11:10 PM',
                      style: xSmallTextStyle,
                    ),
                    trailing: Text(
                      '+9500',
                      style: mediumTextStyle.copyWith(
                          color: title == 'Income' ? successColor : redColor),
                    ),
                  ),

                )

                // Add any additional content below the list if needed

              ],

            ),

          ),

        )

      ],

    );

  }

}


class TransactionListItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionListItem(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                transaction.categoryIcon,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.name),
                  Text(
                    transaction.dateTime.toString().split(' ').first,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Text(
            transaction.price.toStringAsFixed(2), // Show price with 2 decimal places
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: transaction.price < 0 ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}




