/// Events for the Home Bloc.
/// 
/// These classes represent user interactions on the Home screen, such as
/// loading data, switching categories, or searching for products.
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered to load all necessary data for the Home screen.
class LoadHomeData extends HomeEvent {}

/// Event triggered when the user selects a different product category.
class ChangeCategory extends HomeEvent {
  /// The name of the selected category.
  final String category;
  
  const ChangeCategory(this.category);

  @override
  List<Object?> get props => [category];
}

/// Event triggered when the user types in the search bar.
class SearchProducts extends HomeEvent {
  /// The search query entered by the user.
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}
