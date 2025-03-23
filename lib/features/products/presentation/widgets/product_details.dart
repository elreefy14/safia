import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safiaa/core/helpers/guest_user_mixin.dart';
import 'package:safiaa/core/helpers/spacing.dart';
import 'package:safiaa/core/recourses/color_manager/color_manager.dart';
import 'package:safiaa/core/recourses/styles_manger/styles_manager.dart';
import 'package:safiaa/core/widgets/custom_app_bar.dart';
import 'package:safiaa/core/widgets/custom_botton.dart';
import 'package:safiaa/features/products/data/models/categories.dart';
import 'package:safiaa/features/products/presentation/cubit/products/products_cubit.dart';

class ProductDetails extends StatelessWidget with GuestUserMixin {
  final Products products;

  const ProductDetails({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            verticalSpace(10),
            CustomAppBar(
              title: products.title!,
              fontSize: 15.sp,
            ),

            // Main Content
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Product Image
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: Column(
                        children: [
                          // Product Image
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 160.r,
                              backgroundImage: const AssetImage(
                                'assets/images/3.png',
                              ),
                              child: CircleAvatar(
                                radius: 95,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: Image.network(
                                    products.image!,
                                    height: 240,
                                    width: 240,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Product Title
                        ],
                      ),
                    ),

                    // Product Info Card
                    // Container(
                    //   margin: EdgeInsets.all(16.w),
                    //   padding: EdgeInsets.all(16.w),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(16.r),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black.withOpacity(0.05),
                    //         blurRadius: 10,
                    //         offset: const Offset(0, 5),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       // Category
                    //       Row(
                    //         children: [
                    //           Icon(
                    //             Icons.category_outlined,
                    //             color: MyColors.prime,
                    //             size: 20.sp,
                    //           ),
                    //           SizedBox(width: 8.w),
                    //           Text(
                    //             products.category!,
                    //             style: getMediumStyle(
                    //               color: MyColors.grayscale600,
                    //               fontSize: 14.sp,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       verticalSpace(16),

                    //       // Description
                    //       Text(
                    //         "الوصف:",
                    //         style: getBoldStyle(
                    //           color: MyColors.black,
                    //           fontSize: 16.sp,
                    //         ),
                    //       ),
                    //       verticalSpace(8),
                    //       Text(
                    //         products.description!,
                    //         style: getRegularStyle(
                    //           color: MyColors.grayscale600,
                    //           fontSize: 14.sp,
                    //         ),
                    //       ),
                    //       verticalSpace(16),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 7,
                child: Test(
                  products: products,
                  onPressed: () => handleGuestAction(
                    context,
                    action: () {
                      context
                          .read<ProductsCubit>()
                          .addItemToCart(products.id!, 1);
                    },
                    message: 'يجب تسجيل الدخول لإضافة المنتج إلى السلة',
                  ),
                )),
          ],
        ),
      ),

      // Bottom Bar with Price and Add to Cart
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.all(16.w),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black.withOpacity(0.05),
      //         blurRadius: 10,
      //         offset: const Offset(0, -5),
      //       ),
      //     ],
      //   ),
      //   child: Row(
      //     children: [
      //       Column(
      //         mainAxisSize: MainAxisSize.min,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             "السعر",
      //             style: getRegularStyle(
      //               color: MyColors.grayscale600,
      //               fontSize: 12.sp,
      //             ),
      //           ),
      //           Text(
      //             "${products.price} ريال",
      //             style: getBoldStyle(
      //               color: MyColors.prime,
      //               fontSize: 18.sp,
      //             ),
      //           ),
      //         ],
      //       ),
      //       SizedBox(width: 16.w),

      //     ],
      //   ),
      // ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({super.key, required this.products, this.onPressed});
  final Products products;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(color: MyColors.prime),
          color: MyColors.prime,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                products.title!,
                style: getBoldStyle(
                  color: MyColors.white,
                  fontSize: 20.sp,
                ),
              ),
              verticalSpace(15),
              // Product Category
              Row(
                children: [
                  Image.asset(
                    'assets/images/category.png',
                    color: MyColors.white,
                    width: 20.w,
                    height: 20.h,
                  ),
                  horizontalSpace(10),
                  Text(
                    products.category!,
                    style: getBoldStyle(
                      color: MyColors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              verticalSpace(20),
              // Product Description
              Text(
                "الوصف:",
                style: getBoldStyle(
                  color: MyColors.white,
                  fontSize: 18.sp,
                ),
              ),
              verticalSpace(10),
              Text(
                products.description!,
                style: getRegularStyle(
                  color: MyColors.white,
                  fontSize: 14.sp,
                ),
              ),
              verticalSpace(20),
              // Price and Quantity
              // Text(
              //   "الكمية المتوفرة:",
              //   style: getBoldStyle(
              //     color: MyColors.white,
              //     fontSize: 18.sp,
              //   ),
              // ),
              // verticalSpace(10),
              // Text(
              //   "${products.quantity} قطعة",
              //   style: const TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w500,
              //     color: Colors.white,
              //   ),
              // ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 100.h,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: MyColors.white,
                ),
                child: Row(
                  children: [
                    Text(
                      "${products.price} ريال",
                      style: getBoldStyle(
                        color: MyColors.prime,
                        fontSize: 20.sp,
                      ),
                    ),
                    const Spacer(),
                    CustomBotton(
                      text: 'اضف الى السلة',
                      onPressed: onPressed,
                      color: MyColors.prime,
                      textColor: MyColors.white,
                      radius: 100.r,
                      width: 150.w,
                      height: 200.h,
                    ),
                  ],
                ),
              ),
              verticalSpace(10),
              // Action Button
            ],
          ),
        ),
      ),
    );
  }
}
