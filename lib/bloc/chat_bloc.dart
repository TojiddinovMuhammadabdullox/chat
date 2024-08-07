// chat_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:chat/bloc/chat_event.dart';
import 'package:chat/bloc/chat_state.dart';
import 'package:chat/models/message_model.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatLoading()) {
    on<LoadChats>(_onLoadChats);
  }

  void _onLoadChats(LoadChats event, Emitter<ChatState> emit) async {
    try {
      // Simulate fetching data
      await Future.delayed(const Duration(seconds: 2));
      final contacts = [
        ContactModel(
          contactId: 3,
          contactLasName: "Alisher",
          contactName: "Falonchiyev",
          isOnline: true,
          imageUrl: "",
          lastOnlineTime: DateTime.now(),
        ),
        // Add more contacts as needed
      ];
      final messages = [
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
          messageText:
              "https://bilimlar.uz/wp-content/uploads/2021/02/k100001.pdf",
          messageId: 2,
          isFile: true,
          contactId: 3,
          status: true,
        ),
      ];

      emit(ChatLoaded(contacts, messages));
    } catch (error) {
      emit(ChatError(error.toString()));
    }
  }
}
