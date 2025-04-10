import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toktik/features/chat/domain/usecases/get_message_stream.dart';
import 'package:toktik/features/chat/presentation/cubits/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final GetMessageStream _getMessageStream;
  StreamSubscription? _messageSubscription;

  MessageCubit({required GetMessageStream getMessageStream})
    : _getMessageStream = getMessageStream,
      super(MessageLoading());

  void init(String chatId) {
    _messageSubscription?.cancel();

    _messageSubscription = _getMessageStream(chatId).listen(
      (messages) => emit(MessageLoaded(messages: messages)),
      onError: (e) => emit(MessageError(message: e.toString())),
    );
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
