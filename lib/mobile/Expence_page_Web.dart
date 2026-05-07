import 'package:budgetapp/Components.dart';
import 'package:budgetapp/viewModal.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpencePageWeb extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModal = ref.watch(userLogin);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    TextEditingController expenseName = TextEditingController();
    TextEditingController expenseAmount = TextEditingController();
    TextEditingController IncomeName = TextEditingController();
    TextEditingController IncomeAmount = TextEditingController();
    bool isLoading = true;
    if (isLoading) {
      viewModal.getIncomeFromFirestore();
      viewModal.GetExpenseFromFireStore();
      isLoading = false;
    }
    int totalEarning = 0;
    int totalExpenses = 0;
    void Calculate() {
      for (int i = 0; i < viewModal.expenses.length; i++) {
        totalExpenses = totalExpenses + int.parse(viewModal.expenses[i]);
      }
      for (int i = 0; i < viewModal.earning.length; i++) {
        totalEarning = totalEarning + int.parse(viewModal.earning[i]);
      }
    }

    Calculate();
    int amountLeft = totalEarning - totalExpenses;
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              CircleAvatar(
                radius: 101,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 100,
                  child: Image.asset('assets/logo.png', fit: BoxFit.cover),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await launchUrl(
                    Uri.parse('http://www.instagram.com/a.man.in.scrollwars/'),
                  );
                },
                icon: Image.asset(
                  'assets/instagram.png',
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  viewModal.SignOut();
                },
                child: clickableButton(
                  width: 150,
                  height: 60,
                  text: 'Sign-Out',
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(size: 20, color: Colors.white),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: poppinsText(
            text: 'Dashboard',
            size: 20,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
          actions: [
            IconButton(
              onPressed: () {
                viewModal.Reset();
                print('deleted');
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        body: SizedBox(
          height: deviceHeight,
          width: deviceWidth,
          child: Column(
            mainAxisAlignment: .start,
            children: [
              SizedBox(height: 40),
              Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueAccent.shade400,
                ),
                child: Row(
                  mainAxisAlignment: .spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: .spaceEvenly,
                      children: [
                        poppinsText(
                          text: 'Total Income',
                          size: 14,
                          color: Colors.white,
                        ),
                        poppinsText(
                          text: 'Total Expense',
                          size: 14,
                          color: Colors.white,
                        ),
                        poppinsText(
                          text: 'Budget Left',
                          size: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: .spaceEvenly,
                      children: [
                        poppinsText(
                          text: totalEarning.toString(),
                          size: 14,
                          color: Colors.white,
                        ),
                        poppinsText(
                          text: totalExpenses.toString(),
                          size: 14,
                          color: Colors.white,
                        ),
                        poppinsText(
                          text: amountLeft.toString(),
                          size: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: .center,
                children: [
                  viewModal.AddIncomeExpenseDialogBox(
                    context,
                    name: 'Income',
                    nameController: IncomeName,
                    AmountController: IncomeAmount,
                  ),
                  SizedBox(width: 40),
                  viewModal.AddIncomeExpenseDialogBox(
                    context,
                    name: 'Expense',
                    nameController: expenseName,
                    AmountController: expenseAmount,
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  box(
                    text: 'Income',
                    width: 250,
                    height: 300,
                    itemCount: viewModal.earningName.length,
                    Money: viewModal.earning,
                    Name: viewModal.earningName,
                  ),
                  box(
                    text: 'Expense',
                    width: 250,
                    height: 300,
                    itemCount: viewModal.expensesName.length,
                    Money: viewModal.expenses,
                    Name: viewModal.expensesName,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
