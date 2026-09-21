import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:collect/view/screens/auth/login_screen.dart';
import 'package:collect/view/screens/auth/sign_up_screen.dart';
import 'package:collect/view/widgets/auth/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}


class _AuthScreenState extends State<AuthScreen> {
  int pageNum = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    return Scaffold(

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: isNotPhone ? appSizes.width / 2 : appSizes.width,
            height: isPortrait && !isNotPhone ? appSizes.height : isNotPhone ? appSizes.height * 1 : appSizes.height * 1.2,
            padding: EdgeInsets.all(12),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Text("collect".tr,style: TextStyle(fontSize:   isPortrait && !isNotPhone ? appSizes.width * 0.06 : isNotPhone ? appSizes.width * 0.05 : appSizes.height * 0.05,fontWeight: FontWeight.bold),),
                Text("auth_desc".tr,style: TextStyle(fontSize: isPortrait && !isNotPhone ? appSizes.width * .04 : isNotPhone ? appSizes.width * 0.015 : appSizes.height * 0.015),),
                SizedBox(height: 5,),
                Container(
                  width: isNotPhone ? appSizes.width / 2 - 50 : appSizes.width,
                  height: appSizes.height / 1.39,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: 10,color: AppColors.mainAppColor)
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.grey  ,blurRadius: 4,spreadRadius: 1)
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TabButton(
                            title: "login".tr,
                            onTap: (){
                              controller.animateToPage(
                                pageNum-1,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease
                              );
                            }
                          ),
                          TabButton(
                            title: "sign_up".tr,
                            onTap: (){
                              controller.animateToPage(
                                  pageNum+1,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease
                              );
                            }
                          ),

                        ],
                      ),

                      SizedBox(height: 15,),
                      Divider(
                        height: 0,
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: pageNum == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
                        children: [
                           Container(
                            width: isNotPhone ? appSizes.width / 4 - 20 : appSizes.width / 2 - 12,
                            height: 3,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PageView(
                            controller: controller,
                            onPageChanged: (pageNumber){
                              pageNum = pageNumber;
                              setState(() {});
                            },
                            children: [
                              LoginScreen(),
                              SignUpScreen()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}
