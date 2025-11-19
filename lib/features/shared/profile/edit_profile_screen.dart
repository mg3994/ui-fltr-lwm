import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:linkwithmentor/core/state/app_state.dart';

class EditProfileScreen extends HookWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(
      text: appState.userName.value,
    );
    final bioController = useTextEditingController(
      text: 'Senior Flutter Developer | Open Source Enthusiast',
    );
    final titleController = useTextEditingController(
      text: 'Senior Software Engineer',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              appState.userName.value = nameController.text;
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Profile Updated')));
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(appState.userAvatar.value),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(32),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(16),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Professional Title',
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(16),
          TextField(
            controller: bioController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Bio',
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(16),
          const Text('Skills', style: TextStyle(fontWeight: FontWeight.bold)),
          const Gap(8),
          Wrap(
            spacing: 8,
            children: [
              Chip(label: const Text('Flutter'), onDeleted: () {}),
              Chip(label: const Text('Dart'), onDeleted: () {}),
              Chip(label: const Text('Firebase'), onDeleted: () {}),
              ActionChip(
                label: const Text('Add Skill'),
                avatar: const Icon(Icons.add, size: 16),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
