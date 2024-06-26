import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/Theme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductAppBar extends StatefulWidget {
  const ProductAppBar({
    super.key,
  });

  @override
  State<ProductAppBar> createState() => _ProductAppBarState();
}

class _ProductAppBarState extends State<ProductAppBar> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> userdata = [];
  int points = 0;
  getuserPoints() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userphone = pref.getString('phoneNumber');

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('phoneNumber', isEqualTo: userphone)
        .get();
    userdata = querySnapshot.docs;
    setState(() {});
    points = await userdata[0]['points'];
  }

  @override
  void initState() {
    getuserPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        color: kPrimarycolor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(300, 20),
          bottomRight: Radius.elliptical(300, 20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              height: 55.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: kSecondarycolor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "نقطه",
                    style: TextStyle(fontFamily: kFontfamily, fontSize: 18.sp),
                  ),
                  Text(
                    "$points",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: kFontfamily,
                    ),
                  ),
                  Image.asset(
                    'assets/images/coin.png',
                    width: 25.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    width: 60.w,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    height: 55.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: kSecondarycolor,
                    ),
                    child: Icon(Icons.shopping_cart, size: 30.sp),
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width - 90.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  height: 55.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: kSecondarycolor,
                  ),
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        "ما الذي تبحث عنه؟",
                        style:
                            TextStyle(fontSize: 15.sp, fontFamily: kFontfamily),
                      ),
                      Icon(
                        Icons.search,
                        size: 30.sp,
                      ),
                    ],
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
