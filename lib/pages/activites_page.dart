import 'package:flutter/material.dart';

import 'package:gitcandies/constants/constants.dart';
import 'package:gitcandies/providers/providers.dart';

class ActivitiesPage extends StatelessWidget {
  Widget repoFields(ActivitiesProvider provider) {
    if (!provider.loaded)
      return Center(
        child: LoadingIndicator(),
      );

    return CandiesRefreshList(
      onRefresh: () async {
        await provider.getActivities(refresh: true);
        return provider.loaded;
      },
      content: contentList(provider),
    );
  }

  Widget contentList(ActivitiesProvider provider) {
    final events = provider.activities;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container();
        },
        childCount: events.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivitiesProvider>(
      builder: (context, provider, _) {
        return FutureBuilder(
          future: provider.getActivities(),
          builder: (_, __) => repoFields(provider),
        );
      },
    );
  }
}