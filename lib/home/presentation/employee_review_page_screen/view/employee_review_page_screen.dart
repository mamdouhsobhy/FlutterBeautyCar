import 'package:beauty_car/home/data/response/getRatedOrders/get_rated_orders.dart';
import 'package:beauty_car/home/presentation/employee_review_page_screen/viewmodel/review_orders_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/fontManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/loading_page.dart';
import '../../homeSharedViews/employee_review_item_card.dart';

class EmployeeReviewPageScreen extends StatefulWidget {
  String employeeId;
  EmployeeReviewPageScreen({super.key,required this.employeeId});

  @override
  State<EmployeeReviewPageScreen> createState() => _EmployeeReviewPageScreenState();
}

class _EmployeeReviewPageScreenState extends State<EmployeeReviewPageScreen> {

  final ReviewOrdersViewModel _reviewOrdersViewModel = instance<ReviewOrdersViewModel>();

  final ScrollController _scrollController = ScrollController();

  List<Data> filteredOrders = [];

  _bind() {
    _reviewOrdersViewModel.start();
  }


  @override
  void initState() {
    _reviewOrdersViewModel.ratedOrderRequest.empId = widget.employeeId;
    _bind();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        _reviewOrdersViewModel.page++ ;
        _reviewOrdersViewModel.ratedOrderRequest.page = _reviewOrdersViewModel.page;
        _reviewOrdersViewModel.getRatedOrders();
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
          body: SafeArea(
            child: StreamBuilder<FlowState>(
              stream: _reviewOrdersViewModel.outputState,
              builder: (context, snapshot) {
                if (snapshot.data != null && _reviewOrdersViewModel.isOutStateLoading) {
                  _handleOrdersStateChanged(snapshot.data!);
                }
                return _getRatedOrdersContentScreen();
              },
            ),
          ),
        ));
  }

  Widget _getRatedOrdersContentScreen(){
    return RefreshIndicator(
      onRefresh: () async {
        _reviewOrdersViewModel.page = 1;
        _reviewOrdersViewModel.ratedOrderRequest.page = 1;
        _reviewOrdersViewModel.ratedOrdersList = [];
        _reviewOrdersViewModel.ratedOrdersList.clear();
        filteredOrders.clear();
        _reviewOrdersViewModel.resetPage();
        _reviewOrdersViewModel.getRatedOrders();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                height: constraints.maxHeight,
                child: StreamBuilder<ModelGetRatedOrdersResponseRemote>(
                  stream: _reviewOrdersViewModel.outputRatedOrdersData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data?.data?.isNotEmpty == true) {
                      for (var order in snapshot.data!.data!) {
                        if (!_reviewOrdersViewModel.ratedOrdersList.contains(order)) {
                          _reviewOrdersViewModel.ratedOrdersList.add(order);
                        }
                      }
                    }

                    if (_reviewOrdersViewModel.ratedOrdersList.isEmpty) {
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
                                  "No Orders Found",
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
                      filteredOrders = _reviewOrdersViewModel.ratedOrdersList;
                      return ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppPadding.p8, horizontal: AppPadding.p16),
                            child: EmployeeReviewItemCard(ratedOrders: filteredOrders[index],fun: (orderId){

                            }),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  _handleOrdersStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _reviewOrdersViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _reviewOrdersViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _reviewOrdersViewModel.dispose();
    super.dispose();
  }

}
