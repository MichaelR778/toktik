import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/chat/domain/usecases/get_user_chat_stream.dart';
import 'package:toktik/features/chat/presentation/cubits/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetUserChatStream _getuserChatStream;
  StreamSubscription? _chatSubscription;

  ChatCubit({required GetUserChatStream getuserChatStream})
    : _getuserChatStream = getuserChatStream,
      super(ChatLoading());

  void init() {
    _chatSubscription?.cancel();

    _chatSubscription = _getuserChatStream().listen(
      (chats) => emit(ChatLoaded(chats: chats)),
      onError: (e) => emit(ChatError(message: e.toString())),
    );
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
