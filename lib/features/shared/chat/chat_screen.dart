import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:linkwithmentor/features/shared/call/call_screen.dart';

class ChatScreen extends HookWidget {
  final String userName;
  final String userImage;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    final messageController = useTextEditingController();
    final scrollController = useScrollController();
    final isTyping = useState(false);
    final messages = useState<List<Map<String, dynamic>>>([
      {
        'text': 'Hi, I have a question about Flutter state management.',
        'isMe': false,
        'time': DateTime.now().subtract(const Duration(minutes: 5)),
        'status': 'read',
      },
      {
        'text':
            'Hello! Sure, I can help with that. Are you asking about Riverpod or Bloc?',
        'isMe': true,
        'time': DateTime.now().subtract(const Duration(minutes: 4)),
        'status': 'read',
      },
      {
        'text': 'I am confused about when to use Riverpod providers.',
        'isMe': false,
        'time': DateTime.now().subtract(const Duration(minutes: 2)),
        'status': 'read',
      },
    ]);

    void sendMessage() {
      if (messageController.text.trim().isEmpty) return;
      final newMessage = {
        'text': messageController.text.trim(),
        'isMe': true,
        'time': DateTime.now(),
        'status': 'sent',
      };
      messages.value = [...messages.value, newMessage];
      messageController.clear();

      // Simulate reply
      Future.delayed(const Duration(seconds: 1), () {
        if (context.mounted) isTyping.value = true;
      });

      Future.delayed(const Duration(seconds: 3), () {
        if (context.mounted) {
          isTyping.value = false;
          messages.value = [
            ...messages.value,
            {
              'text':
                  'That is a great question! Let me explain with an example...',
              'isMe': false,
              'time': DateTime.now(),
              'status': 'read',
            },
          ];
          // Scroll to bottom
          Future.delayed(const Duration(milliseconds: 100), () {
            if (scrollController.hasClients) {
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(userImage), radius: 20),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isTyping.value)
                  Text(
                    'Typing...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                else
                  const Text(
                    'Online',
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CallScreen(userName: userName, userImage: userImage),
                ),
              );
            },
          ),
          IconButton(icon: const Icon(Icons.phone_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: messages.value.length,
              itemBuilder: (context, index) {
                final message =
                    messages.value[messages.value.length - 1 - index];
                final isMe = message['isMe'] == true;
                final showDate = index == messages.value.length - 1;

                return Column(
                  children: [
                    if (showDate)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Today',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(16).copyWith(
                            bottomRight: isMe ? const Radius.circular(0) : null,
                            bottomLeft: !isMe ? const Radius.circular(0) : null,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              message['text'] as String,
                              style: TextStyle(
                                color: isMe
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                fontSize: 16,
                              ),
                            ),
                            const Gap(4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  DateFormat(
                                    'h:mm a',
                                  ).format(message['time'] as DateTime),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isMe
                                        ? Theme.of(context)
                                              .colorScheme
                                              .onPrimary
                                              .withValues(alpha: 0.7)
                                        : Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant
                                              .withValues(alpha: 0.7),
                                  ),
                                ),
                                if (isMe) ...[
                                  const Gap(4),
                                  Icon(
                                    Icons.done_all,
                                    size: 14,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          _buildMessageInput(context, messageController, sendMessage),
        ],
      ),
    );
  }

  Widget _buildMessageInput(
    BuildContext context,
    TextEditingController controller,
    VoidCallback onSend,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                _showAttachmentSheet(context);
              },
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => onSend(),
                ),
              ),
            ),
            const Gap(8),
            IconButton.filled(
              icon: const Icon(Icons.send_rounded),
              onPressed: onSend,
            ),
          ],
        ),
      ),
    );
  }

  void _showAttachmentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _AttachmentOption(
                  icon: Icons.image,
                  label: 'Gallery',
                  color: Colors.purple,
                  onTap: () => Navigator.pop(context),
                ),
                _AttachmentOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  color: Colors.red,
                  onTap: () => Navigator.pop(context),
                ),
                _AttachmentOption(
                  icon: Icons.description,
                  label: 'Document',
                  color: Colors.blue,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _AttachmentOption(
                  icon: Icons.headset,
                  label: 'Audio',
                  color: Colors.orange,
                  onTap: () => Navigator.pop(context),
                ),
                _AttachmentOption(
                  icon: Icons.location_on,
                  label: 'Location',
                  color: Colors.green,
                  onTap: () => Navigator.pop(context),
                ),
                _AttachmentOption(
                  icon: Icons.person,
                  label: 'Contact',
                  color: Colors.teal,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AttachmentOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const Gap(8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
