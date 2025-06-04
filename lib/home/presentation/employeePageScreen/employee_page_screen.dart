import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assetsManager.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/shared_appbar.dart';
import '../../../utils/shared_text_field.dart';
import '../homeSharedViews/employee_item_card.dart';
import '../routeManager/home_routes_manager.dart';

class EmployeePageScreen extends StatefulWidget {
  const EmployeePageScreen({super.key});

  @override
  State<EmployeePageScreen> createState() => _EmployeePageScreenState();
}

class _EmployeePageScreenState extends State<EmployeePageScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          appBar: MyAppBar(title: AppStrings.employees.tr()),
          body: SafeArea(
              child:
              // StreamBuilder<FlowState>(
              //   stream: _loginViewModel.outputState,
              //   builder: (context, snapshot) {
              //     if (snapshot.data != null) {
              //       _handleLoginStateChanged(snapshot.data!);
              //     }
              _getEmployeeScreenContent()
            // },
            // ),
          ),
        ));
  }

  Widget _getEmployeeScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: AppSize.s10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppPadding.p10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s15), // Rounded corners
                  border:
                  Border.all(color: Colors.grey), // Optional: visible border
                ),
                child: SvgPicture.asset(ImageAssets.filterIcon),
              ),
              const SizedBox(width: AppSize.s10), // Optional: spacing between icon and text field
              Expanded(
                child: MyTextField(
                  hint: "",
                  title: "",
                  suffixIcon: ImageAssets.searchIcon,
                  obscureText: false,
                  inputType: TextInputType.text,
                  validator: null,
                  controller: _searchController,
                  takeValue: (value) {},
                  paddingHorizontal: AppPadding.p0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s10,),
        Expanded(
          child: Stack(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppPadding.p8, horizontal: AppPadding.p16),
                    child: EmployeeItemCard(fun: (){
                      Navigator.pushNamed(context, HomeRoutes.employeeDetailsRoute);
                    }),
                  );
                },
              ),
              Positioned(
                  bottom: AppPadding.p50,
                  right: AppPadding.p16,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, HomeRoutes.createCenterRoute);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p10),
                      decoration: BoxDecoration(
                        color: ColorManager.colorRedB2, // Light gray background
                        borderRadius: BorderRadius.circular(AppSize.s15), // Rounded corners
                        border:
                        Border.all(color: ColorManager.colorRedB2), // Optional: visible border
                      ),
                      child: SvgPicture.asset(ImageAssets.plusIcon),
                    ),
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}
