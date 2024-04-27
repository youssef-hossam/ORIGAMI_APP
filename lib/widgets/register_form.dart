import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/screens/login_screen.dart';

import '../Theme/colors.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> form = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool isloading = false;

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(
              label: 'الاسم',
              hint: 'ادخل اسمك',
              icon: Icons.person,
              obscure: false,
              controller: name,
            ),
            SizedBox(
              height: 5.h,
            ),
            CustomTextField(
                obscure: false,
                label: 'رقم الهاتف ',
                hint: 'ادخل رقم هاتفك',
                icon: Icons.phone,
                controller: phone),
            SizedBox(
              height: 5.h,
            ),
            CustomTextField(
              obscure: true,
              label: 'الباسورد',
              hint: 'ادخل كلمه المرور',
              icon: Icons.lock,
              controller: pass,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              ontap: () async {
                if (form.currentState!.validate()) {
                  isloading = true;
                  setState(() {});
                  await users.add({
                    'name': name.text.trim(),
                    'phoneNumber': phone.text.trim(),
                    'password': pass.text.trim(),
                  });
                  isloading = false;
                  setState(() {});
                }
              },
              text: isloading ? '...' : 'إنشاء حساب',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false);
                    },
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          color: primarycolor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    )),
                const Text(
                  "!لديك حساب بالفعل",
                  style: TextStyle(
                    fontFamily: 'NotoKufiArabic',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
