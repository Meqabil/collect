
import 'package:collect/data/models/settings/context_model.dart';
import 'package:collect/view/widgets/settings/context_dialog.dart';
import 'package:collect/view/widgets/settings/context_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../core/constants/lists.dart';
import '../../../main.dart';



class ContextsScreen extends StatefulWidget {
  const ContextsScreen({super.key});

  @override
  State<ContextsScreen> createState() => _ContextsScreenState();
}

class _ContextsScreenState extends State<ContextsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contexts'.tr),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context,idx){
                  return ContextItem(
                    contextModel: ContextModel(number: idx+1, title: contexts[idx].toString().tr, content: prefs?.getString('context_content_$idx') ?? ''),
                    onEdit: (){
                      showDialog(
                        context: context,
                        builder: (context){
                          return ContextDialog(item: ContextModel(number: idx+1, title: contexts[idx] ?? 'Empty', content: prefs?.getString('context_content_$idx') ?? ''),);
                        }
                      );
                    }
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
