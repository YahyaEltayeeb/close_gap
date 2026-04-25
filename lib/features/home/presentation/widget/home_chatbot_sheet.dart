import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/core/helpers/spacing.dart';
import 'package:close_gap/features/chatbot/presentation/manager/chatbot_cubit.dart';
import 'package:close_gap/features/chatbot/presentation/manager/chatbot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeChatbotSheet extends StatefulWidget {
  const HomeChatbotSheet({super.key});

  @override
  State<HomeChatbotSheet> createState() => _HomeChatbotSheetState();
}

class _HomeChatbotSheetState extends State<HomeChatbotSheet> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  static const List<String> _suggestedPrompts = [
    'Explain Flutter to me',
    'How do I become a Flutter developer?',
    'How can I improve my CV?',
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage([String? message]) {
    final text = (message ?? _controller.text).trim();
    if (text.isEmpty) {
      return;
    }

    context.read<ChatbotCubit>().sendMessage(text);
    if (message == null) {
      _controller.clear();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatbotCubit, ChatbotState>(
      listenWhen: (previous, current) =>
          previous.messages.length != current.messages.length ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        _scrollToBottom();
        if (state.errorMessage == null) {
          return;
        }

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        context.read<ChatbotCubit>().clearError();
      },
      builder: (context, state) {
        final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

        return SafeArea(
          top: false,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.fromLTRB(20, 12, 20, bottomInset + 20),
            child: SizedBox(
              height: context.height * .78,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4DCE7),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  verticalSpace(18),
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF4FF),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.smart_toy_outlined,
                          color: AppColors.lightPrimary,
                        ),
                      ),
                      horizontalSpace(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CloseGap Assistant',
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            verticalSpace(4),
                            Text(
                              'Ask anything and type your message directly below.',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(16),
                  SizedBox(
                    height: 42,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _suggestedPrompts.length,
                      separatorBuilder: (context, index) => horizontalSpace(8),
                      itemBuilder: (context, index) {
                        return _PromptChip(
                          label: _suggestedPrompts[index],
                          onTap: state.isSending
                              ? null
                              : () => _sendMessage(_suggestedPrompts[index]),
                        );
                      },
                    ),
                  ),
                  verticalSpace(16),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7FAFF),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFDCE9F8)),
                      ),
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount:
                            state.messages.length + (state.isSending ? 1 : 0),
                        separatorBuilder: (context, index) => verticalSpace(10),
                        itemBuilder: (context, index) {
                          if (index >= state.messages.length) {
                            return const _TypingBubble();
                          }

                          final message = state.messages[index];
                          return _ChatBubble(
                            text: message.text,
                            isUser: message.isUser,
                          );
                        },
                      ),
                    ),
                  ),
                  verticalSpace(14),
                  Container(
                    padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFFDCE9F8)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            autofocus: true,
                            textInputAction: TextInputAction.send,
                            minLines: 1,
                            maxLines: 4,
                            enabled: !state.isSending,
                            onSubmitted: (_) => _sendMessage(),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your message here...',
                            ),
                          ),
                        ),
                        horizontalSpace(8),
                        FilledButton(
                          onPressed: state.isSending ? null : _sendMessage,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.lightPrimary,
                            minimumSize: const Size(52, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: state.isSending
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.send_rounded),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.text, required this.isUser});

  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: context.width * .72),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? AppColors.lightPrimary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 6),
            bottomRight: Radius.circular(isUser ? 6 : 18),
          ),
        ),
        child: Text(
          text,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isUser ? Colors.white : const Color(0xFF162033),
            height: 1.45,
          ),
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 10),
            Text('Typing...'),
          ],
        ),
      ),
    );
  }
}

class _PromptChip extends StatelessWidget {
  const _PromptChip({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDCE9F8)),
        ),
        child: Center(
          child: Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
