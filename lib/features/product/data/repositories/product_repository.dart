/// Repository class responsible for handling product-related data operations.
/// 
/// This class acts as an abstraction layer between the UI/Bloc and the 
/// data sources (ProductService). It converts raw data models into 
/// domain entities and handles error logging.
import '../../domain/entities/product.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import '../../../../core/utils/logger.dart';

class ProductRepository {
  final ProductService service;

  ProductRepository({required this.service});

  /// Fetches the list of products from the remote service.
  /// 
  /// Returns a list of [Product] entities.
  /// Throws an [Exception] if the fetch operation fails.
  Future<List<Product>> getProducts() async {
    try {
      // 1. Service now returns a direct List<Map> like actual Dio/Http payloads
      final rawDataList = await service.fetchProducts();
      
      // 2. Skipping unnecessary jsonDecode overhead and mapping to ProductModel
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
