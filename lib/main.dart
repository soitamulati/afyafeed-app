import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const AfyafeedApp());
}

class AfyafeedApp extends StatelessWidget {
  const AfyafeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afyafeed',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber), // Yellow theme to match cover
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _playVideo(BuildContext context, String videoId, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => VideoScreen(videoId: videoId, title: title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Afyafeed - Health News')),
      body: ListView(
        children: [
          // 1. TOP COVER PHOTO
          Image.asset(
            'cover.jpg', // <-- your yellow stethoscope
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text("Today's Health Tips", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          
          // 2. VIDEO NEWS CARDS
          _videoCard(context, 'Drink 2L of Water Daily', 'Why hydration matters', 'https://images.unsplash.com/photo-1553456558-aff63285bdd1?w=400', 'kW9S7jO8hY4'),
          _videoCard(context, '5 Foods That Boost Immunity', 'Top immunity foods', 'https://images.unsplash.com/photo-1490818387583-1baba5e638af?w=400', 'VjKfO8o7Q7E'),
          _videoCard(context, 'Exercise 30 Minutes a Day', 'Easy home workout', 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400', 'gC_L9qPHQd8'),
        ],
      ),
    );
  }

  Widget _videoCard(BuildContext context, String title, String subtitle, String imageUrl, String videoId) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () => _playVideo(context, videoId, title),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
                ),
                const Icon(Icons.play_circle_fill, color: Colors.white, size: 60), // Play button
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoScreen extends StatefulWidget {
  final String videoId;
  final String title;
  const VideoScreen({super.key, required this.videoId, required this.title});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(initialVideoId: widget.videoId, flags: const YoutubePlayerFlags(autoPlay: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: YoutubePlayer(controller: _controller, showVideoProgressIndicator: true),
    );
  }
}
