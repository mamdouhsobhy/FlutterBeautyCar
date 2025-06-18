import 'package:beauty_car/home/data/response/centers/centers.dart';
import 'package:beauty_car/home/presentation/centerPageScreen/viewmodel/centers_viewmodel.dart';
import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/fontManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_appbar.dart';
import '../../../../utils/shared_text_field.dart';
import '../../homeSharedViews/centers_item_card.dart';
import '../../routeManager/home_routes_manager.dart';

class CenterPageScreen extends StatefulWidget {
  const CenterPageScreen({super.key});

  @override
  State<CenterPageScreen> createState() => _CenterPageScreenState();
}

class _CenterPageScreenState extends State<CenterPageScreen> {

  final CentersViewModel _centersViewModel = instance<CentersViewModel>();

  final ScrollController _scrollController = ScrollController();

  final TextEditingController _searchController = TextEditingController();

  List<Data> filteredCenters = [];

  _bind() {
    _centersViewModel.start();
  }

  void _searchCenters(String query) {
    setState(() {
      filteredCenters = _centersViewModel.centersList.where((center) {
        return center.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    _bind();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        _centersViewModel.page++ ;
        _centersViewModel.centerRequest.page = _centersViewModel.page;
        _centersViewModel.getCenters();
      }
    });
    super.initState();
  }

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
            child: MyAppBar(title: AppStrings.centers.tr()),
          ),
          body: SafeArea(
            child: StreamBuilder<FlowState>(
              stream: _centersViewModel.outputState,
              builder: (context, snapshot) {
                if (snapshot.data != null && _centersViewModel.isOutStateLoading) {
                  _handleCentersStateChanged(snapshot.data!);
                }
                return _getCentersScreenContent();
              },
            ),
          ),
        ));
  }

  Widget _getCentersScreenContent() {
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
                  controller: _searchController,
                  takeValue: (value) {
                    _searchCenters(value);
                    _searchController.text = value;
                  },
                  validator: null,
                  paddingHorizontal: AppPadding.p0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s10,),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              _centersViewModel.page = 1;
              _centersViewModel.centerRequest.page = 1;
              _centersViewModel.centersList = [];
              _centersViewModel.centersList.clear();
              filteredCenters.clear();
              _centersViewModel.resetPage();
              _centersViewModel.getCenters();
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: constraints.maxHeight,
                      child: StreamBuilder<ModelCentersResponseRemote>(
                        stream: _centersViewModel.outputCentersData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data?.data?.isNotEmpty == true) {
                            for (var center in snapshot.data!.data!) {
                              if (!_centersViewModel.centersList.contains(center)) {
                                _centersViewModel.centersList.add(center);
                              }
                            }
                          }

                          if (_centersViewModel.centersList.isEmpty) {
                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                height: constraints.maxHeight,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(ImageAssets.ordersIcon),
                                      const SizedBox(height: AppSize.s10),
                                      Text(
                                        "No Centers Found",
                                        style: getRegularStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.size16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                          } else {
                            if (_searchController.text.isEmpty) {
                              filteredCenters = _centersViewModel.centersList;
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p14, vertical: AppPadding.p5),
                              child: GridView.builder(
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: filteredCenters.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: AppPadding.p8,
                                  crossAxisSpacing: AppPadding.p8,
                                  childAspectRatio: 1 / 1.33,
                                ),
                                itemBuilder: (context, index) {
                                  return CentersItemCard(
                                    centers: filteredCenters[index],
                                    fun: (centerId) {
                                      Future.delayed(const Duration(milliseconds: 500), () {
                                        Navigator.pushNamed(
                                          context,
                                          HomeRoutes.createCenterRoute,
                                          arguments: {'centerId': "$centerId"},
                                        );
                                      });
                                    },
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Positioned(
                      bottom: AppPadding.p50,
                      right: AppPadding.p16,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, HomeRoutes.createCenterRoute);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(AppPadding.p10),
                          decoration: BoxDecoration(
                            color: ColorManager.colorRedB2,
                            borderRadius: BorderRadius.circular(AppSize.s15),
                            border: Border.all(color: ColorManager.colorRedB2),
                          ),
                          child: SvgPicture.asset(ImageAssets.plusIcon),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _handleCentersStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _centersViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _centersViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _centersViewModel.dispose();
    super.dispose();
  }

}
