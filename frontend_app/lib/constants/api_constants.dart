class ENApi {
  // Base URLS
  static const String prodBaseApiUrl = "https://news-backend-api.onrender.com/api/";
  static const String debugBaseApiUrl = "http://192.168.29.98:8000/api/";

  // Login
  static const String login = "auth/login/"; // POST

  // Registration
  static const String registration = "auth/registration/"; // POST

  // Password Reset
  static const String passwordReset = "auth/reset-password-link/"; // POST

  // Category
  static const String getAllCategory = "category/"; // GET
  static const String getSingleCategory = "category/"; // GET ? category_id

  // Article
  static const String getAllArticle = "articles/"; // GET
  static const String getSingleArticle = "articles/"; // GET ? article_id
}
