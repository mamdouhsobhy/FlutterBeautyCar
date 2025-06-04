import 'package:beauty_car/home/presentation/centerPageScreen/center_page_screen.dart';
import 'package:beauty_car/home/presentation/employeePageScreen/employee_page_screen.dart';
import 'package:beauty_car/home/presentation/homePageScreen/home_page_screen.dart';
import 'package:beauty_car/home/presentation/orderPageScreen/order_page_screen.dart';
import 'package:beauty_car/home/presentation/routeManager/home_routes_manager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../resources/assetsManager.dart';
import '../resources/colorManager.dart';
import '../resources/styleManager.dart';
import '../resources/valuesManager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreenIndex = 0;

  final List<Widget> _tabsScreens = const [
    HomePageScreen(),
    CenterPageScreen(),
    OrderPageScreen(),
    EmployeePageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: HomeRouteGenerator.getRoute,
      initialRoute: "/",
      home: Scaffold(
        body: _tabsScreens[_selectedScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              _onItemTapped(index);
            },
            selectedLabelStyle: getBoldStyle(
              fontSize: AppSize.s12,
              color: ColorManager.colorGray72,
            ),
            unselectedLabelStyle: getRegularStyle(
              fontSize: AppSize.s12,
              color: ColorManager.colorGray72,
            ),
            unselectedIconTheme: IconThemeData(color: ColorManager.colorGray72),
            currentIndex: _selectedScreenIndex,
            backgroundColor: Colors.white,
            selectedItemColor: ColorManager.colorRedB2,
            unselectedItemColor: ColorManager.colorGray72,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p8, bottom: AppPadding.p8),
                child: SvgPicture.asset(ImageAssets.homeIcon,
                    color: _selectedScreenIndex == 0
                        ? ColorManager.colorRedB2
                        : ColorManager.colorGray72),
              ),label: AppStrings.home.tr()),
              BottomNavigationBarItem(
                  icon: Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p8, bottom: AppPadding.p8),
                child: SvgPicture.asset(ImageAssets.centerIcon,
                    color: _selectedScreenIndex == 1
                        ? ColorManager.colorRedB2
                        : ColorManager.colorGray72),
              ),label: AppStrings.centers.tr()),
              BottomNavigationBarItem(
                  icon: Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p8, bottom: AppPadding.p8),
                child: SvgPicture.asset(ImageAssets.ordersIcon,
                    color: _selectedScreenIndex == 2
                        ? ColorManager.colorRedB2
                        : ColorManager.colorGray72),
              ),label: AppStrings.orders.tr()),
              BottomNavigationBarItem(
                  icon: Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p8, bottom: AppPadding.p8),
                child: SvgPicture.asset(ImageAssets.usersIcon,
                    color: _selectedScreenIndex == 3
                        ? ColorManager.colorRedB2
                        : ColorManager.colorGray72),
              ),label: AppStrings.employees.tr()),
            ]),
      ),
    );
  }
}
