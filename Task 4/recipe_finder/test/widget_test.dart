import 'package:flutter/material.dart';

void main() {
  runApp(const RecipeApp());
}

// ==================================================
// APP
// ==================================================

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Finder',

      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),

      home: const WelcomeScreen(),
    );
  }
}

// ==================================================
// RECIPE DATA
// ==================================================

final List<Map<String, dynamic>> recipes = [
  {
    'title': 'Chicken Biryani',
    'image':
        'https://images.unsplash.com/photo-1563379091339-03246963d96c?w=800',
    'time': '45 minutes',
    'difficulty': 'Medium',
    'ingredients': [
      'Chicken',
      'Rice',
      'Onion',
      'Tomato',
      'Biryani Masala',
    ],
    'steps': [
      'Cook the chicken with spices.',
      'Boil the rice.',
      'Layer the rice and chicken.',
      'Cook everything together.',
    ],
  },
  {
    'title': 'Chicken Karahi',
    'image':
        'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=800',
    'time': '40 minutes',
    'difficulty': 'Medium',
    'ingredients': [
      'Chicken',
      'Tomatoes',
      'Ginger',
      'Garlic',
      'Karahi Masala',
    ],
    'steps': [
      'Cook the chicken in a pan.',
      'Add tomatoes and spices.',
      'Cook until the chicken is tender.',
      'Add ginger and serve.',
    ],
  },
  {
    'title': 'Zinger Burger',
    'image':
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
    'time': '30 minutes',
    'difficulty': 'Easy',
    'ingredients': [
      'Chicken Fillet',
      'Burger Bun',
      'Flour',
      'Mayonnaise',
      'Lettuce',
    ],
    'steps': [
      'Coat the chicken in flour.',
      'Fry the chicken until crispy.',
      'Prepare the burger bun.',
      'Add chicken, sauce, and lettuce.',
    ],
  },
  {
    'title': 'Paratha Roll',
    'image':
        'https://images.unsplash.com/photo-1601050690117-94f5f6fa8bd7?w=800',
    'time': '25 minutes',
    'difficulty': 'Easy',
    'ingredients': [
      'Paratha',
      'Chicken',
      'Onion',
      'Chutney',
      'Sauce',
    ],
    'steps': [
      'Cook the chicken.',
      'Prepare the paratha.',
      'Add chicken and sauces.',
      'Roll the paratha and serve.',
    ],
  },
  {
    'title': 'Cookies',
    'image':
        'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=800',
    'time': '35 minutes',
    'difficulty': 'Easy',
    'ingredients': [
      'Flour',
      'Sugar',
      'Butter',
      'Chocolate Chips',
      'Egg',
    ],
    'steps': [
      'Mix all the ingredients.',
      'Make small cookie shapes.',
      'Place them on a baking tray.',
      'Bake until golden.',
    ],
  },
];

// ==================================================
// WELCOME SCREEN
// ==================================================

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const Icon(
                  Icons.restaurant_menu,
                  size: 100,
                  color: Colors.orange,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Recipe Finder',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Find simple and delicious recipes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 35),

                ElevatedButton.icon(
                  icon: const Icon(Icons.restaurant),

                  label: const Text(
                    'Get Started',
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================================================
// HOME SCREEN
// ==================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Recipes',
        ),

        leading: IconButton(
          icon: const Icon(
            Icons.restaurant_menu,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(10),

          itemCount: recipes.length,

          itemBuilder: (context, index) {
            final recipe = recipes[index];

            return Card(
              margin: const EdgeInsets.only(
                bottom: 15,
              ),

              child: ListTile(
                contentPadding: const EdgeInsets.all(10),

                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),

                  child: Image.network(
                    recipe['image'],

                    width: 90,
                    height: 90,

                    fit: BoxFit.cover,

                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return const SizedBox(
                        width: 90,
                        height: 90,

                        child: Icon(
                          Icons.restaurant,
                          size: 45,
                        ),
                      );
                    },
                  ),
                ),

                title: Text(
                  recipe['title'],

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  '${recipe['time']} • ${recipe['difficulty']}',
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),

                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) {
                        return DetailScreen(
                          recipe: recipe,
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==================================================
// DETAIL SCREEN
// ==================================================

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> recipe;

  const DetailScreen({
    super.key,
    required this.recipe,
  });

  @override
  State<DetailScreen> createState() {
    return _DetailScreenState();
  }
}

// ==================================================
// DETAIL SCREEN STATE
// ==================================================

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe['title'],
        ),

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },

            icon: Icon(
              isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,

              color: isFavorite
                  ? Colors.red
                  : null,
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Image.network(
                recipe['image'],

                width: double.infinity,
                height: 220,

                fit: BoxFit.cover,

                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return const SizedBox(
                    height: 220,

                    child: Center(
                      child: Icon(
                        Icons.restaurant,
                        size: 80,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              Text(
                recipe['title'],

                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(
                    Icons.timer,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    recipe['time'],
                  ),

                  const SizedBox(width: 20),

                  const Icon(
                    Icons.restaurant,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    recipe['difficulty'],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Text(
                'Ingredients',

                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              for (String ingredient in recipe['ingredients'])
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                  ),

                  child: Row(
                    children: [
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),

                      const SizedBox(width: 8),

                      Text(
                        ingredient,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 25),

              const Text(
                'Instructions',

                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              for (
                int i = 0;
                i < recipe['steps'].length;
                i++
              )
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                  ),

                  child: Text(
                    '${i + 1}. ${recipe['steps'][i]}',

                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}