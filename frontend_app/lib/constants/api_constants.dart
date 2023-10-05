class ENApi {
  // Base URL
  static const String apiUrl = "http://192.168.29.98:8000/api/";

  // Login
  static const String login = "auth/login/"; // POST

  // Registration
  static const String registration = "auth/registration/"; // POST

  // Category
  static const String getAllCategory = "category/"; // GET
  static const String getSingleCategory = "category/"; // GET ? category_id

  // Article
  static const String getAllArticle = "articles/"; // GET
  static const String getSingleArticle = "articles/"; // GET ? article_id
}
