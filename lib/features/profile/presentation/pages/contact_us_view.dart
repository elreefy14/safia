import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safiaa/core/helpers/spacing.dart';
import 'package:safiaa/core/recourses/color_manager/color_manager.dart';
import 'package:safiaa/core/recourses/styles_manger/styles_manager.dart';
import 'package:safiaa/core/widgets/custom_app_bar.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  final String phoneNumber = "0599043939";
  final String whatsappNumber =
      "966599043939"; // بدون الصفر الأول مع مفتاح الدولة
  // بدون الصفر الأول مع مفتاح الدولة
  final String email = "safiamedina63@gmail.com";

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold), // تكبير النص
          ),
          duration: const Duration(seconds: 3), // مدة أطول للظهور
          backgroundColor: Colors.blueAccent, // لون خلفية أكثر وضوحًا
          behavior: SnackBarBehavior.floating, // جعله عائمًا
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // حواف مستديرة
          ),
          action: SnackBarAction(
            label: 'إغلاق',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar(title: 'تواصل معنا'),
                verticalSpace(16),
                Text(
                  'إذا كنت بحاجة إلى أي مساعدة، يمكنك التواصل معنا عبر الطرق التالية:',
                  style:
                      getSemiBoldStyle(color: MyColors.black, fontSize: 14.sp)
                          .copyWith(height: 1.8),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(24),
                ContactOption(
                  icon: 'assets/images/phone.png',
                  title: 'اتصل بنا',
                  subtitle: phoneNumber,
                  onTap: () => _copyToClipboard(
                      context, phoneNumber, 'تم نسخ رقم الهاتف!'),
                ),
                ContactOption(
                  icon: 'assets/images/whatsapp.png',
                  title: 'واتساب',
                  subtitle: 'راسلنا عبر واتساب',
                  onTap: () => _copyToClipboard(context, whatsappNumber,
                      'تم نسخ رقم التواصل عبر واتساب!'),
                ),
                ContactOption(
                  icon: 'assets/images/gmail.png',
                  title: 'البريد الإلكتروني',
                  subtitle: email,
                  onTap: () => _copyToClipboard(
                      context, email, 'تم نسخ البريد الإلكتروني!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactOption extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ContactOption({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: Image.asset(
          icon,
          width: 30.w,
          height: 30.h,
          fit: BoxFit.contain,
          color: MyColors.prime,
        ),
        title: Text(
          title,
          style: getSemiBoldStyle(color: MyColors.black, fontSize: 14.sp),
        ),
        subtitle: Text(
          subtitle,
          style: getRegularStyle(color: MyColors.grayscale700, fontSize: 12.sp),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
