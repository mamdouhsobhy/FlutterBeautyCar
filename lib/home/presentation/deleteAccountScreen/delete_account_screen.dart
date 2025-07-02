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
import '../../../utils/shared_button.dart';
import '../../../utils/shared_text_field.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {

  final TextEditingController _passwordController = TextEditingController();
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
          appBar: MyAppBar(title: AppStrings.delete_account.tr()),
          body: SafeArea(
            child:
            // StreamBuilder<FlowState>(
            //   stream: _changePasswordViewModel.outputState,
            //   builder: (context, snapshot) {
            //     if (snapshot.data != null && _changePasswordViewModel.isOutStateLoading) {
            //       _handleChangePasswordStateChanged(snapshot.data!);
            //     }
                 _getDeleteAccountScreenContent()
            //   },
            // ),
          ),
        ));
  }

  Widget _getDeleteAccountScreenContent() {
   return Form(autovalidateMode: AutovalidateMode.onUnfocus,
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSize.s30),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(ImageAssets.deleteAccountIcon),
                    ),
                    const SizedBox(height: AppSize.s24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                      child: Text(AppStrings.if_you_want_delete_account.tr(),textAlign: TextAlign.center,style: getRegularStyle(color: ColorManager.colorGray72
                          ,fontSize: AppSize.s16)),
                    )
                    ,
                    const SizedBox(height: AppSize.s16),
                    MyTextField(
                        hint: AppStrings.enterPassword.tr(),
                        title: AppStrings.password.tr(),
                        suffixIcon: "",
                        obscureText: true,
                        inputType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return AppStrings.enterPassword.tr();
                          } else if(_passwordController.text.length < 6){
                            return AppStrings.password_must_be_6_character.tr();
                          } else {
                            null;
                          }
                          return null;
                        },
                        takeValue: (value) {
                          _passwordController.text = value;
                        }
                    ),
                    const SizedBox(height: AppSize.s30),
                    MyButton(
                      color: ColorManager.colorRedB2,
                      buttonText: AppStrings.sign_in.tr(),
                      paddingVertical: AppPadding.p0,
                      fun: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // if (!_isTermsAccepted) {
                          //   context.showErrorToast(AppStrings.agree_terms_conditions.tr());
                          //   return;
                          // }else{
                          //   _loginViewModel.login();
                          // }
                          // Handle login
                        }
                      },
                    ),
                    const SizedBox(height: AppSize.s60),
                  ],
                )),
          );
  }
}
