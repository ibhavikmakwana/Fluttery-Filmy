import 'package:flutter/material.dart';
import 'package:flutter_app/model/MovieDetail.dart';

class ProductionCompaniesScroller extends StatelessWidget {
  ProductionCompaniesScroller(this.productionCompanies);

  final List<ProductionCompanies> productionCompanies;

  _buildActor(BuildContext ctx, int index) {
    var companies = productionCompanies[index];

    return new Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: new Column(
        children: [
          new CircleAvatar(
            backgroundImage: new AssetImage(companies.logoPath),
            radius: 40.0,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Text(companies.name),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: new Text(
            'Production Companies',
            style: textTheme.subhead.copyWith(fontSize: 18.0),
          ),
        ),
        new SizedBox.fromSize(
          size: const Size.fromHeight(120.0),
          child: new ListView.builder(
            itemCount: productionCompanies.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12.0, left: 20.0),
            itemBuilder: _buildActor,
          ),
        ),
      ],
    );
  }
}
