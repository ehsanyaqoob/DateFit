import '../../controllers/sign_up_controller.dart';
import '../shared/custom_appbar.dart';
import '../shared/custom_dropdown.dart';
import 'package:Dofit/utils/exports.dart';

import '../shared/custombutton.dart';

class SignUpView extends StatefulWidget {
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpController signUpController = Get.put(SignUpController());
  final RxBool visiblePassword = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Sign Up",
        centerTitle: true,
        onLeadingPressed: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              CustomText(
                text: "Join Us 🎉",
                fontSize: 40.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
              SizedBox(height: 20.h),
              CustomText(
                text: "Create an account to get started.",
                fontSize: 16.sp,
                color: AppColors.greyColor,
              ),
              SizedBox(height: 40.h),

              // Name Field
              CustomTextFormField(
                controller: signUpController.nameController,
                hint: "Full Name",
                title: 'Name',
                prefix: const Icon(Icons.person),
              ),
              SizedBox(height: 20),

              // Phone Number Field
              CustomTextFormField(
                controller: signUpController.phoneController,
                hint: "Phone Number",
                title: 'Phone Number',
                inputType: TextInputType.phone,
                prefix: const Icon(Icons.phone),
              ),
              SizedBox(height: 20),

              // Email Field
              CustomTextFormField(
                controller: signUpController.emailController,
                hint: "Email Address",
                title: 'Email',
                inputType: TextInputType.emailAddress,
                prefix: const Icon(Icons.email),
              ),
              SizedBox(height: 20),

              // Password Field
              Obx(() => CustomTextFormField(
                    controller: signUpController.passwordController,
                    hint: "Password",
                    title: 'Password',
                    isObscure: !visiblePassword.value,
                    prefix: const Icon(Icons.lock),
                    suffix: IconButton(
                      icon: Icon(
                        visiblePassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.greyColor,
                        size: 25,
                      ),
                      onPressed: () {
                        visiblePassword.value = !visiblePassword.value;
                      },
                    ),
                  )),
              SizedBox(height: 20),

              // Gender Dropdown
              Obx(
                () => KupaBottomSheet(
                  title: 'Gender',
                  selectedValue: signUpController.selectedGender.value.isEmpty
                      ? null
                      : signUpController.selectedGender.value,
                  options: ['Male', 'Female', 'Other'],
                  onChanged: (value) {
                    signUpController.selectedGender.value = value!;
                  },
                ),
              ),
              SizedBox(height: 20),

              // Country Field
              CustomTextFormField(
                controller: signUpController.countryController,
                hint: "Country",
                title: 'Country',
                prefix: const Icon(Icons.public),
              ),
              SizedBox(height: 20),

              // Funny Question
              CustomTextFormField(
                controller: signUpController.funnyQuestionController,
                hint: "What’s your favorite pizza topping?",
                title: 'Funny Question',
                prefix: const Icon(Icons.fastfood),
              ),
              SizedBox(height: 30),

              // Sign Up Button
              CustomButton(
                title: "Sign Up",
                onTap: () {
                  signUpController.signUp(); 
                },
              ),
              SizedBox(height: 30),

              // Already have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Already have an account? ",
                    fontSize: 14,
                    color: AppColors.greyColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back(); // Navigate back to the SignInView
                    },
                    child: CustomText(
                      text: "Sign In",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
