// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'dart:convert';
// import 'dart:io';

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   List<Map<String, String>> messages = [];

//   final String chatApiUrl = 'https://your-replit-url/chat';
//   final String imageApiUrl = 'https://your-replit-url/image_processing';

//   Future<void> sendMessage(String message) async {
//     final response = await http.post(
//       Uri.parse(chatApiUrl),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"message": message}),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         messages.add({"type": "user", "text": message});
//         messages.add({"type": "ai", "text": data['response']});
//       });
//     } else {
//       setState(() {
//         messages.add({"type": "error", "text": "Failed to get response from AI."});
//       });
//     }
//   }

//   Future<void> sendImage() async {
//     final picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       final bytes = await File(image.path).readAsBytes();
//       final base64Image = base64Encode(bytes);

//       final response = await http.post(
//         Uri.parse(imageApiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"image": base64Image}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           messages.add({"type": "user", "text": "Image sent."});
//           messages.add({"type": "ai", "text": data['response']});
//         });
//       } else {
//         setState(() {
//           messages.add({"type": "error", "text": "Failed to process image."});
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chat with AI')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(messages[index]['text']!),
//                   subtitle: Text(messages[index]['type']!),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 30.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(hintText: 'Type a message...'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     if (_controller.text.isNotEmpty) {
//                       sendMessage(_controller.text);
//                       _controller.clear();
//                     }
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.image),
//                   onPressed: sendImage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
