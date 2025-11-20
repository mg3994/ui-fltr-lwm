import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class CreatePostScreen extends HookWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final bodyController = useTextEditingController();
    final selectedTag = useState<String?>('Flutter');
    final hasImage = useState(false);
    final isPreview = useState(false);

    final tags = ['Flutter', 'Career', 'Interview', 'Resume', 'Dart'];

    void showSuccessAnimation() {
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: 'Success',
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => const SizedBox(),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.elasticOut),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.green,
                        size: 48,
                      ),
                    ),
                    const Gap(16),
                    const Text(
                      'Posted Successfully!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    const Text(
                      'Your question has been shared with the community.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Close dialog
        Navigator.of(context).pop(); // Close screen
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Question'),
        actions: [
          IconButton(
            icon: Icon(isPreview.value ? Icons.edit : Icons.visibility),
            onPressed: () => isPreview.value = !isPreview.value,
            tooltip: isPreview.value ? 'Edit' : 'Preview',
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  bodyController.text.isNotEmpty) {
                showSuccessAnimation();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields')),
                );
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
      body: isPreview.value
          ? _buildPreview(
              context,
              titleController.text,
              bodyController.text,
              selectedTag.value,
              hasImage.value,
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'e.g. How to optimize Flutter performance?',
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const Divider(),
                const Gap(16),
                const Text(
                  'Select Tag',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                Wrap(
                  spacing: 8,
                  children: tags.map((tag) {
                    return ChoiceChip(
                      label: Text(tag),
                      selected: selectedTag.value == tag,
                      onSelected: (selected) {
                        if (selected) selectedTag.value = tag;
                      },
                    );
                  }).toList(),
                ),
                const Gap(24),
                TextField(
                  controller: bodyController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Describe your question in detail...',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const Gap(16),
                InkWell(
                  onTap: () => hasImage.value = !hasImage.value,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      image: hasImage.value
                          ? const DecorationImage(
                              image: NetworkImage(
                                'https://picsum.photos/seed/post/800/400',
                              ),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: hasImage.value
                        ? Stack(
                            children: [
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton.filled(
                                  onPressed: () => hasImage.value = false,
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 48,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const Gap(8),
                              Text(
                                'Add Image',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPreview(
    BuildContext context,
    String title,
    String body,
    String? tag,
    bool hasImage,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Text('M', style: TextStyle(color: Colors.white)),
              ),
              title: const Text(
                'Manish',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Just now'),
            ),
            if (hasImage)
              Image.network(
                'https://picsum.photos/seed/post/800/400',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (tag != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  const Gap(12),
                  Text(
                    title.isEmpty ? 'Your Title Here' : title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    body.isEmpty ? 'Your description here...' : body,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
