part of 'asset_list_bloc.dart';

sealed class AssetListEvent {
  const AssetListEvent();
}

class AssetListStarted extends AssetListEvent {}
class AssetListLoadMore extends AssetListEvent {}
class AssetListRefresh extends AssetListEvent {}
