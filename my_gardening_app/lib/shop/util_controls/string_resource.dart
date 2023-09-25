String bulbsInShopCategory = "Bulbs";
String accessoriesInShopCategory = "Accessories";
String fertilizersInShopCategory = "Fertilizers";
String furnitureInShopCategory = "Furniture";
String gardeningSuppliesInShopCategory = "Gardening Supplies";
String pebblesInShopCategory = "Pebbles";
String plantsInShopCategory = "Plants";
String potsInShopCategory = "Pots";
String seedsInShopCategory = "Seeds";
String toolsInShopCategory = "Tools";


String categoryStringController = "";
String categoryStringControllerFunction(String value) {
  categoryStringController = value;
  return categoryStringController;
}


List<dynamic> productsContainerForCategory = [];
List<dynamic> productsContainerForCategoryFinal = [];

String categoryProductsPage = "";
String nameProductsPage = "";
String priceProductsPage = "";
String shortDescProductsPage = "";
String longDescProductsPage = "";
int quantityProductsPage = 0;
String image1ProductsPage = "";
String image2ProductsPage = "";
String image3ProductsPage = "";
String image4ProductsPage = "";
String productUid = "";
String sellerUid = "";
int itemQuantityForAddToCart = 0;

double ratingsForReviewContainer = 0.0;
String reviewsForReviewContainer = "";
