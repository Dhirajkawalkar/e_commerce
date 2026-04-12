import '../../domain/entities/product.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import '../../../../core/utils/logger.dart';

class ProductRepository {
  final ProductService service;

  ProductRepository({required this.service});

  Future<List<Product>> getProducts() async {
    try {
      // 1. Service now returns a direct List<Map> like actual Dio/Http payloads
      final rawDataList = await service.fetchProducts();
      
      // 2. Skipping unnecessary jsonDecode overhead
      return rawDataList
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e, stackTrace) {
      // 3. Log the error internally so the developer has immediate visibility
      AppLogger.error('Failed to fetch products', e, stackTrace);
      
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }
}
