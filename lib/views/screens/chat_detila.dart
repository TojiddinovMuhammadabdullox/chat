import 'package:flutter/material.dart';
import 'package:chat/models/message_model.dart';

class ChatDetailScreen extends StatelessWidget {
  final ContactModel contact;

  const ChatDetailScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final messages =
        allMessages.where((msg) => msg.contactId == contact.contactId).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('${contact.contactName} ${contact.contactLasName}'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message) {
    final isMe = message.contactId != contact.contactId;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.red[400] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.isFile)
              _buildFileAttachment(message)
            else
              Text(
                message.messageText,
                style: TextStyle(color: isMe ? Colors.white : Colors.black),
              ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.createdTime,
                  style: TextStyle(
                    color: isMe ? Colors.white70 : Colors.black54,
                    fontSize: 12,
                  ),
                ),
                if (message.status)
                  Icon(Icons.done,
                      size: 16, color: isMe ? Colors.white70 : Colors.black54),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileAttachment(MessageModel message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('File Attachment',
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(message.messageText,
            style: const TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline)),
        const SizedBox(height: 4),
        ElevatedButton.icon(
          icon: const Icon(Icons.download),
          label: const Text('Download'),
          onPressed: () {
            // Implement file download logic here
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ],
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your message',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: () {}),
        ],
      ),
    );
  }
}
