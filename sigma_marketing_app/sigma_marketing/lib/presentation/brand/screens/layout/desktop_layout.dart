import 'package:flutter/material.dart';
import 'package:sigma_marketing/presentation/brand/screens/analytics/analytics_screen.dart';
import 'package:sigma_marketing/presentation/brand/screens/campaigns/campaigns_desktop_screen.dart';
import 'package:sigma_marketing/presentation/brand/screens/chat/chat_desktop_screen.dart';
import 'package:sigma_marketing/presentation/brand/screens/home/home_desktop_screen.dart';
import 'package:sigma_marketing/presentation/brand/screens/layout/sidemenu/side_menu.dart';
import 'package:sigma_marketing/presentation/brand/screens/layout/sidemenu/side_menu_display_mode.dart';
import 'package:sigma_marketing/presentation/brand/screens/layout/sidemenu/side_menu_item.dart';
import 'package:sigma_marketing/presentation/brand/screens/layout/sidemenu/side_menu_style.dart';
import 'package:sigma_marketing/presentation/brand/screens/layout/top_bar.dart';
import 'package:sigma_marketing/presentation/brand/screens/login/login_desktop_screen.dart';
import 'package:sigma_marketing/presentation/brand/screens/payments/payments_desktop_screen.dart';

import '../../../../utils/colors/colors.dart';
import '../../../../blocs/common/layout/layout_bloc.dart';
import 'global.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  _DesktopLayoutState createState() => _DesktopLayoutState();


  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => DesktopLayout());
  }
}

class _DesktopLayoutState extends State<DesktopLayout> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  late LayoutBloc _layoutBloc;

  @override
  void initState() {
    pageController = PageController();
    sideMenu = SideMenuController();
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    _layoutBloc = LayoutBloc();
    _layoutBloc.add(LayoutFetched());
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    sideMenu.dispose();
    _layoutBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _layoutBloc.unreadMessagesStream,
        builder: (context, snapshot) {
          var numberOfUnreadMessages = 0;
          if (snapshot.hasData) {
            numberOfUnreadMessages = snapshot.data!;
          }
          return Scaffold(
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SideMenu(
                  collapseWidth: 600,
                  showToggle: false,
                  controller: sideMenu,
                  style: SideMenuStyle(
                      displayMode: SideMenuDisplayMode.values[0],
                      hoverColor: SMColors.menuSelectColor.withOpacity(0.5),
                      selectedHoverColor: Color.alphaBlend(
                          SMColors.menuSelectColor, SMColors.menuSelectColor),
                      selectedColor: SMColors.menuSelectColor,
                      selectedTitleTextStyle:
                          const TextStyle(color: Colors.white),
                      selectedIconColor: Colors.white,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      backgroundColor: SMColors.main),
                  title: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 20, right: 20),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 50,
                            maxWidth: 150,
                          ),
                          child: Image.asset(
                            'assets/logo_dark.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                  footer: SideMenuItem(
                    priority: 7,
                    title: 'Logout',
                    icon: Icon(Icons.exit_to_app),
                    onTap: (index, _) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginDesktopScreen()),
                        (route) => false,
                      );
                    },
                  ),
                  items: [
                    SideMenuItem(
                      priority: 0,
                      title: 'Dashboard',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.dashboard),
                    ),
                    SideMenuItem(
                      priority: 1,
                      title: 'Campaigns',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.supervisor_account),
                    ),
                    SideMenuItem(
                      priority: 2,
                      title: 'Chat',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.file_copy_rounded),
                      badgeColor: Colors.red,
                      badgeContent: numberOfUnreadMessages > 0
                          ? Container(
                              width: 14,
                              height: 14,
                              decoration: const BoxDecoration(
                                color: Colors.red, // Customize the badge color
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  numberOfUnreadMessages.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            )
                          : null,
                      trailing: numberOfUnreadMessages > 0
                          ? Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Colors.red, // Customize the badge color
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            numberOfUnreadMessages.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                          : null,
                    ),
                    SideMenuItem(
                      priority: 3,
                      title: 'Analytics',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.download),
                    ),
                    SideMenuItem(
                      priority: 4,
                      title: 'Payments',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      TopBar(),
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          children: const [
                            HomeDesktopScreen(),
                            CampaignsDesktopScreen(),
                            ChatDesktopScreen(),
                            AnalyticsScreen(),
                            PaymentsDesktopScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
