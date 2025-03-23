import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safiaa/core/helpers/guest_user_mixin.dart';
import 'package:safiaa/core/helpers/injection_container.dart' as di;
import 'package:safiaa/core/helpers/spacing.dart';
import 'package:safiaa/core/recourses/color_manager/color_manager.dart';
import 'package:safiaa/core/recourses/styles_manger/styles_manager.dart';
import 'package:safiaa/core/widgets/custom_app_bar.dart';
import 'package:safiaa/features/profile/domain/repositories/profile_repo.dart';
import 'package:safiaa/features/profile/presentation/widgets/profile_view_body.dart';

import '../cubits/cubit/profile_cubit.dart';

class ProfileView extends StatelessWidget with GuestUserMixin {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    if (isGuestUser()) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalSpace(20),
              CustomAppBar(title: 'الملف الشخصي'),
              verticalSpace(20),
              Icon(
                Icons.account_circle_outlined,
                size: 80.sp,
                color: MyColors.grayscale400,
              ),
              verticalSpace(20),
              Text(
                'مرحباً بك',
                style: getBoldStyle(
                  color: MyColors.grayscale600,
                  fontSize: 20.sp,
                ),
              ),
              verticalSpace(8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  'قم بتسجيل الدخول للوصول إلى ملفك الشخصي وطلباتك',
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: MyColors.grayscale500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              verticalSpace(24),
              ElevatedButton(
                onPressed: () => navigateToLogin(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.blue500,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'تسجيل الدخول',
                  style: getMediumStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => ProfileCubit(di.sl<ProfileRepo>())..getProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          if (profileState is ProfileLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (profileState is ProfileLoaded) {
            return Scaffold(
              body: ProfileViewBody(
                profileModel: profileState.profileModel,
              ),
            );
          }

          if (profileState is ProfileError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'حدث خطأ أثناء تحميل الملف الشخصي',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<ProfileCubit>().getProfile();
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
