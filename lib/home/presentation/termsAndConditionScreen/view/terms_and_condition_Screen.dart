import 'package:beauty_car/home/data/response/getSettings/get_settings.dart';
import 'package:beauty_car/home/presentation/termsAndConditionScreen/viewmodel/terms_and_condition_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/stringManager.dart';
import '../../../../resources/styleManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_appbar.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {

  final TermsAndConditionViewModel _termsAndConditionViewModel = instance<TermsAndConditionViewModel>();

  @override
  void initState() {
    _termsAndConditionViewModel.start();
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
          appBar: MyAppBar(title: AppStrings.terms_and_condition.tr()),
          body: SafeArea(
              child:
              StreamBuilder<FlowState>(
                stream: _termsAndConditionViewModel.outputState,
                builder: (context, snapshot) {
                  if (snapshot.data != null && _termsAndConditionViewModel.isOutStateLoading) {
                    _handleTermsAndConditionStateChanged(snapshot.data!);
                  }
              return _getPrivacyPolicyScreenContent();
              },
            ),
          ),
        ));
  }

  Widget _getPrivacyPolicyScreenContent() {
   return StreamBuilder<ModelGetSettingsResponseRemote>(
        stream: _termsAndConditionViewModel.outputSettingsData,
        builder: (context, snapshot)
    {
      return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: AppSize.s30),
              Align(
                alignment: Alignment.center,
                child: Text(
                    textAlign: TextAlign.center,
                    snapshot.data?.data?.isNotEmpty == true ? "${snapshot.data?.data![0].termsVendor}" : "",
                    style: getRegularStyle(
                        color: ColorManager.colorGray72, fontSize: AppSize.s16)),
              ),
              const SizedBox(height: AppSize.s30),
            ],
          ));
    });
  }

  _handleTermsAndConditionStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _termsAndConditionViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _termsAndConditionViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _termsAndConditionViewModel.dispose();
    super.dispose();
  }

}
