import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';

import 'package:reown_appkit/modal/models/grid_item.dart';
import 'package:reown_appkit/modal/services/explorer_service/explorer_service_singleton.dart';
import 'package:reown_appkit/modal/services/network_service/i_network_service.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';

class NetworkService implements INetworkService {
  @override
  ValueNotifier<bool> initialized = ValueNotifier<bool>(false);

  List<GridItem<AppKitModalNetworkInfo>> itemListComplete = [];

  @override
  ValueNotifier<List<GridItem<AppKitModalNetworkInfo>>> itemList =
      ValueNotifier<List<GridItem<AppKitModalNetworkInfo>>>([]);

  String _getImageUrl(AppKitModalNetworkInfo chainInfo) {
    if (chainInfo.chainIcon != null && chainInfo.chainIcon!.contains('http')) {
      return chainInfo.chainIcon!;
    }
    final imageId = AppKitModalNetworks.getNetworkIconId(chainInfo.chainId);
    return explorerService.instance.getAssetImageUrl(imageId);
  }

  @override
  Future<void> init() async {
    if (initialized.value) {
      return;
    }

    final networks = AppKitModalNetworks.getNetworks(
      CoreConstants.namespace,
    );
    for (var chain in networks) {
      final imageUrl = _getImageUrl(chain);
      itemListComplete.add(
        GridItem<AppKitModalNetworkInfo>(
          image: imageUrl,
          id: chain.chainId,
          title: RenderUtils.shorten(chain.name),
          data: chain,
        ),
      );
    }

    itemList.value = itemListComplete;

    initialized.value = true;
  }

  @override
  void filterList({String? query}) {
    if (query == null || query.isEmpty) {
      itemList.value = itemListComplete;
      return;
    }

    itemList.value = itemListComplete
        .where(
          (element) => element.title.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }
}
