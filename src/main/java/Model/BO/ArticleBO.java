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

    private String extractFirstImage(String content) { // tìm tất cả các thẻ hình ảnh <img> trong nội dung bài viết.
        // Lấy ra URL của hình ảnh đầu tiên từ kết quả tìm kiếm.
        Pattern pattern = Pattern.compile("<img[^>]+src=\"([^\"]+)\"");
        Matcher matcher = pattern.matcher(content);
        return matcher.find() ? matcher.group(1) : null;
    }

}
