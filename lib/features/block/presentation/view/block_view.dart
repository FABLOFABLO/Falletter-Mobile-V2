import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/progress/loading_circular_indicator.dart';
import 'package:falletter_mobile_v2/core/components/state/state_message.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/features/block/presentation/provider/block_provider.dart';
import 'package:falletter_mobile_v2/features/block/presentation/widget/block_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BlockView extends ConsumerStatefulWidget {
  const BlockView({super.key});

  @override
  ConsumerState<BlockView> createState() => _BlockViewState();
}

class _BlockViewState extends ConsumerState<BlockView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(blockListProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final blockedAsync = ref.watch(blockListProvider);

    return Scaffold(
      appBar: CustomAppBar(icon: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('차단한 게시글', style: FalletterTextStyle.title2),
          ),
          SizedBox(height: 24),
          Expanded(
            child: blockedAsync.when(
              loading: () => loadingCircularIndicator(ref),
              error: (_, __) => stateMessage(StateMessages.loadFailed),
              data: (blocked) {
                if (blocked.isEmpty) {
                  return stateMessage('차단한 게시글이 없어요.');
                }
                return ListView.separated(
                  itemCount: blocked.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = blocked[index];
                    return BlockPostCard(
                      title: item.title,
                      content: item.content,
                      nickname: item.anonymousNickname,
                      blockedAt: item.blockedAt,
                      onTap: () {
                        context.push('${RoutePaths.block}/detail', extra: item);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 8);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
