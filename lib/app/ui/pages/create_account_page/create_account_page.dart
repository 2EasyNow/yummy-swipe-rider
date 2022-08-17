import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intelligent_food_delivery/app/utils/input_formatters.dart';
import '../../../config/app_information.dart';
import '../../../controllers/core/customer.controller.dart';
import '../../../utils/snackbars.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/timer_button.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_theme.dart';
import '../../../utils/bottom_sheets.dart';
import '../../../../assets/assets.gen.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/create_account_controller.dart';
import '../../../routes/app_routes.dart';

class CreateAccountPage extends GetView<CreateAccountController> {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double spaceBetweenFields = 1.5.h;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Account",
            style: AppTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    FontAwesomeIcons.burger,
                    color: AppColors(context).primary,
                    size: 30.w,
                  ),
                ),
                Center(
                  child: Text(
                    AppInformation.title,
                    style: AppTextStyle(fontWeight: FontWeight.w800, fontSize: 24.sp),
                  ),
                ),
                /////////         Name Field         /////////
                Text('Name', style: AppTextStyle(color: AppColors(context).grey400)),
                VerticalSpacer(space: 0.5.h),
                TextFormField(
                  controller: controller.nameController,
                  autofillHints: const [AutofillHints.name],
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) return "Name can't be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Assets.icons.profileOutline.svg(color: AppColors(context).grey600).paddingSymmetric(vertical: 12),
                  ),
                ),
                /////////         Phone Number Field         /////////
                VerticalSpacer(space: spaceBetweenFields),
                Text('Phone Number', style: AppTextStyle(color: AppColors(context).grey400)),
                VerticalSpacer(space: 0.5.h),
                TextFormField(
                  focusNode: controller.phoneNumberScopeNode,
                  controller: controller.phoneController,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                    PakistanPhoneNumberFormatter(separator: '-', smaple: 'XX-XXXXXXX'),
                  ],
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    // Valid Phone format XX-XXXXXXX
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (!RegExp(r'^[0-9]{2}-[0-9]{7}$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Assets.icons.call.svg(color: AppColors(context).grey600).paddingSymmetric(vertical: 12),
                    prefix: Text(
                      '+92 3',
                      style: AppTextStyle(
                        color: AppColors(context).onBackground,
                      ),
                    ),
                  ),
                ),
                /////////         Email Field         /////////
                VerticalSpacer(space: spaceBetweenFields),

                Text('Email', style: AppTextStyle(color: AppColors(context).grey400)),
                VerticalSpacer(space: 0.5.h),
                TextFormField(
                  controller: controller.emailController,
                  autofillHints: const [AutofillHints.email],
                  validator: (value) {
                    if (!GetUtils.isEmail(value!)) return 'Invalid Email';
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    prefixIcon: Assets.icons.message.svg(color: AppColors(context).grey600).paddingSymmetric(vertical: 12),
                  ),
                ),
                /////////         Email Field         /////////
                VerticalSpacer(space: spaceBetweenFields),

                Text('Address', style: AppTextStyle(color: AppColors(context).grey400)),
                VerticalSpacer(space: 0.5.h),
                TextFormField(
                  controller: controller.addressController,
                  autofillHints: const [AutofillHints.postalAddress],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) return 'Address is required';
                    return null;
                  },
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    prefixIcon: Assets.icons.address.svg(color: AppColors(context).grey600).paddingSymmetric(vertical: 12),
                  ),
                ),
                VerticalSpacer(space: 0.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Already have an account?",
                      style: AppTextStyle(color: AppColors(context).grey600),
                    ),
                    GestureDetector(
                      onTap: () => Get.offNamed(AppRoutes.LOGIN),
                      child: Text(
                        " Log In",
                        style: AppTextStyle(
                          color: AppColors(context).primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                VerticalSpacer(space: 1.h),
                /////////         Submit Button         /////////
                TextButton(
                  onPressed: () async {
                    // showLoadingBottomSheet(context, title: 'Creating Account');
                    if (!controller.formKey.currentState!.validate()) return;
                    final customerController = Get.find<CustomerController>();

                    if (await customerController.isCustomerExist(controller.phoneNumber!)) {
                      if (Get.isBottomSheetOpen!) Get.back();
                      showAppSnackBar('User Already Exists', "Please login");
                      controller.phoneNumberScopeNode.requestFocus();
                      return;
                    }
                    Get.bottomSheet(
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: const _CreateAccountBottomSheet(),
                      ),
                    );
                    controller.onCreateAccountWithPhoneNumber();
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(Get.width, 60),
                  ),
                  child: const Text('Create Account'),
                ),
                const VerticalSpacer(),
              ],
            ).paddingSymmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}

class _CreateAccountBottomSheet extends GetView<CreateAccountController> {
  const _CreateAccountBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.elliptical(200, 30),
          ),
        ),
        child: Obx(() {
          if (controller.createAccountState.value == CreateAccountState.verification) {
            return const _LoadingSheetUI(title: 'Creating Account');
          } else if (controller.createAccountState.value == CreateAccountState.codeSent) {
            return const _OTPCodeUI();
          } else if (controller.createAccountState.value == CreateAccountState.userCreation) {
            controller.saveUserData();
            return const _LoadingSheetUI(title: 'Saving Profile');
          } else if (controller.createAccountState.value == CreateAccountState.codeVerificationFailed) {
            return const _InvalidOTPCodeSheetUI();
          } else if (controller.createAccountState.value == CreateAccountState.error) {
            return const _ErrorSheetUI();
          } else if (controller.createAccountState.value == CreateAccountState.userCreated) {
            return const _AccountCreatedSheetUI();
          }
          return Container();
        }),
      ),
    );
  }
}

class _ErrorSheetUI extends GetView<CreateAccountController> {
  const _ErrorSheetUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Error',
          style: AppTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const VerticalSpacer(),
        const Text('Something went wrong. Please try again.'),
        const VerticalSpacer(),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: Get.back,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(Get.width, 60),
                  side: BorderSide(
                    color: AppColors(context).errorDark,
                  ),
                ),
                child: Text(
                  'Close',
                  style: AppTextStyle(
                    color: AppColors(context).errorDark,
                  ),
                ),
              ),
            ),
            const HorizontalSpacer(),
            Expanded(
              child: TextButton(
                onPressed: controller.onCreateAccountWithPhoneNumber,
                style: TextButton.styleFrom(
                  minimumSize: Size(Get.width, 60),
                ),
                child: const Text('Try Again'),
              ),
            ),
          ],
        )
      ],
    ).paddingAll(20);
  }
}

class _InvalidOTPCodeSheetUI extends GetView<CreateAccountController> {
  const _InvalidOTPCodeSheetUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Invalid OTP Code',
          style: AppTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const VerticalSpacer(),
        const Text('You have entered an invalid OTP code. Please try again.'),
        const VerticalSpacer(),
        TextButton(
          onPressed: () {
            controller.createAccountState.value = CreateAccountState.codeSent;
          },
          style: TextButton.styleFrom(
            minimumSize: Size(Get.width, 60),
            backgroundColor: AppColors(context).errorDark,
          ),
          child: Text(
            'Try Again',
            style: AppTextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    ).paddingAll(20);
  }
}

class _OTPCodeUI extends GetView<CreateAccountController> {
  const _OTPCodeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 250,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter OTP Code',
            style: AppTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalSpacer(),
          OTPTextField(
            length: 6,
            width: MediaQuery.of(context).size.width,
            style: const TextStyle(fontSize: 17),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            // spaceBetween: true,
            otpFieldStyle: OtpFieldStyle(
              borderColor: AppColors(context).grey100,
              focusBorderColor: AppColors(context).primary,
              backgroundColor: AppColors(context).grey100,
            ),
            fieldWidth: 50,
            fieldStyle: FieldStyle.box,
            onChanged: (value) {
              controller.smsCodeController.text = value;
            },
            onCompleted: (pin) {
              print("Completed: $pin");
            },
          ),
          const VerticalSpacer(),
          TextButton(
            onPressed: controller.onVerifyCode,
            style: TextButton.styleFrom(
              minimumSize: Size(Get.width, 60),
            ),
            child: const Text('Verify'),
          ),
        ],
      ).paddingAll(20),
    );
  }
}

class _AccountCreatedSheetUI extends StatelessWidget {
  const _AccountCreatedSheetUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Account Created',
          style: AppTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const VerticalSpacer(),
        Icon(
          Icons.check_circle,
          color: AppColors(context).success,
          size: 90,
        ),
        const VerticalSpacer(),
        TimerButton(
          onTap: () => Get.offAllNamed(AppRoutes.HOME),
          time: 3,
          backgroundColor: AppColors(context).primary,
          textColor: AppColors(context).onPrimary,
          title: 'Continue',
        ),
      ],
    ).paddingAll(20);
  }
}

class _LoadingSheetUI extends StatelessWidget {
  const _LoadingSheetUI({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SizedBox(
              child: SpinKitCircle(
                color: AppColors(context).primary,
              ),
            ),
          )
        ],
      ).paddingAll(20),
    );
  }
}
