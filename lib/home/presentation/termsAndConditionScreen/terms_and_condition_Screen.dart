import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/colorManager.dart';
import '../../../resources/stringManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/shared_appbar.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
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
              // StreamBuilder<FlowState>(
              //   stream: _changePasswordViewModel.outputState,
              //   builder: (context, snapshot) {
              //     if (snapshot.data != null && _changePasswordViewModel.isOutStateLoading) {
              //       _handleChangePasswordStateChanged(snapshot.data!);
              //     }
              _getPrivacyPolicyScreenContent()
            //   },
            // ),
          ),
        ));
  }

  Widget _getPrivacyPolicyScreenContent() {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s30),
            Text("يجب تقديم الخدمات بجودة عالية وبسعر معلن داخل التطبيق يتم تحديث بيانات الورشة والعروض من خلال لوحة التحكم فقط يُمنع قبول الطلبات خارج نظام التطبيق لضمان التوثيق الأرباح تُحوّل بحسب النسب المتفق عليها، ويحق للتطبيق مراجعة الأداء لضمان الجودة تحتفظ الإدارة بحق إيقاف الحساب في حال مخالفة السياسات",
                style: getRegularStyle(
                    color: ColorManager.colorGray72, fontSize: AppSize.s16)),
            const SizedBox(height: AppSize.s30),
          ],
        ));
  }
}
