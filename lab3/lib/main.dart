import 'dart:async';
import 'dart:convert';

// ============================================================================
// EXERCISE 1 – Product Model & Repository
// Goal: Understand Futures and Streams
// ============================================================================

/// Product data model with id, name, and price
class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  @override
  String toString() => 'Product(id: $id, name: $name, price: \$$price)';
}

/// Repository that provides both Future-based and Stream-based access to products
class ProductRepository {
  // In-memory product list
  final List<Product> _products = [
    Product(id: 1, name: 'Laptop', price: 999.99),
    Product(id: 2, name: 'Mouse', price: 25.50),
    Product(id: 3, name: 'Keyboard', price: 75.00),
  ];

  // Broadcast stream controller to emit newly added products in real-time
  final StreamController<Product> _addedController =
  StreamController<Product>.broadcast();

  /// Simulates async fetch of all products (Future-based)
  Future<List<Product>> getAll() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));
    return _products;
  }

  /// Returns a stream that emits products as they are added
  Stream<Product> liveAdded() => _addedController.stream;

  /// Adds a product and notifies listeners via stream
  void addProduct(Product product) {
    _products.add(product);
    _addedController.add(product); // Emit to stream
  }

  /// Clean up resources
  void dispose() {
    _addedController.close();
  }
}

// ============================================================================
// EXERCISE 2 – User Repository with JSON
// Goal: Practice JSON serialization / deserialization
// ============================================================================

/// User model with name and email
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  /// Factory constructor to create User from JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  @override
  String toString() => 'User(name: $name, email: $email)';
}

/// Repository that simulates fetching users from an API
class UserRepository {
  /// Simulates API call returning JSON data, then parses it into User objects
  Future<List<User>> fetchUsers() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 800));

    // Simulated JSON response from API
    String jsonResponse = '''
    [
      {"name": "Alice Johnson", "email": "alice@example.com"},
      {"name": "Bob Smith", "email": "bob@example.com"},
      {"name": "Charlie Brown", "email": "charlie@example.com"}
    ]
    ''';

    // Parse JSON string to List
    List<dynamic> jsonList = jsonDecode(jsonResponse);

    // Convert each JSON object to User instance
    return jsonList.map((json) => User.fromJson(json)).toList();
  }
}

// ============================================================================
// EXERCISE 3 – Async + Microtask Debugging
// Goal: Differentiate microtask and event queues
// ============================================================================

void demonstrateEventLoop() {
  print('\n--- Event Loop Demonstration ---');

  // 1. Synchronous code executes first
  print('1. Synchronous start');

  // 2. Schedule a microtask (runs before event queue)
  scheduleMicrotask(() {
    print('3. Microtask executed');
  });

  // 3. Schedule an event (runs after all microtasks)
  Future(() {
    print('5. Event queue (Future) executed');
  });

  // 4. Schedule another microtask
  scheduleMicrotask(() {
    print('4. Another microtask executed');
  });

  // 5. More synchronous code
  print('2. Synchronous end');

  // EXPLANATION:
  // Execution order: Synchronous code → Microtask queue → Event queue
  // Expected output order: 1 → 2 → 3 → 4 → 5
}

// ============================================================================
// EXERCISE 4 – Stream Transformation
// Goal: Use functional stream operators
// ============================================================================

Future<void> demonstrateStreamTransformation() async {
  print('\n--- Stream Transformation ---');

  // Create a stream of numbers 1 to 5
  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  // Transform: square each number, then filter to keep only even results
  Stream<int> transformedStream = numberStream
      .map((n) => n * n) // Square each number: 1, 4, 9, 16, 25
      .where((n) => n.isEven); // Keep only even: 4, 16

  // Listen to the transformed stream and print each value
  print('Squared even numbers:');
  await for (var value in transformedStream) {
    print('  $value');
  }
}

// ============================================================================
// EXERCISE 5 – Factory Constructors & Cache
// Goal: Show how factory constructors implement caching (Singleton pattern)
// ============================================================================

/// Settings class implementing singleton pattern
class Settings {
  // Private static instance (the single cached instance)
  static Settings? _instance;

  // Private constructor prevents external instantiation
  Settings._internal();

  // Factory constructor returns the same instance every time
  factory Settings() {
    _instance ??= Settings._internal(); // Create only if null
    return _instance!;
  }

  // Example setting
  String theme = 'light';
}

// ============================================================================
// MAIN FUNCTION – Runs all exercises
// ============================================================================

void main() async {
  print('╔════════════════════════════════════════════════════════════╗');
  print('║  LAB 3 – ADVANCED DART PRACTICE EXERCISES                  ║');
  print('╚════════════════════════════════════════════════════════════╝\n');

  // -------------------------------------------------------------------------
  // EXERCISE 1: Product Model & Repository
  // -------------------------------------------------------------------------
  print('═══ EXERCISE 1: Product Model & Repository ═══');

  ProductRepository productRepo = ProductRepository();

  // Subscribe to live product additions
  productRepo.liveAdded().listen((product) {
    print('New product added via stream: $product');
  });

  // Fetch all products using Future
  print('Fetching all products...');
  List<Product> products = await productRepo.getAll();
  print('Products retrieved:');
  products.forEach(print);

  // Add new product and observe stream emission
  print('\nAdding new product...');
  productRepo.addProduct(Product(id: 4, name: 'Monitor', price: 299.99));

  // Small delay to see stream output
  await Future.delayed(Duration(milliseconds: 100));
  productRepo.dispose();

  // -------------------------------------------------------------------------
  // EXERCISE 2: User Repository with JSON
  // -------------------------------------------------------------------------
  print('\n═══ EXERCISE 2: User Repository with JSON ═══');

  UserRepository userRepo = UserRepository();
  print('Fetching users from API...');
  List<User> users = await userRepo.fetchUsers();
  print('Users retrieved:');
  users.forEach(print);

  // -------------------------------------------------------------------------
  // EXERCISE 3: Async + Microtask Debugging
  // -------------------------------------------------------------------------
  demonstrateEventLoop();

  // Wait for microtasks and futures to complete
  await Future.delayed(Duration(milliseconds: 100));

  // -------------------------------------------------------------------------
  // EXERCISE 4: Stream Transformation
  // -------------------------------------------------------------------------
  await demonstrateStreamTransformation();

  // -------------------------------------------------------------------------
  // EXERCISE 5: Factory Constructors & Cache
  // -------------------------------------------------------------------------
  print('\n═══ EXERCISE 5: Factory Constructors & Cache ═══');

  // Create two "different" Settings instances
  Settings settings1 = Settings();
  Settings settings2 = Settings();

  // Modify one instance
  settings1.theme = 'dark';

  // Verify they're the same object (singleton)
  print('settings1.theme: ${settings1.theme}');
  print('settings2.theme: ${settings2.theme}');
  print('Are they identical? ${identical(settings1, settings2)}');
  print('Singleton confirmed: both references point to the same instance ✓');

  // -------------------------------------------------------------------------
  print('\n╔════════════════════════════════════════════════════════════╗');
  print('  ║  ALL EXERCISES COMPLETED SUCCESSFULLY                      ║');
  print('  ╚════════════════════════════════════════════════════════════╝');
}