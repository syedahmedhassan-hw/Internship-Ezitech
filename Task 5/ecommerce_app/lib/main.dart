import 'package:flutter/material.dart';

void main() {
  runApp(const EcommerceApp());
}

// ============================================================
// APP START
// ============================================================

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ahmed Store',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF111827),
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(0xFFF8F9FB),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F9FB),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),

      home: const SplashScreen(),
    );
  }
}

// ============================================================
// PRODUCT MODEL
// ============================================================

class Product {
  final String name;
  final String category;
  final String image;
  final double price;
  final String description;

  Product({
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.description,
  });
}

// ============================================================
// MIXED PRODUCT DATA
// ============================================================

final List<Product> products = [
  Product(
    name: 'Notebook',
    category: 'Stationery',
    image:
        'https://images.unsplash.com/photo-1531346878377-a5be20888e57?w=800',
    price: 5.99,
    description:
        'A simple and useful notebook for school, university, office work, and daily notes.',
  ),

  Product(
    name: 'Running Shoes',
    category: 'Sports',
    image:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
    price: 89.99,
    description:
        'Comfortable running shoes suitable for exercise, jogging, and everyday activities.',
  ),

  Product(
    name: 'Wireless Headphones',
    category: 'Electronics',
    image:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800',
    price: 59.99,
    description:
        'Wireless headphones with a comfortable design for music, videos, and everyday use.',
  ),

  Product(
    name: 'Football',
    category: 'Sports',
    image:
        'https://images.unsplash.com/photo-1614632537190-23e414706f2c?w=800',
    price: 24.99,
    description:
        'A quality football for practice, training, and casual games with friends.',
  ),

  Product(
    name: 'Classic Backpack',
    category: 'Bags',
    image:
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800',
    price: 49.99,
    description:
        'A practical backpack for school, university, travel, and everyday carrying.',
  ),

  Product(
    name: 'Smart Watch',
    category: 'Electronics',
    image:
        'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=800',
    price: 129.99,
    description:
        'A modern smartwatch with a stylish design for everyday use.',
  ),

  Product(
    name: 'Hoodie',
    category: 'Clothing',
    image:
        'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=800',
    price: 39.99,
    description:
        'A comfortable hoodie suitable for casual outfits and everyday wear.',
  ),

  Product(
    name: 'Sunglasses',
    category: 'Accessories',
    image:
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800',
    price: 29.99,
    description:
        'Stylish sunglasses that can complete your everyday look.',
  ),

  Product(
    name: 'Pen Set',
    category: 'Stationery',
    image:
        'https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=800',
    price: 8.99,
    description:
        'A useful set of pens for writing, studying, and office work.',
  ),

  Product(
    name: 'Basketball',
    category: 'Sports',
    image:
        'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800',
    price: 29.99,
    description:
        'A basketball suitable for training and playing with friends.',
  ),
];

// ============================================================
// SCREEN 1: SPLASH SCREEN
// ============================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              width: 90,
              height: 90,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),

              child: const Icon(
                Icons.storefront_outlined,
                size: 50,
                color: Color(0xFF111827),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'AHMED STORE',

              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Everything you need in one place',

              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 50),

            const SizedBox(
              width: 25,
              height: 25,

              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Loading...',

              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SCREEN 2: ONBOARDING SCREEN
// ============================================================

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [
              const SizedBox(height: 30),

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),

                  child: Image.network(
                    'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=1000',

                    width: double.infinity,

                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Welcome to Ahmed Store',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Shop stationery, sports products, electronics, clothing, bags, and more in one simple store.',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF111827),
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  child: const Text(
                    'Get Started',

                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SCREEN 3: HOME / PRODUCT CATALOG
// ============================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  String searchText = '';

  final List<String> categories = [
    'All',
    'Stationery',
    'Sports',
    'Electronics',
    'Clothing',
    'Bags',
    'Accessories',
  ];

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = products.where((product) {
      final matchesCategory = selectedCategory == 'All' ||
          product.category == selectedCategory;

      final matchesSearch = product.name
          .toLowerCase()
          .contains(searchText.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AHMED STORE',

          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },

            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },

            icon: const Icon(
              Icons.person_outline,
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },

              decoration: InputDecoration(
                hintText: 'Search products...',

                prefixIcon: const Icon(
                  Icons.search,
                ),

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),

                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 45,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,

              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              itemCount: categories.length,

              itemBuilder: (context, index) {
                final category = categories[index];

                return Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),

                  child: ChoiceChip(
                    label: Text(category),

                    selected: selectedCategory == category,

                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },

                    selectedColor: const Color(
                      0xFF111827,
                    ),

                    labelStyle: TextStyle(
                      color: selectedCategory == category
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      'No products found',
                    ),
                  )
                : GridView.count(
                    crossAxisCount: 2,

                    crossAxisSpacing: 12,

                    mainAxisSpacing: 12,

                    padding: const EdgeInsets.all(16),

                    childAspectRatio: 0.68,

                    children: filteredProducts.map((product) {
                      return ProductCard(
                        product: product,

                        onTap: () {
                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailScreen(
                                  product: product,
                                );
                              },
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PRODUCT CARD
// ============================================================

class ProductCard extends StatelessWidget {
  final Product product;

  final VoidCallback onTap;

  const ProductCard({
    super.key,

    required this.product,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Card(
        elevation: 3,

        color: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),

        child: Padding(
          padding: const EdgeInsets.all(10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: Hero(
                  tag: product.name,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),

                    child: Image.network(
                      product.image,

                      width: double.infinity,

                      fit: BoxFit.cover,

                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                product.name,

                maxLines: 1,

                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,

                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                product.category,

                style: const TextStyle(
                  color: Colors.grey,

                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',

                    style: const TextStyle(
                      fontSize: 16,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF111827),

                      shape: BoxShape.circle,
                    ),

                    child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} added to cart',
                            ),
                          ),
                        );
                      },

                      icon: const Icon(
                        Icons.add,

                        color: Colors.white,

                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SCREEN 4: PRODUCT DETAIL
// ============================================================

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,

    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState
    extends State<ProductDetailScreen> {
  String selectedSize = 'M';

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
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
                  : Colors.black,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Hero(
              tag: widget.product.name,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: Image.network(
                  widget.product.image,

                  width: double.infinity,

                  height: 320,

                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              widget.product.name,

              style: const TextStyle(
                fontSize: 28,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              '\$${widget.product.price.toStringAsFixed(2)}',

              style: const TextStyle(
                fontSize: 24,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Description',

              style: TextStyle(
                fontSize: 20,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.product.description,

              style: const TextStyle(
                fontSize: 15,

                color: Colors.grey,

                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Select Size',

              style: TextStyle(
                fontSize: 20,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,

              children: [
                'S',
                'M',
                'L',
                'XL',
              ].map((size) {
                return ChoiceChip(
                  label: Text(size),

                  selected: selectedSize == size,

                  onSelected: (selected) {
                    setState(() {
                      selectedSize = size;
                    });
                  },

                  selectedColor: const Color(
                    0xFF111827,
                  ),

                  labelStyle: TextStyle(
                    color: selectedSize == size
                        ? Colors.white
                        : Colors.black,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Added to cart',
                          ),
                        ),
                      );
                    },

                    style: OutlinedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),

                    child: const Text(
                      'Add to Cart',
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Purchase started',
                          ),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF111827),

                      foregroundColor: Colors.white,

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                    ),

                    child: const Text(
                      'Buy Now',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SCREEN 5: CART
// ============================================================

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),

        itemCount: 3,

        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            margin: const EdgeInsets.only(
              bottom: 12,
            ),

            child: ListTile(
              contentPadding:
                  const EdgeInsets.all(10),

              leading: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10),

                child: Image.network(
                  product.image,

                  width: 65,

                  height: 65,

                  fit: BoxFit.cover,
                ),
              ),

              title: Text(
                product.name,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                '\$${product.price.toStringAsFixed(2)}',
              ),

              trailing: IconButton(
                onPressed: () {},

                icon: const Icon(
                  Icons.delete_outline,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// PROFILE SCREEN
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,

              child: Icon(
                Icons.person,

                size: 50,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Ahmed',

              style: TextStyle(
                fontSize: 24,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Welcome to Ahmed Store',

              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            const ListTile(
              leading: Icon(
                Icons.settings_outlined,
              ),

              title: Text(
                'Settings',
              ),

              trailing: Icon(
                Icons.arrow_forward_ios,
              ),
            ),

            const ListTile(
              leading: Icon(
                Icons.favorite_border,
              ),

              title: Text(
                'My Favorites',
              ),

              trailing: Icon(
                Icons.arrow_forward_ios,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton(
                onPressed: () {},

                child: const Text(
                  'Logout',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}