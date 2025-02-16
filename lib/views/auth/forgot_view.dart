
import 'package:Dofit/utils/exports.dart';
import '../shared/custom_appbar.dart';
import '../shared/custombutton.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Go Back',
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                //textAlign: TextAlign.center,
                text: 'Create New password 🔑',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomText(
                //textAlign: TextAlign.center,
                text:
                    'Please enter a new one and strong password that will be sucuring your account',
                fontSize: 12.sp,
              ),
              SizedBox(
                height: 30,
              ),
              // two textforfield for sign up
              CustomText(text: 'New password', fontSize: 20),
           CustomTextFormField(
                controller: confirmNewPasswordController,
                hint: 'Password',
                isObscure: !isConfirmPasswordVisible,
                prefix: Icon(
                  Icons.lock,
                  color: AppColors.greyColor,
                  size: 25,
                ),
                suffix: IconButton(
                  icon: Icon(
                    isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.greyColor,
                    size: 25,
                  ),
                  onPressed: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(text: 'Conform new password', fontSize: 20),

              CustomTextFormField(
                controller: confirmNewPasswordController,
                hint: 'Password',
                isObscure: !isConfirmPasswordVisible,
                prefix: Icon(
                  Icons.lock,
                  color: AppColors.greyColor,
                  size: 25,
                ),
                suffix: IconButton(
                  icon: Icon(
                    isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.greyColor,
                    size: 25,
                  ),
                  onPressed: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),

              CustomButton(
                title: 'Continue',
                onTap: () {
                 
                  Get.to(OtpView());
                },
                topMargin: 30.0,
                fillColor: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}