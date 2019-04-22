import 'package:flutter/material.dart';
import 'package:fluttery_filmy/model/MovieDetail.dart';

class ProductionCompaniesScroller extends StatelessWidget {
  ProductionCompaniesScroller(this.productionCompanies);

  final List<ProductionCompanies> productionCompanies;

  Widget _buildCompanies(BuildContext context, int index) {
    var companies = productionCompanies[index];
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              companies.logoPath != null
                  ? "https://image.tmdb.org/t/p/w500/" + companies.logoPath
                  : "https://image.ibb.co/fUMxRT/ic-launcher-movies.png",
            ),
            radius: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              companies.name,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Production Companies',
            style: textTheme.subhead.copyWith(fontSize: 18),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(120),
          child: ListView.builder(
            itemCount: productionCompanies.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12, left: 20),
            itemBuilder: _buildCompanies,
          ),
        ),
      ],
    );
  }
}
