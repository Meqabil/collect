
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../data/models/settings/context_model.dart';

class ContextItem extends StatelessWidget {
  final ContextModel contextModel;
  final VoidCallback onEdit;

  const ContextItem({
    super.key,
    required this.contextModel,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(45),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffE8F5EF),

                  borderRadius: BorderRadius.circular(12),
                ),

                child: Text(
                  '${contextModel.number}',
                  style: const TextStyle(
                    color: Color(0xff16804B),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  contextModel.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1F2A44),
                  ),
                ),
              ),

              IconButton(
                onPressed: onEdit,

                icon: const Icon(
                  Icons.edit_outlined,
                  color: Color(0xff16804B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(thickness: .5,),
          const SizedBox(height: 10),

          Text(
            contextModel.content == '' ? "empty".tr : contextModel.content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff667085),
              height: 1.6,
            ),
          ),

          const SizedBox(height: 16),

        ],
      ),
    );
  }
}