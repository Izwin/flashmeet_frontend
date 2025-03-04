abstract class ChatEvent{}

class JoinChatEvent extends ChatEvent{
  final String meetingId;

  JoinChatEvent({required this.meetingId});
}

class SendMessageEvent extends ChatEvent{
  final String meetingId;
  final String text;

  SendMessageEvent({required this.meetingId, required this.text});
}

class GetMessagesEvent extends ChatEvent{
  final bool refresh;
  final String meetId;

  GetMessagesEvent({this.refresh = false, required this.meetId});
}