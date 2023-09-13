class MessageModel {
  int id = 0;
  DateTime created = DateTime.now();
  String messageText = "";
  int senderId = 0;
  int receiverId = 0;
  int messageOwnerId = 0;
  bool isRead = false;
  String senderImage = "";
  String receiverImage = "";
  bool isMe = false;

  MessageModel(
      {required this.id,
      required this.created,
      required this.messageText,
      required this.senderId,
      required this.receiverId,
      required this.messageOwnerId,
      required this.isRead,
      required this.senderImage,
      required this.receiverImage,
      required this.isMe});
}
