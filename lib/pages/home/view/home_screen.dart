import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger_beauty/logger_beauty.dart';
import 'package:tienphatcpn_interview/authentication/bloc/authentication_bloc.dart';
import 'package:tienphatcpn_interview/components/lv_loading.dart';
import 'package:tienphatcpn_interview/components/lv_post.dart';
import 'package:tienphatcpn_interview/constants/lv_app_enums.dart';
import 'package:tienphatcpn_interview/extensions/number_extension.dart';
import 'package:tienphatcpn_interview/pages/home/bloc/home_bloc.dart';
import 'package:tienphatcpn_interview/pages/home/model/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _dropdownMenu(List<Post> data) => DropdownMenu<SortCardItemType>(
        controller: _dropdownController,
        label: const Text('Sort by'),
        onSelected: (SortCardItemType? label) {
          if (label != null) {
            context.read<HomeBloc>().add(SortListEvent(data, label));
          }
        },
        dropdownMenuEntries:
            SortCardItemType.values.map<DropdownMenuEntry<SortCardItemType>>(
          (SortCardItemType item) {
            return DropdownMenuEntry<SortCardItemType>(
              value: item,
              label: item.label,
            );
          },
        ).toList(),
      );

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _dropdownController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(FetchDataEvent());
    logDebug(context.read<AuthenticationBloc>().uavt);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: context.read<AuthenticationBloc>().uavt ??
                    "https://i.pravatar.cc/150?img=1.jpg",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          5.horizontal,
          Text(context.read<AuthenticationBloc>().uname ?? "user"),
          5.horizontal,
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthenticationBloc>().add(LoggedOut());
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) {
          logDebug(state.runtimeType);
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              (state is HomeFetchDataDone)
                  ? Padding(
                      padding: const EdgeInsets.all(48),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [_dropdownMenu(state.data)],
                          ),
                          15.vertical,
                          Expanded(
                            child: ListView.separated(
                              itemCount: state.data.length,
                              itemBuilder: (context, index) {
                                var post = state.data[index];
                                return LVPost(post: post);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return 10.vertical;
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              state is HomeLoading ? const LVLoading() : Container()
            ],
          );
        },
      ),
    );
  }
}
