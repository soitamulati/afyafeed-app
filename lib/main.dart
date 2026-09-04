import 'package:flutter/material.dart';

void main() => runApp(const AfyafeedApp());

class AfyafeedApp extends StatelessWidget {
  const AfyafeedApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0E4F5C),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const MainNav(),
    );
  }
}

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _index = 0;
  final _pages = const [HomeFeed(), SearchScreen(), BucketListScreen(), AskAIScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0E4F5C),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'BUCKET LIST'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'ASK AI'),
        ],
      ),
    );
  }
}

// 1. HOME - Vertical video feed
class HomeFeed extends StatelessWidget {
  const HomeFeed({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HealthSocial', style: TextStyle(color: Color(0xFF0E4F5C), fontWeight: FontWeight.bold)), actions: [
        IconButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=> const PersonalProfile())), icon: const Icon(Icons.account_circle, color: Color(0xFF0E4F5C))),
      ]),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, i) {
          return Stack(
            children: [
              Container(margin: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFB8D4E3), borderRadius: BorderRadius.circular(20))),
              const Positioned(left: 20, bottom: 80, child: Text('Video Caption:\n"Daily physio routine tips #health"', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              Positioned(right: 20, top: 150, child: Column(children: [
                _sideIcon(Icons.favorite, '1.2k', Colors.pink),
                _sideIcon(Icons.chat_bubble, '84', const Color(0xFF0E4F5C)),
                _sideIcon(Icons.send, '22', const Color(0xFF0E4F5C)),
              ])),
              const Center(child: Icon(Icons.play_circle_fill, size: 60, color: Color(0xFF0E4F5C))),
            ],
          );
        },
      ),
    );
  }
  Widget _sideIcon(IconData icon, String label, Color color) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Column(children: [Icon(icon, color: color, size: 30), Text('$label', style: const TextStyle(fontSize: 12))]));
  }
}

// 2. BUCKET LIST
class BucketListScreen extends StatelessWidget {
  const BucketListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BUCKET LIST'), centerTitle: true),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: 'Search hospitals...', filled: true, fillColor: const Color(0xFFE8F4F8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
        const SizedBox(height: 16),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFE8F4F8), borderRadius: BorderRadius.circular(12)), child: ListTile(leading: const Icon(Icons.local_hospital, color: Color(0xFF0E4F5C)), title: const Text('General City Hospital'), subtitle: const Text('4.7 ★★★★★'), trailing: const Icon(Icons.arrow_forward_ios, size: 16))),
        const SizedBox(height: 16),
        const Text('Hospital Details', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Open • 24/7 • Cardiology, Pediatrics, Surgery', style: TextStyle(fontSize: 12)),
        const SizedBox(height: 12),
        Wrap(spacing: 8, children: ['Consultation','Imaging','Pharmacy'].map((e)=>Chip(label: Text(e), backgroundColor: const Color(0xFFB8E6E0))).toList()),
        const SizedBox(height: 12),
        const Text('Hospital Videos:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(children: List.generate(3, (i)=>Expanded(child: Container(margin: const EdgeInsets.only(right: 8), height: 60, decoration: BoxDecoration(color: const Color(0xFF7A8A99), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.play_arrow, color: Colors.white))))),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0E8A7B), minimumSize: const Size(double.infinity, 48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))), child: const Text('Book a Consultant')),
      ]),
    );
  }
}

// 3. SEARCH
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: '', filled: true, fillColor: const Color(0xFFE8F4F8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)))),
      body: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Popular Videos', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.1, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: 6, itemBuilder: (c,i)=>Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Container(decoration: BoxDecoration(color: const Color(0xFF7A8A99), borderRadius: BorderRadius.circular(8)), child: const Center(child: Icon(Icons.play_arrow, color: Colors.white)))), const SizedBox(height: 4), Text(['Recovery tips • 13k views','Nutrition for healing • 3.1k views','Mental health talk • 5.6k views','Physio exercises • 9.3k views'][i%4], style: const TextStyle(fontSize: 10))]))),
      ])),
    );
  }
}

// 4. PERSONAL PROFILE
class PersonalProfile extends StatelessWidget {
  const PersonalProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), actions: const [Icon(Icons.settings)]),
      body: Column(children: [
        const SizedBox(height: 12),
        const CircleAvatar(radius: 30, backgroundColor: Colors.grey),
        const SizedBox(height: 8),
        const Text('Dr. Alex Morgan', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Verified Doctor • License #MD-84729', style: TextStyle(fontSize: 10, color: Colors.teal)),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [Text('Likes\n1.4k', textAlign: TextAlign.center), Text('Following\n210', textAlign: TextAlign.center), Text('Followers\n1.1k', textAlign: TextAlign.center)]),
        const SizedBox(height: 12),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text('POSTS', style: TextStyle(color: Colors.teal)), Text('SAVED'), Text('LIKED')]),
        Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4), itemCount: 9, itemBuilder: (_,i)=>Container(color: const Color(0xFF7A8A99), child: const Icon(Icons.play_arrow, color: Colors.white)))),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: (){}, backgroundColor: const Color(0xFF0E8A7B), child: const Icon(Icons.add)),
    );
  }
}

// 5. OTHER PERSON'S PROFILE
class OtherProfile extends StatelessWidget {
  const OtherProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Column(children: [
        const CircleAvatar(radius: 30),
        const Text('Nurse Jordan Lee', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Registered Nurse • 5 yrs experience', style: TextStyle(fontSize: 10)),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(onPressed: (){}, child: const Text('Follow')),
          ElevatedButton(onPressed: (){}, child: const Text('Message')),
        ]),
        Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4), itemCount: 9, itemBuilder: (_,i)=>Container(color: const Color(0xFF7A8A99), child: const Icon(Icons.play_arrow, color: Colors.white)))),
      ]),
    );
  }
}

// 6. ASK AI
class AskAIScreen extends StatelessWidget {
  const AskAIScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ASK AI')),
      body: Column(children: [
        const SizedBox(height: 20),
        const Icon(Icons.support, size: 80, color: Color(0xFF0E8A7B)),
        const Text('ASK AI', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0E4F5C))),
        const Text('AI — Health Assistant', style: TextStyle(color: Colors.teal)),
        const SizedBox(height: 20),
        Container(margin: const EdgeInsets.all(12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(12)), child: const Text("Hi! I'm your AI health assistant. How can I help today?")),
        Align(alignment: Alignment.centerRight, child: Container(margin: const EdgeInsets.all(12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF0E8A7B), borderRadius: BorderRadius.circular(12)), child: const Text('What should I consider before a knee consultation?', style: TextStyle(color: Colors.white)))),
        const Spacer(),
        Padding(padding: const EdgeInsets.all(12), child: TextField(decoration: InputDecoration(hintText: 'Ask about symptoms, hospitals, care...', suffixIcon: const Icon(Icons.send), border: OutlineInputBorder(borderRadius: BorderRadius.circular(24))))),
        Padding(padding: const EdgeInsets.only(bottom: 12), child: Wrap(spacing: 8, children: [Chip(label: const Text('Find hospitals near me')), Chip(label: const Text('Symptoms')), Chip(label: const Text('checker'))])),
      ]),
    );
  }
}
