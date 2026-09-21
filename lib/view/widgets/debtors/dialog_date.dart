import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DialogDate extends StatelessWidget {
  const DialogDate({super.key,required this.initialDate,required this.onChangeDate});
  final void Function(DateTime) onChangeDate;
  final DateTime initialDate;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          alignment: Alignment.center,
          width: appSizes.width ,
          height: appSizes.height ,
          margin: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                 mainAxisSize: MainAxisSize.min,
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: AppColors.mainAppColor, // Header background & selected day circle
                          onPrimary: Colors.white,    // Header text & selected day text
                          onSurface: AppColors.mainAppColor,  // Default text color for days and months
                        ),
                      ),
                      child: CalendarDatePicker(
                          initialDate: initialDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2027),
                          onDateChanged: onChangeDate
                      ),
                    ),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(appSizes.width , 50),
                            backgroundColor: AppColors.mainAppColor
                        ),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel",style: TextStyle(color: Colors.white),)
                    )
                  ],
                )

            ),
          )
      ),
    );
  }
}
