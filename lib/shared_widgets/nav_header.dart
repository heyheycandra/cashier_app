// import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app_mobile/helper/locator.dart';
import 'package:cashier_app_mobile/helper/navigator_service.dart';
import 'package:cashier_app_mobile/theme/colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashier_app_mobile/helper/app_scale.dart';

AppBar navHeader(String titleAppBar, {List<Widget>? actions}) {
  return AppBar(
    title: Text(
      titleAppBar,
      style: const TextStyle(fontWeight: FontWeight.bold, color: cashierBlack),
    ),
    leading: Builder(
        builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: cashierBlack,
                size: context.scaleFont(28),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            )),
    backgroundColor: cashierPrimary,
    actions: actions,
  );
}

AppBar navHeaderTab(BuildContext ctx, String titleAppBar, TabController controller, List<Widget> tabList, bool hashDrawer,
    {List<Widget>? actions, Function()? onBackPressed}) {
  double itemWith = MediaQuery.of(ctx).size.width / (tabList.length);
  tabList = tabList
      .map((wid) => SizedBox(
            width: tabList.length < 3 ? itemWith : itemWith + 20,
            child: wid,
          ))
      .toList();
  return AppBar(
    title: Text(
      titleAppBar,
      style: TextStyle(fontWeight: FontWeight.bold, color: cashierBlack, fontSize: ctx.scaleFont(20)),
    ),
    leading: Builder(builder: (context) {
      if (hashDrawer) {
        return IconButton(
          icon: Icon(
            Icons.menu,
            color: cashierBlack,
            size: context.scaleFont(28),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        return IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: cashierBlack,
            size: context.scaleFont(28),
          ),
          onPressed: onBackPressed ?? () => locator<NavigatorService>().goBack(),
        );
      }
    }),
    backgroundColor: cashierPrimary,
    bottom: TabBar(
      isScrollable: true,
      labelPadding: const EdgeInsets.symmetric(vertical: 12),
      controller: controller,
      tabs: tabList,
      labelColor: cashierBlack,
      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: ctx.scaleFont(16)),
      unselectedLabelColor: cashierUnselect,
      indicatorColor: cashierBlack,
    ),
    actions: actions,
  );
}

AppBar readOnlyTabBarHeader(BuildContext context, String titleAppBar, TabController controller, List<Widget> tabList, bool hashDrawer,
    {List<Widget>? actions}) {
  double itemWidth = MediaQuery.of(context).size.width / (tabList.length);
  tabList = tabList
      .map((wid) => SizedBox(
            width: itemWidth,
            child: wid,
          ))
      .toList();
  return AppBar(
    title: Text(
      titleAppBar,
      style: TextStyle(fontWeight: FontWeight.bold, color: cashierBlack, fontSize: context.scaleFont(20)),
    ),
    leading: Builder(builder: (context) {
      if (hashDrawer) {
        return IconButton(
          icon: Icon(
            Icons.menu,
            color: cashierBlack,
            size: context.scaleFont(28),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        return IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: cashierBlack,
            size: context.scaleFont(28),
          ),
          onPressed: () => locator<NavigatorService>().goBack(),
        );
      }
    }),
    backgroundColor: cashierPrimary,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: IgnorePointer(
        child: TabBar(
          isScrollable: true,
          labelPadding: const EdgeInsets.symmetric(vertical: 12),
          controller: controller,
          tabs: tabList,
          labelColor: cashierBlack,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: context.scaleFont(16)),
          unselectedLabelColor: cashierUnselect,
          indicatorColor: cashierBlack,
        ),
      ),
    ),
    actions: actions,
  );
}

AppBar simpleHeader(String titleAppBar, {Function()? onBackPressed}) {
  return AppBar(
    title: Text(
      titleAppBar,
      style: const TextStyle(fontWeight: FontWeight.bold, color: cashierWhite),
    ),
    leading: Builder(
        builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: cashierWhite,
                size: context.scaleFont(28),
              ),
              onPressed: onBackPressed ?? () => locator<NavigatorService>().goBack(),
            )),
    backgroundColor: cashierPrimary,
  );
}

AppBar plainHeader(String titleAppBar) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Center(
      child: Text(
        titleAppBar,
        style: const TextStyle(color: cashierWhite),
      ),
    ),
    backgroundColor: cashierPrimary,
  );
}

class CommonAppBar extends StatelessWidget {
  final int countCart, countNotif;
  final String? menuName;
  final bool isBellButtonVisible, isVaRegisted;
  final Function()? onNotifTap, onCartTap;

  const CommonAppBar({
    Key? key,
    this.countCart = 0,
    this.countNotif = 0,
    this.isVaRegisted = false,
    this.menuName,
    this.onCartTap,
    this.onNotifTap,
    this.isBellButtonVisible = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cashierPrimary,
      padding: const EdgeInsets.all(4),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.menu,
                color: cashierBlack,
                size: context.scaleFont(28),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                menuName ?? 'Error',
                //textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, color: cashierBlack, fontSize: context.scaleFont(20)),
              ),
            )),
            Visibility(
              visible: isBellButtonVisible,
              child: Stack(
                children: [
                  IconButton(
                      icon: Icon(Icons.notifications, color: cashierBlack, size: context.scaleFont(28)), color: cashierBlack, onPressed: onNotifTap
                      // () => locator<NavigatorService>()
                      //     .navigateTo(Constant.MENU_PROGRAMS)
                      ),
                  Visibility(
                    visible: (countNotif > 0) && isBellButtonVisible,
                    child: Positioned(
                      right: 12,
                      top: 13,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: cashierDanger,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Visibility(
                  visible: isVaRegisted,
                  child: IconButton(
                      icon: Icon(Icons.shopping_cart, color: cashierBlack, size: context.scaleFont(28)), color: cashierBlack, onPressed: onCartTap
                      // ??
                      //     () => locator<NavigatorService>()
                      //         .navigateTo(Constant.MENU_CART_NEW)
                      ),
                ),
                Visibility(
                  visible: countCart > 0,
                  child: Positioned(
                      right: 6,
                      top: 9,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: cashierDanger,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                        child: Text(
                          (countCart < 100 ? countCart.toString() : '99+'),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: cashierWhite, fontSize: context.scaleFont(8)),
                        ),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
