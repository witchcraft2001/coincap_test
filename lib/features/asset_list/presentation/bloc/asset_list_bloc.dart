import 'package:coincap_testapp/domain/usecases/get_assets_page_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../mappers/asset_mapper.dart';
import 'asset_item_view_state.dart';

part 'asset_list_event.dart';

part 'asset_list_state.dart';

@injectable
class AssetListBloc extends Bloc<AssetListEvent, AssetListState> {
  static const _pageSize = 15;
  final GetAssetsPageUseCase _getAssetsPageUseCase;
  final AssetMapper _assetMapper;

  AssetListBloc(this._getAssetsPageUseCase, this._assetMapper) : super(const AssetListState()) {
    on<AssetListStarted>(_onStart);
    on<AssetListLoadMore>(_onLoadMore);
    on<AssetListRefresh>(_onRefresh);
  }

  Future<void> _onStart(AssetListStarted event, Emitter<AssetListState> emit) async {
    emit(state.copyWith(isLoadingMore: true, items: [], nextOffset: 0, hasMore: true));
    try {
      final items = await _getAssetsPageUseCase(limit: _pageSize, offset: 0);
      emit(
        state.copyWith(
          isLoadingMore: false,
          items: items.map((e) => _assetMapper.toViewState(e)).toList(growable: false),
          nextOffset: items.length,
          hasMore: items.length == _pageSize,
        ),
      );
    } catch (_) {
      emit(state.copyWith(error: 'Failed to load assets', isLoadingMore: false));
    }
  }

  Future<void> _onLoadMore(AssetListLoadMore event, Emitter<AssetListState> emit) async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    try {
      final more = await _getAssetsPageUseCase(limit: _pageSize, offset: state.nextOffset);
      emit(
        state.copyWith(
          items: [...state.items, ...more.map((e) => _assetMapper.toViewState(e))],
          nextOffset: state.nextOffset + more.length,
          hasMore: more.length == _pageSize,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _onRefresh(AssetListRefresh event, Emitter<AssetListState> emit) async {
    add(AssetListStarted());
  }
}
