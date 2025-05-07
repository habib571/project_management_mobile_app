import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_listtile.dart';

import '../../../../../application/constants/constants.dart';
import '../../../../../application/dependencyInjection/dependency_injection.dart';
import '../../../../../domain/models/user.dart';
import '../../../../sharedwidgets/image_widget.dart';
import '../../../../stateRender/state_render_impl.dart';
import '../../viewmodel/search_member_view_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchViewModel _viewModel = instance<SearchViewModel>();
  final void Function(User member)? afterSelectingUser;
  CustomSearchDelegate({required this.afterSelectingUser});

  @override
  String? get searchFieldLabel => "Find Member";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          _viewModel.memberToAdd.clear();
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text("Type to search members..."),
      );
    }

    // call the addMember function each time the query changes
    _viewModel.getMemberByName(query, page: 0);
    _viewModel.hasMore = true;
    return _buildResultList();
  }

  Widget _buildResultList() {
    return ValueListenableBuilder<FlowState>(
      valueListenable: _viewModel.stateNotifier,
      builder: (context, state, child) {
        if (state is LoadingState && _viewModel.memberToAdd.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorState) {
          return Center(child: Text(state.message));
        } else if (state is ContentState) {
          final members = _viewModel.memberToAdd;
          if (members.isEmpty) {
            return const Center(child: Text("No members found"));
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent &&
                  !_viewModel.isLoadingMore) {
                // Fetch next page.
                _viewModel.getMemberByName(query, page: _viewModel.currentPage);
              }
              return false;
            },
            child: ListView.builder(
              itemCount: members.length + 1,
              itemBuilder: (context, index) {
                if (index == members.length) {
                  return _viewModel.isLoadingMore
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink();
                }
                final member = members[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: CustomListTile(
                    leading: ImagePlaceHolder(
                      imgBorder: true,
                      radius: 25,
                      imageUrl: "${Constants.baseUrl}/images/${member.imageUrl}" ,
                      fullName: member.fullName,
                    ),
                    title: Text(member.fullName),
                    subtitle: Text(member.email),
                    onTap: () {
                      afterSelectingUser!(member);
                    },
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
