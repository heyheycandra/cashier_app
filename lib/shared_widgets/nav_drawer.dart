import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cashier_app_mobile/shared_widgets/buttons.dart';
import 'package:cashier_app_mobile/theme/colors.dart';
import 'package:yaml/yaml.dart';
import 'package:cashier_app_mobile/helper/locator.dart';
import 'package:cashier_app_mobile/helper/navigator_service.dart';
import 'package:cashier_app_mobile/helper/app_scale.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool vaExpanded = false;
  bool settingsExpanded = false;
  // String groupExpanded = '';
  // double containerHeight = 0;
  // double settingsHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: const ValueKey('drawer_menu'),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                top: 25,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [],
                ),
              ),
            ),
          ),
          bottomApkVersion(),
        ],
      ),
    );
  }

  alertDialogLogout(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(
                top: 10,
                start: 20,
                end: 20,
              ),
              child: Text(
                'Apakah Anda yakin?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: context.scaleFont(14), color: const Color(0xFF232020)),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(
                top: 20,
                start: 20,
                end: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonConfirm(
                    key: const ValueKey('btn_drawer_cancel'),
                    text: 'Batal',
                    width: MediaQuery.of(context).size.width / 4.4,
                    onTap: () {
                      locator<NavigatorService>().goBack();
                    },
                  ),
                  ButtonCancel(
                    key: const ValueKey('btn_drawer_logout'),
                    text: 'Logout',
                    width: MediaQuery.of(context).size.width / 4.4,
                    onTap: () {
                      locator<NavigatorService>().goBack();
                      // bloc.dispatch(DoLogout());
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
      },
    );
  }

  dynamic headerMenu(BuildContext context, String oid) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ID Anda", style: TextStyle(fontSize: context.scaleFont(18), fontWeight: FontWeight.bold)),
          Text(oid, style: TextStyle(fontWeight: FontWeight.bold, fontSize: context.scaleFont(20))),
        ],
      ),
      onTap: () {
        Scaffold.of(context).openEndDrawer();
      },
    );
  }

  dynamic bottomMenu() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ListTile(
        title: const Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
        onTap: () {
          alertDialogLogout(
            context,
          );
        },
      ),
    );
  }

  bottomApkVersion() {
    return FutureBuilder(
        future: rootBundle.loadString("pubspec.yaml"),
        builder: (context, snapshot) {
          String version = "Unknown";
          String versionSurfix = "";
          String buildDate = "";
          if (snapshot.hasData) {
            var yaml = loadYaml(snapshot.data as String);
            version = yaml["version"].split("+")[0];
            versionSurfix = yaml["versionNameSuffix"];
            buildDate = yaml["buildDate"].toString();
          }

          if (versionSurfix != "prod") {
            version = version + " (${versionSurfix.toUpperCase()})";
          }

          return Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(
                right: 8,
              ),
              height: 20,
              child: Text(
                'v$version.$buildDate',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.bold,
                  color: cashierBlack,
                ),
              ),
            ),
          );
        });
  }
}
