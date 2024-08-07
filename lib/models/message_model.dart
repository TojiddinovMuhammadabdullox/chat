class MessageModel {
  final int messageId;
  final String messageText;
  final bool isFile;
  final String createdTime;
  final int contactId;
  final bool status;

  MessageModel({
    required this.createdTime,
    required this.messageText,
    required this.messageId,
    required this.isFile,
    required this.contactId,
    required this.status,
  });
}

class ContactModel {
  final int contactId;
  final String contactName;
  final String contactLasName;
  final bool isOnline;
  final String imageUrl;
  final DateTime lastOnlineTime;

  ContactModel({
    required this.contactId,
    required this.contactLasName,
    required this.contactName,
    required this.isOnline,
    required this.imageUrl,
    required this.lastOnlineTime,
  });
}

List<MessageModel> allMessages = [
  MessageModel(
    createdTime: "2024-03-25 20:41:11.366752",
    messageText: "Vazifa nima bo'ldi alisher?",
    messageId: 1,
    isFile: false,
    contactId: 3,
    status: true,
  ),
  MessageModel(
    createdTime: "2024-04-20 20:41:11.366752",
    messageText: "https://bilimlar.uz/wp-content/uploads/2021/02/k100001.pdf",
    messageId: 1,
    isFile: true,
    contactId: 3,
    status: true,
  ),
];

List<ContactModel> allContacts = [
  ContactModel(
    contactId: 3,
    contactLasName: "Alisher",
    contactName: "Falonchiyev",
    isOnline: true,
    imageUrl: "",
    lastOnlineTime: DateTime.now(),
  )
];
