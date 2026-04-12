class ProductService {
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
        "name": "Smart Watch",
        "price": 199.50,
        "imageUrl": "https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500&q=80",
        "category": "Electronics",
        "rating": 4.8
      },
      {
        "id": "3",
        "name": "Running Shoes",
        "price": 59.99,
        "imageUrl": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&q=80",
        "category": "Fashion",
        "rating": 4.2
      }
    ];
  }
}
