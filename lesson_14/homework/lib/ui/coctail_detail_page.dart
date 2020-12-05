//todo
// Отобразить страницу CocktailDetailsScreen из домашнего задания с урока 4
// Получить Cocktail можно из  AsyncCocktailRepository().fetchCocktailDetails(id)

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/src/model/cocktail.dart';
import '../core/src/repository/async_cocktail_repository.dart';

class CocktailDetailPageLoader extends StatelessWidget {
  final String id;

  CocktailDetailPageLoader(this.id);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cocktail>(
        future: AsyncCocktailRepository().fetchCocktailDetails(id),
        builder: (context, AsyncSnapshot<Cocktail> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/shaker.png",
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 9),
                    child: const Text(
                      'Поиск...',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffEAEAEA),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Ошибка: ${snapshot.error}',
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return Material(child: CocktailDetailPage(snapshot.data));
          }
        });
  }
}

class CocktailDetailPage extends StatelessWidget {
  const CocktailDetailPage(
    this.cocktail, {
    Key key,
  }) : super(key: key);

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderArea(),
              _buildNameArea(),
              _buildIngredientsArea(),
              _buildInstructionArea(),
              _buildRatingArea()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderArea() {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Image.network(cocktail.drinkThumbUrl),
          Positioned(
            left: 28,
            top: 16,
            child: Icon(
              Icons.arrow_back,
              color: Color(0xffffffff),
              size: 24.0,
            ),
          ),
          Positioned(
            right: 19,
            top: 16,
            child: Icon(
              Icons.open_in_new,
              color: Color(0xffffffff),
              size: 24.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameArea() {
    return Container(
      padding: const EdgeInsets.only(left: 32, right: 34, top: 33, bottom: 24),
      color: Color(0xff1A1927),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  cocktail.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Icons.favorite,
                color: Color(0xffffffff),
                size: 20.0,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              cocktail.id,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: Color(0xff848396),
              ),
            ),
          ),
          _buildNameAreaTitle("Категория коктейля", 20),
          _buildNameAreaValue(cocktail.category.value, 8),
          _buildNameAreaTitle("Тип коктейля", 18),
          _buildNameAreaValue(cocktail.cocktailType.value, 8),
          _buildNameAreaTitle("Тип стекла", 16),
          _buildNameAreaValue(cocktail.glassType.value, 10),
        ],
      ),
    );
  }

  Widget _buildNameAreaTitle(String text, double marginTop) => Container(
        margin: EdgeInsets.only(top: marginTop),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Color(0xffeaeaea),
          ),
        ),
      );

  Widget _buildNameAreaValue(String text, double marginTop) => Container(
        padding: const EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 6),
        margin: EdgeInsets.only(top: marginTop),
        decoration: new BoxDecoration(
          color: Color(0xff15151C),
          borderRadius: BorderRadius.all(
            const Radius.circular(30.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            color: Color(0xffffffff),
          ),
        ),
      );

  Widget _buildIngredientsArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 32, top: 24, right: 32, bottom: 24),
      color: Color(0xff000000),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Ингредиенты:",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Color(0xffB1AFC6),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cocktail.ingredients
                  .map(
                    (item) => Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.ingredientName,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          Text(
                            item.measure,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionArea() {
    var items = cocktail.instruction.split("\n");
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 24, bottom: 40),
      color: Color(0xff201F2C),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Text(
              "Инструкция для приготовления",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Color(0xffB1AFC6),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map(
                    (item) => Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      margin: const EdgeInsets.only(top: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "•",
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffffffff),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Text(
                                item.replaceAll("- ", ""),
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 24, bottom: 24, left: 20, right: 20),
      color: Color(0xff1A1927),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildRatingStar(true),
          _buildRatingStar(true),
          _buildRatingStar(true),
          _buildRatingStar(false),
          _buildRatingStar(false),
        ],
      ),
    );
  }

  Widget _buildRatingStar(bool isSelected) => CircleAvatar(
        child: Icon(
          Icons.star,
          color: Color(isSelected ? 0xffffffff : 0xff1A1927),
          size: 32.0,
        ),
        backgroundColor: Color(0xff2A293A),
        radius: 24.0,
      );
}