import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safiaa/core/helpers/shred.dart';
import 'package:safiaa/core/helpers/spacing.dart';
import 'package:safiaa/core/recourses/color_manager/color_manager.dart';
import 'package:safiaa/core/recourses/styles_manger/styles_manager.dart';
import 'package:safiaa/core/widgets/custom_app_bar.dart';
import 'package:safiaa/core/widgets/custom_botton.dart';
import 'package:safiaa/core/widgets/custom_text_form_field.dart';
import 'package:safiaa/features/orders/data/models/add_order_model.dart';
import 'package:safiaa/features/orders/presentation/cubit/add_order_cubit.dart';

class AddOrderViewBody extends StatefulWidget {
  const AddOrderViewBody({super.key});

  @override
  State<AddOrderViewBody> createState() => _AddOrderViewBodyState();
}

class _AddOrderViewBodyState extends State<AddOrderViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late String city, phoneNumber, detailedAddress, notes;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          children: [
            verticalSpace(10),
            CustomAppBar(
              title: "عنوان التوصيل",
            ),
            Padding(
              padding: EdgeInsets.all(18.w),
              child: Column(
                children: [
                  Text(
                    'تأكد من أن عنوانك داخل المدينة المنورة  لضمان وصول الطلب',
                    style: getRegularStyle(color: Colors.red, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  // Text(
                  //   'من فضلك قم بادخال بياناتك الصحيحة لضمان وصول الطلب بأمان وسرعة',
                  //   style: getRegularStyle(
                  //       color: MyColors.grayscale600, fontSize: 16.sp),
                  // ),
                  verticalSpace(24),
                  CustomTextFormField(
                    hintText: "المدينة",
                    onSaved: (value) {
                      city = value!;
                    },
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: MyColors.grayscale400,
                    ),
                  ),
                  verticalSpace(14),
                  CustomTextFormField(
                    hintText: "رقم الهاتف",
                    onSaved: (value) {
                      phoneNumber = value!;
                    },
                    prefixIcon: Icon(
                      Icons.phone,
                      color: MyColors.grayscale400,
                    ),
                  ),
                  verticalSpace(14),
                  CustomTextFormField(
                    hintText: "تفاصيل العنوان",
                    onSaved: (value) {
                      detailedAddress = value!;
                    },
                    prefixIcon: Icon(
                      Icons.location_searching,
                      color: MyColors.grayscale400,
                    ),
                  ),
                  verticalSpace(14),
                  CustomTextFormField(
                    hintText: "ملاحظات التوصيل",
                    onSaved: (value) {
                      notes = value!;
                    },
                    prefixIcon: Icon(
                      Icons.notes_rounded,
                      color: MyColors.grayscale400,
                    ),
                  ),
                  verticalSpace(200),
                  CustomBotton(
                      text: 'تاكيد الطلب',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          final id = Shareds.getString(prefsKeyId);
                          final cartId = Shareds.getInt(prefsKeyCartId);
                          context.read<AddOrderCubit>().addOrder(AddOrderModel(
                                detailedAddress: detailedAddress.toString(),
                                notes: notes.toString(),
                                phoneNumebr: phoneNumber.toString(),
                                shoppingCartId: cartId,
                                userId: id,
                                shippingAddress: city.toString(),
                              ));
                        } else {
                          setState(() {
                            autoValidateMode = AutovalidateMode.always;
                          });
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:safiaa/core/helpers/shred.dart';
// import 'package:safiaa/core/helpers/spacing.dart';
// import 'package:safiaa/core/recourses/color_manager/color_manager.dart';
// import 'package:safiaa/core/widgets/custom_app_bar.dart';
// import 'package:safiaa/core/widgets/custom_botton.dart';
// import 'package:safiaa/core/widgets/custom_text_form_field.dart';
// import 'package:safiaa/features/orders/data/models/add_order_model.dart';
// import 'package:safiaa/features/orders/presentation/cubit/add_order_cubit.dart';

// class AddOrderViewBody extends StatefulWidget {
//   const AddOrderViewBody({super.key});

//   @override
//   State<AddOrderViewBody> createState() => _AddOrderViewBodyState();
// }

// class _AddOrderViewBodyState extends State<AddOrderViewBody> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

//   // 🔥 إنشاء `TextEditingController` لكل حقل
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController notesController = TextEditingController();

//   // 🔥 متغيرات للتحقق من الحقول الفارغة
//   bool isCityEmpty = false;
//   bool isPhoneEmpty = false;
//   bool isAddressEmpty = false;
//   bool isNotesEmpty = false;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: formKey,
//         autovalidateMode: autoValidateMode,
//         child: Column(
//           children: [
//             verticalSpace(10),
//             CustomAppBar(title: "عنوان التوصيل"),
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Column(
//                 children: [
//                   // 🔥 المدينة
//                   CustomTextFormField(
//                     controller: cityController,
//                     hintText: "المدينة",
//                     boarderColor: isCityEmpty
//                         ? Colors.red
//                         :  MyColors.grayscale200, // ✅ تغيير اللون إذا كان الحقل فارغًا
//                     prefixIcon: const Icon(Icons.location_on),
//                   ),
//                   verticalSpace(14),

//                   // 🔥 رقم الهاتف
//                   CustomTextFormField(
//                     controller: phoneController,
//                     hintText: "رقم الهاتف",
//                     boarderColor: isPhoneEmpty
//                         ? Colors.red
//                         :  MyColors.grayscale200, // ✅ تغيير اللون
//                     prefixIcon: const Icon(Icons.phone),
//                   ),
//                   verticalSpace(14),

//                   // 🔥 تفاصيل العنوان
//                   CustomTextFormField(
//                     controller: addressController,
//                     hintText: "تفاصيل العنوان",
//                     boarderColor: isAddressEmpty
//                         ? Colors.red
//                         : MyColors.grayscale200, // ✅ تغيير اللون
//                     prefixIcon: const Icon(Icons.location_searching),
//                   ),
//                   verticalSpace(14),

//                   // 🔥 ملاحظات التوصيل
//                   CustomTextFormField(
//                     controller: notesController,
//                     hintText: "ملاحظات التوصيل",
//                     boarderColor: isNotesEmpty
//                         ? Colors.red
//                         :  MyColors.grayscale200, // ✅ تغيير اللون
//                     prefixIcon: const Icon(Icons.notes_rounded),
//                   ),
//                   verticalSpace(200),

//                   // 🔥 زر تأكيد الطلب
//                   CustomBotton(
//                     text: 'تاكيد الطلب',
//                     onPressed: () {
//                       setState(() {
//                         // ✅ التحقق من الحقول الفارغة وتحديث لون الحواف
//                         isCityEmpty = cityController.text.trim().isEmpty;
//                         isPhoneEmpty = phoneController.text.trim().isEmpty;
//                         isAddressEmpty = addressController.text.trim().isEmpty;
//                         isNotesEmpty = notesController.text.trim().isEmpty;
//                       });

//                       // ✅ إذا كانت كل الحقول ممتلئة، نقوم بإرسال الطلب
//                       if (!isCityEmpty &&
//                           !isPhoneEmpty &&
//                           !isAddressEmpty &&
//                           !isNotesEmpty &&
//                           formKey.currentState!.validate()) {
//                         final id = Shareds.getString(prefsKeyId);
//                         formKey.currentState!.save();

//                         final cartId = Shareds.getInt(prefsKeyCartId);

//                         context.read<AddOrderCubit>().addOrder(AddOrderModel(
//                               detailedAddress: addressController.text.trim(),
//                               notes: notesController.text.trim(),
//                               phoneNumebr: phoneController.text.trim(),
//                               shoppingCartId: cartId,
//                               userId: id,
//                               shippingAddress: cityController.text.trim(),
//                             ));
//                       } else {
//                         setState(() {
//                           autoValidateMode = AutovalidateMode.always;
//                         });
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
