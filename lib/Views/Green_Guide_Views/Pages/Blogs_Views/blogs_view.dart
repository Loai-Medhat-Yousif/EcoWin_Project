import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Blogs_View_Cubit/blog_view_cubit.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Green_Guide_Views/Pages/Blogs_Views/Widgets/blog_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogsView extends StatefulWidget {
  const BlogsView({super.key});

  @override
  State<BlogsView> createState() => _BlogsViewState();
}

class _BlogsViewState extends State<BlogsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  bool _isFetchingMore = false;

  void _onScroll() {
    final cubit = context.read<BlogsViewCubit>();
    final state = cubit.state;

    if (!_isFetchingMore &&
        state is BlogsViewLoaded &&
        state.hasMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _isFetchingMore = true;
      cubit.fetchMoreBlogs().whenComplete(() {
        _isFetchingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Themeconstants.backgroundimage,
      SafeArea(
          child: Column(children: [
        Padding(
          padding: REdgeInsets.symmetric(vertical: 10),
          child: GeneralAppBar(
            backbutton: true,
            title: "Blogs",
            ontap: () {
              Navigator.of(context).pop();
            },
            itemscolor: Colors.black,
          ),
        ),
        Expanded(
          child: BlocBuilder<BlogsViewCubit, BlogsViewState>(
              builder: (context, state) {
            if (state is BlogsViewInitial) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ));
            }
            if (state is BlogsViewLoaded) {
              return ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemCount: state.blogs.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.blogs.length) {
                    return Center(
                      child: Padding(
                        padding: REdgeInsets.all(16),
                        child: state.hasMore
                            ? CircularProgressIndicator(
                                color: AppColors.mainColor)
                            : Text(
                                "No More Blogs Left",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontFamily: "AirbnbCereal_W_Md"),
                              ),
                      ),
                    );
                  }

                  final blog = state.blogs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => BlogDetail(
                                  title: blog.title,
                                  body: blog.body,
                                  image: blog.image,
                                )),
                      );
                    },
                    child: Padding(
                      padding: REdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.mainColor),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: REdgeInsets.all(8),
                          child: Row(children: [
                            Container(
                              height: 0.15.sh,
                              width: 0.3.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.network(
                                  blog.image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: AppColors.mainColor,
                                    );
                                  },
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: Center(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  textAlign: TextAlign.center,
                                  blog.title,
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontFamily: "AirbnbCereal_W_Md",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          }),
        )
      ]))
    ]));
  }
}
