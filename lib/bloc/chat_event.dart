import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class LoadChats extends ChatEvent {
  @override
  List<Object?> get props => [];
}
