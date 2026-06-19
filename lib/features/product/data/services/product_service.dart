/// [ProductService] acts as a mock data source for products.
/// In a real-world scenario, this would make HTTP calls to a backend API.
class ProductService {
  /// Fetches a list of products from a simulated backend.
  /// Includes a 1-second delay to mimic network latency.
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        "id": "1",
        "name": "Wireless Headphones",
        "price": 99.99,
        "imageUrl": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80",
        "category": "Electronics",
        "rating": 4.5
      },
      {
        "id": "2",
        "name": "Smart Watch Ultra",
        "price": 199.50,
        "imageUrl": "https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500&q=80",
        "category": "Electronics",
        "rating": 4.8
      },
      {
        "id": "3",
        "name": "Performance Running Shoes",
        "price": 129.99,
        "imageUrl": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&q=80",
        "category": "Fashion",
        "rating": 4.2
      },
      {
        "id": "4",
        "name": "Mechanical Keyboard RGB",
        "price": 149.00,
        "imageUrl": "https://images.unsplash.com/photo-1595225476474-87563907a212?w=500&q=80",
        "category": "Electronics",
        "rating": 4.9
      },
      {
        "id": "5",
        "name": "Premium Leather Backpack",
        "price": 89.99,
        "imageUrl": "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500&q=80",
        "category": "Fashion",
        "rating": 4.7
      },
      {
        "id": "6",
        "name": "Bluetooth Portable Speaker",
        "price": 59.99,
        "imageUrl": "https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500&q=80",
        "category": "Electronics",
        "rating": 4.4
      },
      {
        "id": "7",
        "name": "Minimalist Office Desk",
        "price": 249.00,
        "imageUrl": "https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=500&q=80",
        "category": "Home",
        "rating": 4.6
      },
      {
        "id": "8",
        "name": "Ergonomic Gaming Mouse",
        "price": 79.50,
        "imageUrl": "https://images.unsplash.com/photo-1527814050087-dd1e45995221?w=500&q=80",
        "category": "Electronics",
        "rating": 4.3
      },
      {
        "id": "9",
        "name": "Polarized Sunglasses",
        "price": 35.00,
        "imageUrl": "https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=500&q=80",
        "category": "Fashion",
        "rating": 4.1
      },
      {
        "id": "10",
        "name": "Smart Fitness Tracker",
        "price": 49.99,
        "imageUrl": "https://images.unsplash.com/photo-1575311373937-040b8e1fd5b0?w=500&q=80",
        "category": "Electronics",
        "rating": 4.5
      },
      {
        "id": "11",
        "name": "Ceramic Coffee Mug",
        "price": 18.50,
        "imageUrl": "https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=500&q=80",
        "category": "Home",
        "rating": 4.8
      },
      {
        "id": "12",
        "name": "Wireless Charger Pad",
        "price": 29.99,
        "imageUrl": "https://images.unsplash.com/photo-1586816879360-004f5b0c51e3?w=500&q=80",
        "category": "Electronics",
        "rating": 4.2
      }
    ];
  }
}
