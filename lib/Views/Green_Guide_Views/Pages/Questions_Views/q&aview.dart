import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Q&A_View_Cubit/questions_view_cubit.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Green_Guide_Views/Pages/Questions_Views/Widgets/question_card.dart';
import 'package:ecowin/Views/Green_Guide_Views/Pages/Questions_Views/Widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FQAView extends StatefulWidget {
  const FQAView({super.key});

  @override
  State<FQAView> createState() => _FQAViewState();
}

class _FQAViewState extends State<FQAView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  bool _isFetchingMore = false;

  void _onScroll() {
    final cubit = context.read<FQAViewCubit>();
    final state = cubit.state;

    if (!_isFetchingMore &&
        state is FAQViewLoaded &&
        state.hasMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _isFetchingMore = true;
      cubit.fetchMoreQuestions().whenComplete(() {
        _isFetchingMore = false;
      });
    }
    if (!_isFetchingMore &&
        state is FAQViewSearchLoaded &&
        state.hasMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _isFetchingMore = true;
      cubit.fetchMoreSearchedQuestions(searchController.text).whenComplete(() {
        _isFetchingMore = false;
      });
    }
  }

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
                title: "FAQ ",
                ontap: () {
                  Navigator.of(context).pop();
                },
                itemscolor: Colors.black,
              )),
          SearchWidget(
            searchController: searchController,
          ),
          0.02.sh.verticalSpace,
          BlocBuilder<FQAViewCubit, FAQViewState>(builder: (context, state) {
            if (state is FAQViewInitial || state is FAQViewSearch) {
              return Expanded(
                child: const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                )),
              );
            }
            if (state is FAQViewLoaded) {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: _scrollController,
                  itemCount: state.questions.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.questions.length) {
                      return Center(
                        child: Padding(
                          padding: REdgeInsets.all(16),
                          child: state.hasMore
                              ? CircularProgressIndicator(
                                  color: AppColors.mainColor,
                                )
                              : Text(
                                  "No more questions",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'AirbnbCereal_W_Md',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      );
                    }
                    final questions = state.questions[index];
                    return QuestionCard(
                      model: questions,
                    );
                  },
                ),
              );
            }
            if (state is FAQViewSearchLoaded) {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: _scrollController,
                  itemCount: state.questions.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.questions.length) {
                      return Center(
                        child: Padding(
                          padding: REdgeInsets.all(16),
                          child: state.hasMore
                              ? CircularProgressIndicator(
                                  color: AppColors.mainColor,
                                )
                              : Text(
                                  "No more questions",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'AirbnbCereal_W_Md',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      );
                    }
                    final questions = state.questions[index];
                    return QuestionCard(
                      model: questions,
                    );
                  },
                ),
              );
            }
            if (state is FAQViewError) {
              return Expanded(
                child: Center(
                  child: Text(
                    state.errorMessage,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'AirbnbCereal_W_Md',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
            if (state is FAQViewSearchError || state is FAQViewSearchError) {
              return Expanded(
                child: Center(
                  child: Text(
                    state.errorMessage,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'AirbnbCereal_W_Md',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
            return Container();
          }),
        ]),
      ),
    ]));
  }
}
