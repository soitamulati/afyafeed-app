import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _service = FirebaseService();
  String? _selectedVideoId;

  void _showCommentSheet(String videoId) {
    setState(() => _selectedVideoId = videoId);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CommentSheet(videoId: videoId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AfyaFeed")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _service.getVideos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return PageView.builder( // vertical scroll like TikTok
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var video = snapshot.data!.docs[index];
              return Stack(
                children: [
                  // Video Player would go here
                  Container(color: Colors.grey[300], child: Center(child: Text(video['caption']))),
                  // Right side actions
                  Positioned(
                    right: 16,
                    bottom: 100,
                    child: Column(
                      children: [
                        IconButton(icon: const Icon(Icons.favorite, color: Colors.pink), onPressed: (){}),
                        Text("${video['likes']?? 0}"),
                        const SizedBox(height: 20),
                        IconButton(
                          icon: const Icon(Icons.comment, color: Color(0xFF14B8A6)), 
                          onPressed: () => _showCommentSheet(video.id)
                        ),
                        Text("${video['commentCount']?? 0}"),
                        const SizedBox(height: 20),
                        IconButton(icon: const Icon(Icons.share, color: Color(0xFF14B8A6)), onPressed: (){}),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "SEARCH"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "BUCKET LIST"),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "ASK AI"),
        ],
      ),
    );
  }
}

// Animated Comment Sheet
class CommentSheet extends StatefulWidget {
  final String videoId;
  const CommentSheet({super.key, required this.videoId});
  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseService _service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
        ),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(8), child: Text("Comments", style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _service.getComments(widget.videoId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();
                  return ListView(
                    controller: controller,
                    children: snapshot.data!.docs.map((doc) => ListTile(title: Text(doc['text']))).toList(),
                  );
                }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Add a comment...",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF14B8A6)),
                    onPressed: () {
                      _service.addComment(widget.videoId, _controller.text);
                      _controller.clear();
                    },
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
