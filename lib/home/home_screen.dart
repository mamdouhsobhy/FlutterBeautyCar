import 'package:beauty_car/app/di/di.dart';
import 'package:beauty_car/app/sharedPrefs/app_prefs.dart';
import 'package:beauty_car/home/presentation/centerPageScreen/view/center_page_screen.dart';
import 'package:beauty_car/home/presentation/editProfileScreen/view/edit_profile_screen.dart';
import 'package:beauty_car/home/presentation/employeePageScreen/view/employee_page_screen.dart';
import 'package:beauty_car/home/presentation/employeeScanPageScreen/view/employee_scan_page_screen.dart';
import 'package:beauty_car/home/presentation/homePageScreen/view/home_page_screen.dart';
import 'package:beauty_car/home/presentation/orderPageScreen/view/order_page_screen.dart';
import 'package:beauty_car/home/presentation/routeManager/home_routes_manager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:beauty_car/utils/Constants.dart';
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

  final AppPreferences _appPreferences = instance<AppPreferences>();

  int _selectedScreenIndex = 0;
  late final List<Widget> _tabsScreens;

  void _onItemTapped(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if("${_appPreferences.getUserType()}" == UserTypes.owner) {
      _tabsScreens = [
        HomePageScreen(sideMenuTabsPressed: (index) => _onItemTapped(index)),
        const CenterPageScreen(),
        const OrderPageScreen(),
        const EmployeePageScreen(),
      ];
    }else{
      initEditProfileModule();
      initScanOrdersModule();
      _tabsScreens = [
        HomePageScreen(sideMenuTabsPressed: (index) => _onItemTapped(index)),
        const EmployeeScanPageScreen(),
        const OrderPageScreen(),
        const EditProfileScreen(),
      ];
    }
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
      home: WillPopScope(
        onWillPop: () async {
          if (_selectedScreenIndex != 0) {
            setState(() {
              _selectedScreenIndex = 0;
            });
            return false;
          }
          return true; // Allow the app to exit
        },
        child: Scaffold(
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
                  ), label: AppStrings.home.tr()),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p8, bottom: AppPadding.p8),
                    child: "${_appPreferences.getUserType()}" == UserTypes.owner ? SvgPicture.asset(ImageAssets.centerIcon,
                        color: _selectedScreenIndex == 1
                            ? ColorManager.colorRedB2
                            : ColorManager.colorGray72) : Image.asset(width: 24,height: 24,ImageAssets.qrCodeIcon,
                        color: _selectedScreenIndex == 1
                            ? ColorManager.colorRedB2
                            : ColorManager.colorGray72) ,
                  ), label: "${_appPreferences.getUserType()}" == UserTypes.owner ? AppStrings.centers.tr() : AppStrings.scan.tr()),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p8, bottom: AppPadding.p8),
                    child: SvgPicture.asset(ImageAssets.ordersIcon,
                        color: _selectedScreenIndex == 2
                            ? ColorManager.colorRedB2
                            : ColorManager.colorGray72),
                  ), label: AppStrings.orders.tr()),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p8, bottom: AppPadding.p8),
                    child: SvgPicture.asset("${_appPreferences.getUserType()}" == UserTypes.owner ? ImageAssets.usersIcon : ImageAssets.userIcon,
                        color: _selectedScreenIndex == 3
                            ? ColorManager.colorRedB2
                            : ColorManager.colorGray72),
                  ), label: "${_appPreferences.getUserType()}" == UserTypes.owner ?  AppStrings.employees.tr() : AppStrings.profile.tr()),
            ],
          ),
        ),
      ),
    );
  }
}
