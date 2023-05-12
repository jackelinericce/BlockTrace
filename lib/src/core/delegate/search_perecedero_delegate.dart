import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/presentacion/providers/perecedero_provider.dart';

class SearchPerecederoDelegate extends SearchDelegate<PerecederoEntity?> {
  final WidgetRef ref;
  SearchPerecederoDelegate({required this.ref})
      : super(
          searchFieldLabel: 'Buscar Perecedero',
        );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // if (query.length < 3) {
    //   return Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       Center(
    //         child: Text(
    //           "Search term must be longer than two letters.",
    //         ),
    //       )
    //     ],
    //   );
    // }
    List<PerecederoEntity> perecederos = ref.read(perecederoProvider);
    List<PerecederoEntity> perecederosAux = [...perecederos];
    perecederosAux.retainWhere((perecedero) {
      return perecedero.name.toLowerCase().contains(query.toLowerCase());
      //you can add another filter conditions too
    });
    if (perecederosAux.length == 0) {
      return Center(
        child: Container(
          child: OutlinedButton(
            child: const Text('guardar perecedero'),
            onPressed: () {
              var newPerecedero = PerecederoEntity(name: query);
              ref.read(perecederoProvider.notifier).update(
                    (state) => [...perecederos, newPerecedero],
                  );
              close(context, newPerecedero);
            },
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: perecederosAux.length,
      itemBuilder: (_, i) {
        PerecederoEntity perecedero = perecederosAux[i];
        return Container(
          // color: Colors.blue,
          child: ListTile(
            leading: const Icon(Icons.verified),
            title: Text(perecedero.name),
            onTap: () async {
              close(context, perecedero);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PerecederoEntity> perecederos = ref.read(perecederoProvider);
    List<PerecederoEntity> perecederosAux = [...perecederos];
    perecederosAux.retainWhere((perecedero) {
      return perecedero.name.toLowerCase().contains(query.toLowerCase());
      //you can add another filter conditions too
    });

    return ListView.builder(
      itemCount: perecederosAux.length,
      itemBuilder: (_, i) {
        PerecederoEntity perecedero = perecederosAux[i];
        return Container(
          // color: Colors.blue,
          child: ListTile(
            leading: const Icon(Icons.verified),
            title: Text(perecedero.name),
            onTap: () async {
              close(context, perecedero);
            },
          ),
        );
      },
    );
  }
}
