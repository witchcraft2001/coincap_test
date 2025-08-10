part of 'asset_list_bloc.dart';

class AssetListState extends Equatable {
  final List<AssetItemViewState> items;
  final bool hasMore;
  final bool isLoadingMore;
  final int nextOffset;
  final String error;

  const AssetListState({
    this.items = const [],
    this.hasMore = true,
    this.isLoadingMore = false,
    this.nextOffset = 0,
    this.error = '',
  });

  @override
  List<Object?> get props => [items, hasMore, isLoadingMore, nextOffset];

  AssetListState copyWith({
    List<AssetItemViewState>? items,
    bool? hasMore,
    bool? isLoadingMore,
    int? nextOffset,
    String? error,
  }) {
    return AssetListState(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      nextOffset: nextOffset ?? this.nextOffset,
      error: error ?? this.error,
    );
  }
}
