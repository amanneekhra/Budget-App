import 'package:budgetapp/viewModal.dart';
import 'package:budgetapp/web/Login_Page_mob.dart';
import 'package:budgetapp/web/expence_Page_mob.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'mobile/Expence_page_Web.dart';
import 'mobile/login_page_Web.dart';

class ResponsiveHandler extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) {
        if (data != null) {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 930.0) {
                return ExpencePageWeb();
              } else {
                return ExpencePageMob();
              }
            },
          );
        } else {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 930.0) {
                return LoginPageWeb();
              } else {
                return LoginPageMob();
              }
            },
          );
        }
      },
      error: (e, trace) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 930.0) {
              return LoginPageWeb();
            } else {
              return LoginPageMob();
            }
          },
        );
      },
      loading: () {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 930.0) {
              return LoginPageWeb();
            } else {
              return LoginPageMob();
            }
          },
        );
      },
    );
    /*final checkUserLogin = ref.watch(userLogin);
    checkUserLogin.checkLogIn();
    print('build');

    if (checkUserLogin.isLoggedIn == true) {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 930.0) {
            return ExpencePageWeb();
          } else {
            return ExpencePageMob();
          }
        },
      );
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 930.0) {
            return LoginPageWeb();
          } else {
            return LoginPageMob();
          }
        },
      );
    }*/
  }
}
