package Model.DAO;

import Model.Bean.Article;
import Model.DBHelper;

import java.sql.*;
import java.util.ArrayList;

public class ArticleDAO {
    private static final int PAGE_SIZE = 10;

    public ArrayList<Article> getAllArticles()  {
        try{
            Connection con = DBHelper.getConnection();
            Statement statement = con.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM Article");
            ArrayList<Article>articles = new ArrayList<Article>();

            while (rs.next()){
                Article article = new Article(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getInt(6)
                );
                articles.add(article);
            }
            rs.close();
            statement.close();
            return articles;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public ArrayList<Article> getTenArticlesAtPage(int page)  {
        int offset = (page - 1) * PAGE_SIZE;
        try{
            Connection con = DBHelper.getConnection();
            String sql = "SELECT * FROM articles ORDER BY created_at DESC LIMIT ? OFFSET ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, PAGE_SIZE);
            stmt.setInt(2, offset);

            ResultSet rs = stmt.executeQuery();
            ArrayList<Article> articles = new ArrayList<>();
            while (rs.next()) {
                articles.add(new Article(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getInt(6)
                ));
            }

            rs.close();
            stmt.close();
            return articles;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public boolean addNewArticle(Article article) {
        try {
            Connection con = DBHelper.getConnection();
            String query = "INSERT INTO Article VALUE (?, ? ,? , ?, ?, ?)";
            PreparedStatement statement = con.prepareStatement(query);
            statement.setInt(1, article.getId());
            statement.setString(2, article.getTitle());
            statement.setString(3, article.getContent() );
            statement.setString(4, article.getCategory().name());
            statement.setDate(5, new Date(article.getCreated_at().getTime()));
            statement.setInt(6, article.getUser_id());
            statement.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public ArrayList<Article> searchArticles(String keyword) {
        try {
            Connection con = DBHelper.getConnection();
            String query = "SELECT * FROM Article WHERE title LIKE ? ORDER BY created_at DESC LIMIT ?";
            PreparedStatement statement = con.prepareStatement(query);
            statement.setString(1, "%" + keyword + "%");
            statement.setInt(2, PAGE_SIZE);

            ResultSet rs = statement.executeQuery();
            ArrayList<Article> articles = new ArrayList<>();
            while (rs.next()) {
                articles.add(new Article(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getDate(5),
                        rs.getInt(6)
                ));
            }
            rs.close();
            statement.close();
            return articles;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
