import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarDetailsPage extends StatefulWidget {
  Map<String, String> carDatas;
  CarDetailsPage({super.key, required this.carDatas});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.carDatas);
    print('jjj');
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.go('/cars_list'),
              icon: const Icon(Icons.arrow_back)),
          title: Text(widget.carDatas['car_brand']!)),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.carDatas['car_picture']!,
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    return context.goNamed("car_contract_form",
                        queryParams: widget.carDatas);
                  },
                  child: const Text('Nouveau contrat'))
            ],
          )
        ],
      ),
    );
  }
}
