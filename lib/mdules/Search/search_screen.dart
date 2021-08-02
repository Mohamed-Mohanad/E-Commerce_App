import 'package:final_shop_app/mdules/Search/search_cubit.dart';
import 'package:final_shop_app/mdules/Search/search_state.dart';
import 'package:final_shop_app/shared/components/compnents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      onSubmit: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context).model!.data!.data[index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount:
                              SearchCubit.get(context).model!.data!.data.length,
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
