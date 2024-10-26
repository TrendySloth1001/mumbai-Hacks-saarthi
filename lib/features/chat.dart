import 'package:flutter/material.dart';
import 'package:saarhti/util/constants/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add initial bot message
    _messages.add(
      ChatMessage(
        text:
            "Hi there! I'm LLAMA, your virtual assistant for all coastal things 🌴 Whether you're planning a beach day or need real-time updates on weather and sea conditions, I'm here to help! 🏖",
        isUser: false,
      ),
    );
  }

  void _handleSubmitted(String text) {
    _controller.clear();
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });

    // Simulate bot response
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (text.toLowerCase().contains('juhu')) {
          _messages.add(
            ChatMessage(
              text: """Sure! Here's the current update for Juhu Beach
              
🌊 Swell size: 3.1 ft
🌡️ Water temperature: 76°F""",
              isUser: false,
            ),
          );
        } else {
          _messages.add(
            ChatMessage(
              text: "⚠️  Network Error",
              isUser: false,
            ),
          );
        }
      });
      _scrollToBottom();
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF87CEEB), Color(0xFFE0FFFF)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Set background transparent
        appBar: AppBar(
          backgroundColor:
              Colors.white.withOpacity(0.9), // Slightly opaque white
          elevation: 1,
          leading: const BackButton(color: Colors.black),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[400],
                child: const Text(
                  "∞",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "LLAMA",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Online",
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                itemCount: _messages.length,
                itemBuilder: (context, index) => _messages[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28.0, 8.0, 8.0, 100.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: _controller,
                        decoration: const InputDecoration(
                          
                          hintText: 'Type your message',hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          border: InputBorder.none,
                        ),
                        onSubmitted: _handleSubmitted,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.mic, color: Colors.blue),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          _handleSubmitted(_controller.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            CircleAvatar(
              backgroundColor: Colors.blue[400],
              child: const Text(
                "∞",
                style: TextStyle(color: Colors.white),
              ),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[100] : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isUser ? Colors.blue : Colors.grey.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isUser)
            const CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.person, color: Colors.white),
            ),
        ],
      ),
    );
  }
}
