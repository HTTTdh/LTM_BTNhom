package Model.BO;

import Model.Bean.Article;
import Model.Bean.ArticleShow;
import Model.Bean.Category;
import Model.DAO.ArticleDAO;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class ArticleBO {
    public ArticleDAO dao = new ArticleDAO();
    public UserBO userBO = new UserBO();
    public ArrayList<ArticleShow> getAllArticles() {
        return dao.getAllArticles().stream().map(this::mapToArticleResponseWithImage).collect(Collectors.toCollection(ArrayList::new));
    }
    public ArrayList<ArticleShow> getTenArticlesAtPage(int page) {
        return dao.getTenArticlesAtPage(page).stream().map(this::mapToArticleResponseWithImage).collect(Collectors.toCollection(ArrayList::new));
    }

    public ArrayList<Category> getAllCategories() {
        return new ArrayList<>(Arrays.asList(Category.values()));
    }

    public ArrayList<Article> getArticlesByCategory(String selectedCategory) {
        return dao.getArticlesByCategory(selectedCategory);
    }

    public ArrayList<Article> searchListArticleByTitle(String title) {
        return dao.searchListArticleByTitle(title);
    }

    public boolean addArticle(Article article) {
        return dao.addNewArticle(article);
    }

    public boolean deleteArticle(int id) {
        return dao.deleteArticle(id);
    }

    public ArrayList<ArticleShow> searchArticles(String keyword, int page) {
        return dao.searchArticles(keyword, page).stream().map(this::mapToArticleResponseWithImage).collect(Collectors.toCollection(ArrayList::new));
    }

    private ArticleShow mapToArticleResponseWithImage(Article article) {
        String firstImage = extractFirstImage(article.getContent());
        ArticleShow articleShow = new ArticleShow(
                article.getId(),
                article.getTitle(),
                article.getContent(),
                article.getCategory(),
                article.getCreated_at(),
                userBO.mapToUserShow(userBO.getUserById(article.getUser_id())),
                firstImage
        );
        return articleShow;
    }

    public ArticleShow getArticleById(int id)
    {
        Article article = dao.getArticleById(id);
        if (article == null) {
            System.out.println("Article not found");
            return null;
        }
        return mapToArticleResponseWithImage(article);
    }

   public String extractFirstImage(String content) { // tìm tất cả các thẻ hình ảnh <img> trong nội dung bài viết.
        // Lấy ra URL của hình ảnh đầu tiên từ kết quả tìm kiếm.
        Pattern pattern = Pattern.compile("<img[^>]+src=\"([^\"]+)\"");
        Matcher matcher = pattern.matcher(content);
        return matcher.find() ? matcher.group(1) : null;
    }

    public ArrayList<String> getIntroductionLines(ArrayList<ArticleShow> articles){
        ArrayList<String> result = new ArrayList<>();
        for (ArticleShow article : articles) {
            String content = article.getContent();
            String line = "Click để xem chi tiết";
            int startIndex = 0;

            // Xác định vị trí của <div> đầu tiên
            if (content.startsWith("<div>")) {
                startIndex = content.indexOf("<div>") + "<div>".length();
            }

            // Xác định vị trí của dấu chấm đầu tiên sau <div>
            int endIndex = content.indexOf(".", startIndex);

            // Kiểm tra nếu cả hai chỉ số hợp lệ
            if (startIndex >= 0 && endIndex > startIndex) {
                line = content.substring(startIndex, endIndex + 1);
                result.add(line);
            }
        }
        return result;
    }


}
