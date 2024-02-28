import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mockapi/controllers/home_controller.dart';
import 'package:riverpod_mockapi/models/note_model.dart';

class WCreateDetail extends ConsumerWidget {
  final int id;
  const WCreateDetail(
    this.id, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeNotifierProvider);
    var con = ref.read(homeNotifierProvider);
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Change note"),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: con.titleController,
            decoration: const InputDecoration(
              hintText: "Please enter new title",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: con.descController,
            decoration: const InputDecoration(
              hintText: "Please enter new title",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            Note note = Note(
                title: con.titleController.text,
                description: con.descController.text);
            await con.updateData(
              note,
              id,
            );
            con.titleController.clear();
            con.descController.clear();
            Future.delayed(
              Duration.zero,
              () {
                Navigator.pop(context);
              },
            );
            con.titleController.clear();
            con.descController.clear();
          },
          child: const Text("Change"),
        ),
      ],
    );
  }
}
