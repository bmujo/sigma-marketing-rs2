class NewMessage {
  String messageText;
  int receiverId;

  NewMessage({
    required this.messageText,
    required this.receiverId,
  });

  Map<String, dynamic> toJson() {
    return {
      'messageText': messageText,
      'receiverId': receiverId,
    };
  }
}