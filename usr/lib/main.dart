import 'package:flutter/material.dart';

void main() {
  runApp(const SkillSelectorApp());
}

class SkillSelectorApp extends StatelessWidget {
  const SkillSelectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skill Selector',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SkillSelectionScreen(),
      },
    );
  }
}

class SkillSelectionScreen extends StatefulWidget {
  const SkillSelectionScreen({super.key});

  @override
  State<SkillSelectionScreen> createState() => _SkillSelectionScreenState();
}

class _SkillSelectionScreenState extends State<SkillSelectionScreen> {
  String? _selectedSkill;

  final List<Map<String, dynamic>> _skills = [
    {
      'id': 'programming',
      'title': 'Programming',
      'icon': Icons.code,
      'description': 'Master logic, algorithms, and build digital worlds.',
      'color': Colors.blue,
    },
    {
      'id': 'design',
      'title': 'Design',
      'icon': Icons.brush,
      'description': 'Craft beautiful interfaces and engaging user experiences.',
      'color': Colors.pink,
    },
    {
      'id': 'writing',
      'title': 'Writing',
      'icon': Icons.edit_note,
      'description': 'Tell stories, write copy, and communicate effectively.',
      'color': Colors.orange,
    },
    {
      'id': 'marketing',
      'title': 'Marketing',
      'icon': Icons.campaign,
      'description': 'Grow audiences, analyze trends, and drive sales.',
      'color': Colors.green,
    },
  ];

  void _confirmSelection() {
    if (_selectedSkill == null) return;
    
    final skill = _skills.firstWhere((s) => s['id'] == _selectedSkill);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Skill Confirmed'),
        content: Text('You have chosen ${skill['title']} as your starting skill. Good luck on your journey!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Let\\'s Go!'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Skill'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine number of columns based on width
            int crossAxisCount = 1;
            if (constraints.maxWidth > 900) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 2;
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Choose the best skill to start your journey.',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: crossAxisCount == 1 ? 2.5 : 1.2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _skills.length,
                    itemBuilder: (context, index) {
                      final skill = _skills[index];
                      final isSelected = _selectedSkill == skill['id'];
                      
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedSkill = skill['id'];
                          });
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? skill['color'].withOpacity(0.15) 
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected 
                                  ? skill['color'] 
                                  : Theme.of(context).colorScheme.outlineVariant,
                              width: isSelected ? 2.5 : 1.0,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                skill['icon'],
                                size: 48,
                                color: isSelected 
                                    ? skill['color'] 
                                    : Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                skill['title'],
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? skill['color'] : null,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                skill['description'],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: _selectedSkill == null ? null : _confirmSelection,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Confirm Selection',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
