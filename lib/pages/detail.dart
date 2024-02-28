import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mockapi/controllers/home_controller.dart';
import 'package:riverpod_mockapi/models/note_model.dart';

class WDetail extends ConsumerWidget {
  final TextEditingController titleController;
  final TextEditingController descController;
  const WDetail({
    super.key,
    required this.titleController,
    required this.descController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeNotifierProvider);
    var con = ref.read(homeNotifierProvider);
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Create new note"),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Please enter title",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: descController,
            decoration: const InputDecoration(
              hintText: "Please enter title",
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
                title: titleController.text, description: descController.text);
            await con.createNote(note);
            Future.delayed(
              Duration.zero,
              () {
                Navigator.pop(context);
                titleController.clear();
                descController.clear();
              },
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
