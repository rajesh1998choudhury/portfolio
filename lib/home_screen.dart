import 'package:flutter/material.dart';
import 'package:portfolio/Screens/account_screen.dart';
import 'package:portfolio/Screens/capital_screen.dart';
import 'package:portfolio/Screens/cash_screen.dart';
import 'package:portfolio/Screens/portfolio_screen.dart';
import 'package:portfolio/Screens/statement_screen.dart';
import 'package:portfolio/commonWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  bool _viewAll = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _currentIndex = (_scrollController.offset / 100).round().clamp(1, 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).height * 1.0,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF141E30), Color(0xFF243B55)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(Icons.arrow_back_ios_new_rounded, color: Colors.blue[900]),
                const Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Reports Center",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Row(children: [
                Text(
                  "Which report do you want to generate today?",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ]),
            ),
            Column(
              children: [
                buildReportCard(
                    context,
                    "Portfolio Summary",
                    "Overview of your current investment holdings and their performance.",
                    const PortfolioScreen(),
                    0),
                buildReportCard(
                    context,
                    "Capital Gains",
                    "Summary of gains/losses generated from your investments for filing your ITR.",
                    const CapitalGainsScreen(),
                    1),
                buildReportCard(
                    context,
                    "Cash Flow",
                    "View cash inflows & outflows to your folio from your registered bank account.",
                    const CashFlowScreen(),
                    2),
                buildReportCard(
                    context,
                    "Transaction Statement",
                    "Record of all investment transactions for each holding in your portfolio.",
                    const TransactionStatementScreen(),
                    3),
                buildReportCard(
                    context,
                    "Statement of Accounts",
                    "Comprehensive report on a fund's key information & performance.",
                    const StatementOfAccountsScreen(),
                    4),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
              ),
              child: Row(children: [
                const Text(
                  "Previously Generated Reports",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(width: 90),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _viewAll = !_viewAll;
                    });
                  },
                  child: Text(
                    _viewAll ? "View Less" : "View All",
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 8),
            buildGeneratedReports(),
            const SizedBox(height: 8),
            buildDotIndicator(3),
          ]),
        ),
      ),
    );
  }

  Widget buildGeneratedReports() {
    return SizedBox(
      height: 100,
      child: ListView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        children: [
          buildGeneratedReportCard(
              "Cash Flow", Icons.pie_chart, Icons.download_outlined),
          buildGeneratedReportCard("Transaction Statement", Icons.file_download,
              Icons.download_outlined),
          buildGeneratedReportCard(
              "Statements of Account", Icons.article, Icons.download_outlined),
          buildGeneratedReportCard(
              "Capital Gains", Icons.pie_chart, Icons.download_outlined),
        ],
      ),
    );
  }

  Widget buildDotIndicator(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        double size = _currentIndex == index ? 12.0 : 8.0;
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = index;
              _scrollController.animateTo(
                index * 100.0,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeIn,
              );
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape:
                  _currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
              borderRadius:
                  _currentIndex == index ? BorderRadius.circular(4.0) : null,
              color: _currentIndex == index ? Colors.yellow : Colors.grey,
            ),
          ),
        );
      }),
    );
  }

  int selectedIndex = -1;
  Widget buildReportCard(BuildContext context, String title, String subtitle,
      Widget targetScreen, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      onDoubleTap: () {
        if (selectedIndex == index) {
          setState(() {
            selectedIndex = -1;
          });
        }
      },
      child: Card(
        color: Colors.black54,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: selectedIndex == index ? Colors.blue : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(9.0),
        ),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[400])),
        ),
      ),
    );
  }
}
