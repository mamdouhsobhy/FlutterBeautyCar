import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../app/di/di.dart';
import '../../../app/state_renderer/state_renderer_impl.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/loading_page.dart';
import '../../../utils/shared_appbar.dart';
import '../../data/response/getSettings/get_settings.dart';
import '../termsAndConditionScreen/viewmodel/terms_and_condition_viewmodel.dart';

class PrivacyPolicyPageScreen extends StatefulWidget {
  const PrivacyPolicyPageScreen({super.key});

  @override
  State<PrivacyPolicyPageScreen> createState() =>
      _PrivacyPolicyPageScreenState();
}

class _PrivacyPolicyPageScreenState extends State<PrivacyPolicyPageScreen> {

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
          appBar: MyAppBar(title: AppStrings.privacy_policy.tr()),
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
                    child: Html(
                        data:snapshot.data?.data?.isNotEmpty == true ? "${snapshot.data?.data![0].privacyVendor}" : ""),
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
