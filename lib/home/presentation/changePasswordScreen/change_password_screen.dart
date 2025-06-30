import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/state_renderer/state_renderer_impl.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/loading_page.dart';
import '../../../utils/shared_appbar.dart';
import '../../../utils/shared_button.dart';
import '../../../utils/shared_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: ColorManager.white,
          appBar: MyAppBar(title: AppStrings.change_password.tr()),
          body: SafeArea(
              child:
              // StreamBuilder<FlowState>(
              //   stream: _createEmployeeViewModel.outputState,
              //   builder: (context, snapshot) {
              //     if (snapshot.data != null && _createEmployeeViewModel.isOutStateLoading) {
              //       _handleCreateOrUpdateStateChanged(snapshot.data!);
              //     }
              _getChangePasswordScreenContent()
            // },
            // ),
          ),
        ));
  }

  Widget _getChangePasswordScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: AppSize.s30),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSize.s20),
                      MyTextField(
                          hint: AppStrings.enter_current_password.tr(),
                          title: AppStrings.current_password.tr(),
                          suffixIcon: "",
                          obscureText: true,
                          inputType: TextInputType.visiblePassword,
                          controller: _currentPasswordController,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return AppStrings.enterPassword.tr();
                            } else if(_currentPasswordController.text.length < 6){
                              return AppStrings.password_must_be_6_character.tr();
                            } else {
                              null;
                            }
                            return null;
                          },
                          takeValue: (value) {
                            _currentPasswordController.text = value;
                            // _resetPasswordViewModel.resetPasswordRequest.password = value;
                          }
                      ),
                      const SizedBox(height: AppSize.s16),
                      MyTextField(
                          hint: AppStrings.enter_new_password.tr(),
                          title: AppStrings.new_password.tr(),
                          suffixIcon: "",
                          obscureText: true,
                          inputType: TextInputType.visiblePassword,
                          controller: _newPasswordController,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return AppStrings.confirmPassword.tr();
                            }else if(_newPasswordController.text.length < 6){
                              return AppStrings.password_must_be_6_character.tr();
                            }
                            return null;
                          },
                          takeValue: (value) {
                            _newPasswordController.text = value;
                            // _resetPasswordViewModel.resetPasswordRequest.password_confirmation = value;
                          }
                      ),
                      const SizedBox(height: AppSize.s16),
                      MyTextField(
                          hint: AppStrings.confirmPassword.tr(),
                          title: AppStrings.confirmPassword.tr(),
                          suffixIcon: "",
                          obscureText: true,
                          inputType: TextInputType.visiblePassword,
                          controller: _confirmPasswordController,
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return AppStrings.confirmPassword.tr();
                            }else if(_confirmPasswordController.text.length < 6){
                              return AppStrings.password_must_be_6_character.tr();
                            }else if(_confirmPasswordController.text != _newPasswordController.text){
                              return AppStrings.confirm_password_must_at_the_same_password.tr();
                            } else {
                              null;
                            }
                            return null;
                          },
                          takeValue: (value) {
                            _confirmPasswordController.text = value;
                            // _resetPasswordViewModel.resetPasswordRequest.password_confirmation = value;
                          }
                      ),
                      const SizedBox(height: AppSize.s20)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        MyButton(
          color: ColorManager.colorRedB2,
          buttonText: AppStrings.change_password.tr(),
          paddingVertical: AppPadding.p0,
          fun: () {
            if (_formKey.currentState?.validate() ?? false) {
              // _resetPasswordViewModel.resetPassword();
            }
          },
        ),
        const SizedBox(height: AppSize.s16)
      ],
    );
  }

  _handleEditProfileStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        // _createEmployeeViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        // _createEmployeeViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    // _createEmployeeViewModel.dispose();
    super.dispose();
  }
}
