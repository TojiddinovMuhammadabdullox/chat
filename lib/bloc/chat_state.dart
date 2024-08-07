import 'package:equatable/equatable.dart';
import 'package:chat/models/message_model.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatLoading extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatLoaded extends ChatState {
  final List<ContactModel> contacts;
  final List<MessageModel> messages;

  const ChatLoaded(this.contacts, this.messages);

  @override
  List<Object?> get props => [contacts, messages];
}

class ChatError extends ChatState {
  final String error;

  const ChatError(this.error);

  @override
  List<Object?> get props => [error];
}
