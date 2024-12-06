package Model.BO;

import Model.Bean.Article;
import Model.Bean.Category;
import Model.DAO.ArticleDAO;

import java.util.ArrayList;
import java.util.Arrays;

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

    public ArrayList<Article> searchArticles(String keyword) {
        return dao.searchArticles(keyword);
    }

}
