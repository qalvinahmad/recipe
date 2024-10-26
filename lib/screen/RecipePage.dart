import 'package:flutter/material.dart';
import 'package:recipe/model/RecipeMode.dart';
import 'package:recipe/model/data/recipe_storage.dart';
import 'package:recipe/screen/NewRecipe.dart';
import 'package:recipe/screen/saved.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class Recipepage extends StatefulWidget {
  @override
  _Recipepage createState() => _Recipepage();
}

class _Recipepage extends State<Recipepage> {
  List<RecipeModel> savedRecipes = []; // Daftar resep yang disimpan
  RecipeStorage recipeStorage = RecipeStorage();

  @override
  void initState() {
    super.initState();
    loadSavedRecipes();
  }

  Future<void> loadSavedRecipes() async {
    List<String> savedRecipeIds = await recipeStorage.getSavedRecipes();
    savedRecipes =
        await getRecipesByIds(savedRecipeIds); // Mengambil resep berdasarkan ID
    setState(() {});
  }

  Future<List<RecipeModel>> getRecipesByIds(List<String> ids) async {
    List<RecipeModel> recipes = [];
    for (String id in ids) {
      RecipeModel recipe = RecipeModel.demoRecipe.firstWhere(
        (recipe) => recipe.id == id,
        orElse: () => RecipeModel(
          id: '',
          title: 'Unknown Recipe',
          writer: 'Unknown',
          description: '',
          cookingTime: 0,
          servings: 0,
          imgPath: '',
          ingredients: [],
        ),
      );
      // Pastikan Anda hanya menambahkan resep yang valid
      if (recipe.id.isNotEmpty) {
        recipes.add(recipe);
      }
    }
    return recipes;
  }

  Future<void> toggleSaveRecipe(RecipeModel recipe) async {
    if (savedRecipes.contains(recipe)) {
      await recipeStorage.removeRecipe(recipe.id);
      setState(() {
        savedRecipes.remove(recipe);
      });
    } else {
      await recipeStorage.saveRecipe(recipe);
      setState(() {
        savedRecipes.add(recipe);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 18),
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.red,
                  tabs: [
                    Tab(text: "New Recipes".toUpperCase()),
                    Tab(text: "Saved".toUpperCase()),
                  ],
                  labelColor: Colors.black,
                  indicator: DotIndicator(
                    color: Colors.black,
                    distanceFromCenter: 16,
                    radius: 3,
                    paintingStyle: PaintingStyle.fill,
                  ),
                  unselectedLabelColor: Colors.black.withOpacity(0.3),
                  labelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  labelPadding: EdgeInsets.symmetric(horizontal: 24),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    NewRecipe(),
                    SavedRecipesPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
