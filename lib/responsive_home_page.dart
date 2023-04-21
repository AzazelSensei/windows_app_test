import 'package:flutter/material.dart';

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Flutter Template'),
      ),
      body: _buildSmallLayout(),
      // body: LayoutBuilder(
      //   builder: (BuildContext context, BoxConstraints constraints) {
      //     if (constraints.maxWidth < 600) {
      //       return _buildSmallLayout();
      //     } else if (constraints.maxWidth > 601 &&
      //         constraints.maxWidth < 1199) {
      //       return _buildMediumLayout();
      //     } else {
      //       return _buildLargeLayout();
      //     }
      //   },
      // ),
    );
  }

  Widget _buildSmallLayout() {
    return Column(
      children: [
        Expanded(
          child: MaterialButton(
            minWidth: 100,
            height: 80.0,
            color: Colors.amber,
            onPressed: () {},
            child: const Text("data"),
          ),
        ),
        const Center(
          child: Text('This is a small layout'),
        ),
      ],
    );
  }

  Widget _buildMediumLayout() {
    return Column(
      children: const [
        Center(
          child: Text('This is a medium layout'),
        ),
      ],
    );
  }

  Widget _buildLargeLayout() {
    return Column(
      children: const [
        Center(
          child: Text('This is a large layout'),
        ),
      ],
    );
  }
}
