// chat_screen.dart
import 'package:chat/bloc/chat_bloc.dart';
import 'package:chat/bloc/chat_event.dart';
import 'package:chat/bloc/chat_state.dart';
import 'package:chat/views/screens/chat_detila.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  List<String> images = [
    "assets/person1.png",
    "assets/person2.png",
    "assets/person3.png",
    "assets/person4.png",
    "assets/person5.png",
    "assets/person6.png",
  ];

  List<String> names = [
    "Victoria A.",
    "Demola A.",
    "Tobi Ozen.",
    "Busola Aj.",
    "Michael B.",
    "Sarah C.",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc()..add(LoadChats()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Conversations',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildStoryAvatar("Your Story", isAdd: true),
                    for (var i = 0; i < names.length; i++)
                      buildStoryAvatar(names[i], imagePath: images[i]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ChatLoaded) {
                      return ListView.builder(
                        itemCount: state.contacts.length,
                        itemBuilder: (context, index) {
                          final contact = state.contacts[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.grey[300],
                              backgroundImage:
                                  AssetImage(images[index % images.length]),
                            ),
                            title: Text(
                                '${contact.contactName} ${contact.contactLasName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: const Text('Last message preview...'),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('11:20 am',
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 12)),
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      ChatDetailScreen(contact: contact),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (state is ChatError) {
                      return Center(
                        child: Text('Failed to load chats: ${state.error}'),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: ''),
          ],
          currentIndex: 1,
        ),
      ),
    );
  }

  Widget buildStoryAvatar(
    String name, {
    bool isAdd = false,
    String imagePath = "",
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            backgroundImage: isAdd ? null : AssetImage(imagePath),
            child: isAdd ? const Icon(Icons.add, size: 30) : null,
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
