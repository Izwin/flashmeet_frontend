import 'package:flash_meet_frontend/core/ui/default_text_field.dart';
import 'package:flash_meet_frontend/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flash_meet_frontend/features/chat/presentation/bloc/chat_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterMessageWidget extends StatefulWidget {
  final String meetId;

  const EnterMessageWidget({super.key, required this.meetId});

  @override
  State<EnterMessageWidget> createState() => _EnterMessageWidgetState();
}

class _EnterMessageWidgetState extends State<EnterMessageWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
              child: DefaultTextField(
            hintText: 'Enter your message...',
            controller: controller,
          )),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              if (controller.text.isEmpty) return;
              context.read<ChatBloc>().add(SendMessageEvent(
                  meetingId: widget.meetId, text: controller.text));
              controller.clear();
            },
            icon: Icon(CupertinoIcons.arrow_right_circle_fill),
            style: IconButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.surface,
                backgroundColor: Theme.of(context).colorScheme.primary),
          )
        ],
      ),
    );
  }
}
