import 'package:flutter/material.dart';
import 'package:flutter_app/model/MovieDetail.dart';

class ProductionCompaniesScroller extends StatelessWidget {
  ProductionCompaniesScroller(this.productionCompanies);

  final List<ProductionCompanies> productionCompanies;

  Widget _buildCompanies(BuildContext context, int index) {
    var companies = productionCompanies[index];
    return new Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: new Column(
        children: [
          new CircleAvatar(
            backgroundImage: new NetworkImage(companies.logoPath != null
                ? "https://image.tmdb.org/t/p/w500/" + companies.logoPath
                : "https://ibb.co/cma2t8",),
            radius: 35.0,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Text(companies.name,),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            itemBuilder: _buildCompanies,
          ),
        ),
      ],
    );
  }
}
