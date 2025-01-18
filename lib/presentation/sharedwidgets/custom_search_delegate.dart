

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/modules/addmember/view/screens/add_member_screen.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_listtile.dart';
import 'package:provider/provider.dart';

import '../../application/constants/constants.dart';
import '../../domain/models/user.dart';
import '../modules/dashboord/viewmodel/project_detail_view_model.dart';
import '../stateRender/state_render_impl.dart';
import 'image_widget.dart';
import 'input_text.dart';


class CustomSearchDelegate extends SearchDelegate {
  final ProjectDetailViewModel viewModel;

  CustomSearchDelegate(this.viewModel);


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          viewModel.memberToAdd.clear();
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

    // Call the addMember function each time the query changes
    viewModel.getMemberByName(query, page: 0);
    viewModel.hasMore = true;
    return _buildResultList();
  }

  Widget _buildResultList() {
    return ValueListenableBuilder<FlowState>(
      valueListenable: viewModel.stateNotifier,
      builder: (context, state, child) {
        if (state is LoadingState && viewModel.memberToAdd.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorState) {
          return Center(child: Text(state.message));
        } else if (state is ContentState) {
          final members = viewModel.memberToAdd;
          if (members.isEmpty) {
            return const Center(child: Text("No members found"));
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent &&
                  !viewModel.isLoadingMore) {
                // Fetch next page.
                viewModel.getMemberByName(query, page: viewModel.currentPage);
              }
              return false;
            },
            child: ListView.builder(
              itemCount: members.length + 1,
              itemBuilder: (context, index) {
                if (index == members.length) {
                  return viewModel.hasMore
                      ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ) : const SizedBox.shrink();
                }

                final member = members[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: CustomListTile(
                    leading: ImagePlaceHolder(
                      radius: 25, imageUrl: member.imageUrl,),
                    title: member.fullName,
                    subtitle: member.email,
                    onTap: () {
                      Get.to(AddMemberScreen(user: member));
                      //close(context, member);
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