import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safiaa/core/helpers/spacing.dart';
import 'package:safiaa/core/recourses/color_manager/color_manager.dart';
import 'package:safiaa/core/recourses/styles_manger/styles_manager.dart';
import 'package:safiaa/features/home/presentation/cubits/cubit/panners_cubit.dart';
import 'package:safiaa/features/home/presentation/cubits/cubit/panners_state.dart';
import 'package:safiaa/features/home/presentation/widgets/all_proudct_home_list.dart';
import 'package:safiaa/features/home/presentation/widgets/custom_home_app_bar.dart';
import 'package:safiaa/features/home/presentation/widgets/custom_slider.dart';
import 'package:safiaa/features/home/presentation/widgets/home_view_category_list.dart';
import 'package:safiaa/features/products/presentation/cubit/categories/categories_cubit.dart';
import 'package:safiaa/features/products/presentation/cubit/categories/categories_state.dart';
import 'package:safiaa/features/products/presentation/cubit/products/products_cubit.dart';
import 'package:shimmer/shimmer.dart'; // تم إضافتها هنا

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: SafeArea(
        child: Column(
          children: [
            verticalSpace(16),
            const CustomHomeAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(16),

                  /// 🔹 **عرض البنرات**
                  BlocBuilder<PannersCubit, PannersState>(
                    builder: (context, state) {
                      if (state is PannersError) {
                        return const SizedBox();
                      } else if (state is PannersLoaded) {
                        return CustomSlider(imagePaths: state.panners);
                      } else {
                        return buildShimmerBanner(); // ⬅️ **تم استبداله بـ Shimmer**
                      }
                    },
                  ),

                  verticalSpace(16),
                  Text(
                    'قائمة الفئات',
                    textAlign: TextAlign.start,
                    style: getSemiBoldStyle(
                      color: MyColors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  verticalSpace(16),

                  /// 🔹 **عرض الفئات (Categories)**
                  BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                      if (state is CategoriesError) {
                        return buildErrorBar(context, state.message);
                      } else if (state is CategoriesLoaded) {
                        return HomeCategoryListItem(
                            categoriesList: state.categoriesList);
                      } else {
                        return buildShimmerCategories(); // ⬅️ **تم استبداله بـ Shimmer**
                      }
                    },
                  ),

                  verticalSpace(24),
                  Text(
                    'المنتجات',
                    textAlign: TextAlign.start,
                    style: getSemiBoldStyle(
                      color: MyColors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  verticalSpace(16),

                  /// 🔹 **عرض المنتجات**
                  BlocBuilder<ProductsCubit, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsError) {
                        return Center(
                            child: buildErrorBar(context, state.message));
                      } else if (state is ProductsLoaded) {
                        return AllProudctHomeList(product: state.products);
                      } else if (state is ProductsAddedToCart) {
                        context.read<ProductsCubit>().fetchProducts();
                      }

                      return buildShimmerProducts(); // ⬅️ **تم استبداله بـ Shimmer**
                    },
                  ),
                ],
              ),
            ),
            verticalSpace(24),
          ],
        ),
      ),
    );
  }
}

/// 🔥 **شيمر للبنرات**
Widget buildShimmerBanner() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

/// 🔥 **شيمر للفئات (Categories)**
Widget buildShimmerCategories() {
  return SizedBox(
    height: 100.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    ),
  );
}

/// 🔥 **شيمر للمنتجات**
Widget buildShimmerProducts() {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 6,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    },
  );
}

/// 🔥 **واجهة الخطأ**
Widget buildErrorBar(BuildContext context, String message) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
