import 'package:beauty_car/home/presentation/routeManager/home_routes_manager.dart';
import 'package:beauty_car/resources/fontManager.dart';
import 'package:beauty_car/resources/styleManager.dart';
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
import '../homeSharedViews/order_request_item_card.dart';

class OrderPageScreen extends StatefulWidget {
  const OrderPageScreen({super.key});

  @override
  State<OrderPageScreen> createState() => _OrderPageScreenState();
}

class _OrderPageScreenState extends State<OrderPageScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> statusList = [
    AppStrings.statusPending.tr(),
    AppStrings.statusApproved.tr(),
    AppStrings.statusCompleted.tr(),
    AppStrings.statusCancelled.tr()
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: MyAppBar(title: AppStrings.serviceRequests.tr()),
          ),
          body: SafeArea(
              child:
                  // StreamBuilder<FlowState>(
                  //   stream: _loginViewModel.outputState,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.data != null) {
                  //       _handleLoginStateChanged(snapshot.data!);
                  //     }
                  _getOrdersScreenContent()
              // },
              // ),
              ),
        ));
  }

  Widget _getOrdersScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
                  borderRadius: BorderRadius.circular(AppSize.s15),
                  // Rounded corners
                  border: Border.all(
                      color: Colors.grey), // Optional: visible border
                ),
                child: SvgPicture.asset(ImageAssets.filterIcon),
              ),
              const SizedBox(width: AppSize.s10),
              // Optional: spacing between icon and text field
              Expanded(
                child: MyTextField(
                  hint: "",
                  title: "",
                  suffixIcon: ImageAssets.searchIcon,
                  obscureText: false,
                  inputType: TextInputType.text,
                  controller: _searchController,
                  validator: null,
                  takeValue: (value) {},
                  paddingHorizontal: AppPadding.p0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: List.generate(statusList.length, (index) {
                final isSelected = index == selectedIndex;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p4),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });

                      print('Selected: ${statusList[index]}');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p12, vertical: AppPadding.p8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorManager.colorRedB2 // Selected: Red
                            : ColorManager.colorRedFA, // Unselected: Light Red
                        borderRadius: BorderRadius.circular(AppSize.s20),
                      ),
                      child: Text(
                        statusList[index],
                        style: getRegularStyle(
                            fontSize: FontSize.size14,
                            color: isSelected ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: AppSize.s8),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p8, horizontal: AppPadding.p16),
                child: OrderRequestItemCard(fun: (){
                  Navigator.pushNamed(context, HomeRoutes.reserveDetailsRoute);
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
