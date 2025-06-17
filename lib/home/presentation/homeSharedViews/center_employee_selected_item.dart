import 'package:beauty_car/home/data/response/employees/employees.dart';
import 'package:beauty_car/resources/assetsManager.dart';
import 'package:beauty_car/resources/stringManager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../resources/colorManager.dart';
import '../../../resources/styleManager.dart';
import '../../../resources/valuesManager.dart';
import '../../../utils/shared_button.dart';
import '../../../utils/shared_text_field.dart';

class CenterEmployeeSelectedItem extends StatefulWidget {
  final String title;
  final List<Data>? employee;
  final Function(Data) selectedEmployee;

  CenterEmployeeSelectedItem(
      this.title,
      this.employee,
      {super.key, required this.selectedEmployee});

  @override
  _CenterEmployeeSelectedItemState createState() =>
      _CenterEmployeeSelectedItemState();
}

class _CenterEmployeeSelectedItemState
    extends State<CenterEmployeeSelectedItem> {

  final TextEditingController _searchController = TextEditingController();
  Data? _selectedEmployee;
  List<Data> filteredEmployee = [];

  @override
  void initState() {
    super.initState();
    filteredEmployee = widget.employee!;  // Initially show all places
  }

  void _searchEmployee(String query) {
    setState(() {
      filteredEmployee = widget.employee!.where((service) {
        return service.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: AppSize.s24),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Text(
                widget.title,
                style: getBoldStyle(
                  fontSize: AppSize.s20,
                  color: ColorManager.colorBlack_0D
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSize.s16),
          MyTextField(hint: AppStrings.search.tr(), obscureText: false,validator: null, inputType: TextInputType.text, takeValue: (value){
            _searchEmployee(value);
          }, controller: _searchController, title: "", suffixIcon: ImageAssets.searchIcon),
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(AppSize.s16),
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager.colorGrayD2),
                borderRadius: BorderRadius.circular(AppSize.s16),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: filteredEmployee.length,
                separatorBuilder: (context, index) => Divider(
                  height: AppSize.s1,
                  color: ColorManager.colorGrayD2,
                ),
                itemBuilder: (context, index) {
                  final item = filteredEmployee[index];
                  return RadioListTile<Data>(
                    value: item,
                    groupValue: _selectedEmployee,
                    onChanged: (employee) {
                      setState(() {
                        _selectedEmployee = employee!;
                      });
                    },
                    title: Text(
                      item.name ?? "",
                      style: getSemiBoldStyle(
                        fontSize: AppSize.s16,
                        color: ColorManager.colorBlack_0D
                      ),
                    ),
                    activeColor: ColorManager.colorRedB5,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    shape: RoundedRectangleBorder(
                      borderRadius: index == 0
                          ? const BorderRadius.vertical(
                          top: Radius.circular(AppSize.s16))
                          : index == widget.employee!.length - 1
                          ? const BorderRadius.vertical(
                          bottom: Radius.circular(AppSize.s16))
                          : BorderRadius.zero,
                    ),
                  );
                },
              ),
            ),
          ),
          MyButton(
            color: ColorManager.colorRedB2,
            buttonText: AppStrings.confirm.tr(),
            fun: () {
              if (_selectedEmployee != null) {
                widget.selectedEmployee(_selectedEmployee!);
              }
            }
          )
        ],
      ),
    );
  }
}
