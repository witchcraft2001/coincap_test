import 'package:coincap_testapp/features/asset_list/presentation/bloc/asset_item_view_state.dart';
import 'package:coincap_testapp/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/asset_list_bloc.dart';

class AssetListPage extends StatelessWidget {
  const AssetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AssetListBloc>()..add(AssetListStarted()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: _AssetListPageInternal()),
      ),
    );
  }
}

class _AssetListPageInternal extends StatefulWidget {
  const _AssetListPageInternal();

  @override
  State<_AssetListPageInternal> createState() => _AssetListPageInternalState();
}

class _AssetListPageInternalState extends State<_AssetListPageInternal> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    final offset = _scrollController.offset;
    if (offset >= max - 200) {
      context.read<AssetListBloc>().add(AssetListLoadMore());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 17,
      height: 24 / 17,
      color: Color(0xFF17171A)
    );

    return RefreshIndicator(
      onRefresh: () async => context.read<AssetListBloc>().add(AssetListRefresh()),
      child: BlocBuilder<AssetListBloc, AssetListState>(
        builder: (context, state) {
          if (state.isLoadingMore && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error.isNotEmpty) {
            return Center(
              child: Text(state.error, style: TextStyle(color: Colors.red)),
            );
          }

          return _AssetList(
            scrollController: _scrollController,
            items: state.items,
            textStyle: textStyle,
            isLoadingMore: state.isLoadingMore,
          );
        },
      ),
    );
  }
}

class _AssetList extends StatelessWidget {
  final ScrollController scrollController;
  final List<AssetItemViewState> items;
  final bool isLoadingMore;
  final TextStyle textStyle;

  const _AssetList({
    required this.scrollController,
    required this.items,
    required this.isLoadingMore,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList.builder(
          itemCount: items.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= items.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final asset = items[index];
            return _AssetRow(key: ValueKey(index), index: index, asset: asset, textStyle: textStyle);
          },
        ),
      ],
    );
  }
}

class _AssetRow extends StatelessWidget {
  final int index;
  final AssetItemViewState asset;
  final TextStyle textStyle;

  const _AssetRow({super.key, required this.index, required this.asset, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: Color(asset.color), borderRadius: BorderRadius.circular(18)),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(asset.symbol, style: textStyle)),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(asset.price, textAlign: TextAlign.right, style: textStyle),
          ),
        ],
      ),
    );
  }
}
