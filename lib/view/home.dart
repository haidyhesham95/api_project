import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/product_cubit.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('Products'),
        centerTitle: true,
      ) ,
      body:BlocConsumer < ProductCubit, ProductState> (
        listener: (context,state){},

       builder: (context,state){
    ProductCubit cubit = ProductCubit.get(context);


       if (state is ProductLoading)
          return const Center(child: CircularProgressIndicator());
        if (state is Error)
          return Center(child: Text(state.errorMessage));
         return Column(
          children: [
          const SizedBox(height: 20),
              Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.only(left: 12, right: 12, ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: 25
              ),
              itemCount:cubit.myList.length,
              itemBuilder: (context, index) {
                return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),

                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(cubit.myList[index].imageUrl!, width: 100, height: 100, fit: BoxFit.fill),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0, ),
                          child: Text(
                            '${cubit.myList[index].name ?? 'no data'}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, ),
                          child: Text(
                            '${cubit.myList[index].description ?? 'no data'}',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),

                          ),
                        ),
                        const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text(
                              '\$${cubit.myList[index].price ?? 'no data'}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                              const Icon(Icons.shopping_bag, color: Colors.grey,size: 25,)
                          ],),
                        ),
                        const SizedBox(height: 8,)

                      ],
                    ),
                  ),
                );
              },
          ),
        )
          ],
        );

       },
      ),
        );
  }
}
