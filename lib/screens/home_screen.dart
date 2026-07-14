import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'todo_screen.dart';
import 'note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [TodoScreen(), NoteScreen()];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? '📝 Todo List' : '🗒️ Catatan'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDark ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.checklist_rounded),
            label: 'Todo',
          ),
          NavigationDestination(
            icon: Icon(Icons.sticky_note_2_rounded),
            label: 'Catatan',
          ),
        ],
      ),
    );
  }
}
