package Model.BO;

import Model.Bean.Article;
import Model.Bean.ArticleDTO;
import Model.Bean.Category;
import Model.DAO.ArticleDAO;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ArticleBO {
    public ArticleDAO dao = new ArticleDAO();
    public ArrayList<Article> getAllArticles() {
        return dao.getAllArticles();
    }
    public ArrayList<Article> getTenArticlesAtPage(int page) {
        return dao.getTenArticlesAtPage(page);
    }

    public ArrayList<Category> getAllCategories() {
        return new ArrayList<>(Arrays.asList(Category.values()));
    }

    public boolean addArticle(Article article) {
        return dao.addNewArticle(article);
    }

    public boolean deleteArticle(int id) {
        return dao.deleteArticle(id);
    }

    public ArrayList<Article> searchArticles(String keyword, int page) {
        return dao.searchArticles(keyword, page);
    }

    private ArticleDTO mapToArticleResponseWithImage(Article article) {
        String firstImage = extractFirstImage(article.getContent());
        ArticleDTO articleDTO = new ArticleDTO(
                article.getId(),
                article.getTitle(),
                article.getContent(),
                article.getCategory(),
                article.getCreated_at(),
                "Chau Thi",
                firstImage
        );
        return articleDTO;
    }

    private String extractFirstImage(String content) { // tìm tất cả các thẻ hình ảnh <img> trong nội dung bài viết.
        // Lấy ra URL của hình ảnh đầu tiên từ kết quả tìm kiếm.
        Pattern pattern = Pattern.compile("<img[^>]+src=\"([^\"]+)\"");
        Matcher matcher = pattern.matcher(content);
        return matcher.find() ? matcher.group(1) : null;
    }

}
