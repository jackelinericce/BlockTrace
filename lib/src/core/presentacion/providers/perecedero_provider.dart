import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';

final perecederoProvider = StateProvider<List<PerecederoEntity>>(
  (ref) => [
    PerecederoEntity(
      id: '1',
      name: 'Manzana',
      description: 'esto es una manszana',
    ),
    PerecederoEntity(
      id: '2',
      name: 'Plátano',
      description: 'esto es una manszana',
    ),
    PerecederoEntity(
      id: '3',
      name: 'Uva',
      description: 'esto es una manszana',
    ),
    PerecederoEntity(
      id: '4',
      name: 'Pera',
      description: 'esto es una manszana',
    ),
  ],
);
