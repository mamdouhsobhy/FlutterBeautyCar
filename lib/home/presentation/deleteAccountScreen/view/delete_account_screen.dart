import 'package:beauty_car/app/sharedPrefs/app_prefs.dart';
import 'package:beauty_car/home/presentation/deleteAccountScreen/viewmodel/delete_account_viewmodel.dart';
import 'package:beauty_car/resources/styleManager.dart';
import 'package:beauty_car/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../app/di/di.dart';
import '../../../../app/state_renderer/state_renderer_impl.dart';
import '../../../../authentication/data/response/login/login.dart';
import '../../../../resources/assetsManager.dart';
import '../../../../resources/colorManager.dart';
import '../../../../resources/stringManager.dart';
import '../../../../resources/valuesManager.dart';
import '../../../../utils/loading_page.dart';
import '../../../../utils/shared_appbar.dart';
import '../../../../utils/shared_button.dart';
import '../../../../utils/shared_text_field.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final DeleteAccountViewModel _deleteAccountViewModel = instance<DeleteAccountViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _deleteAccountViewModel.start();
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
          appBar: MyAppBar(title: AppStrings.delete_account.tr()),
          body: SafeArea(
            child:
            StreamBuilder<FlowState>(
              stream: _deleteAccountViewModel.outputState,
              builder: (context, snapshot) {
                if (snapshot.data != null && _deleteAccountViewModel.isOutStateLoading) {
                  _handleDeleteAccountStateChanged(snapshot.data!);
                }
               return _getDeleteAccountScreenContent();
              },
            ),
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
                    StreamBuilder<ModelLoginResponseRemote>(
                        stream: _deleteAccountViewModel.outputDeleteAccountData,
                        builder: (ctx, snapshot) {
                          if (snapshot.data != null && snapshot.data?.status == true) {
                            if(_deleteAccountViewModel.isDeleteAccountLoading){
                              _deleteAccountViewModel.isDeleteAccountLoading = false;
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _navigateToSelectTypeScreen();
                              });
                            }
                          }
                          return MyButton(
                            color: ColorManager.colorRedB2,
                            buttonText: AppStrings.save.tr(),
                            paddingVertical: AppPadding.p0,
                            fun: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _deleteAccountViewModel.deleteAccount(_passwordController.text,"${_appPreferences.getUserType()}");
                              }
                            },
                          );
                        }),
                    const SizedBox(height: AppSize.s60),
                  ],
                )),
          );
  }

  _navigateToSelectTypeScreen() async{
    context.showSuccessToast(AppStrings.account_deleted_successfully.tr());
    await _appPreferences
        .setUserData(ModelLoginResponseRemote());
    await _appPreferences.setUserLoggedIn(false);
    Phoenix.rebirth(context);
  }

  _handleDeleteAccountStateChanged(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoadingState && !isLoadingDialogShowing()) {
        showLoadingDialog(context);
      } else if (state is ErrorState) {
        _deleteAccountViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
        showErrorDialog(context, message: state.getMessage());
      } else if (state is SuccessState) {
        _deleteAccountViewModel.isOutStateLoading = false;
        dismissLoadingDialog();
      } else {
        dismissLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _deleteAccountViewModel.dispose();
    super.dispose();
  }

}
