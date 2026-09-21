import 'package:collect/data/models/settings/context_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../core/constants/lists.dart';
import '../../../main.dart';

class ContextDialog extends StatefulWidget {
  const ContextDialog({super.key,required this.item});
  final ContextModel item;

  @override
  State<ContextDialog> createState() => _ContextDialogState();
}

class _ContextDialogState extends State<ContextDialog> {
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    contentController = TextEditingController(text: prefs?.getString('context_content_${widget.item.number - 1}') ?? '');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('edit_context'.tr),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(contexts[widget.item.number - 1].toString().tr),

            TextField(
              controller: contentController,
              minLines: 4,
              maxLines: 5,
              decoration: InputDecoration(
                  hint: Text('content...'.tr,style: TextStyle(color: Colors.grey.shade500),),
                  border: InputBorder.none
              ),
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('cancel'.tr,style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
        ),

        ElevatedButton(
          onPressed: () {
            setState(() {});
            prefs!.setString('context_content_${widget.item.number - 1}',contentController.text.trim());
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text('save'.tr,style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
        ),
      ],
    );
  }
}
