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
            String sql = "SELECT * FROM Article ORDER BY created_at DESC LIMIT ? OFFSET ?";
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
    public ArrayList<Article> getArticlesOfUser(int user_id, int page)  {
        int offset = (page - 1) * PAGE_SIZE;
        try{
            Connection con = DBHelper.getConnection();
            String sql = "SELECT * FROM Article WHERE user_id = ? ORDER BY created_at DESC LIMIT ? OFFSET ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, user_id);
            stmt.setInt(2, PAGE_SIZE);
            stmt.setInt(3, offset);

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
            String query = "INSERT INTO Article(title, content, category, created_at, user_id) VALUE (? ,? , ?, ?, ?)";
            PreparedStatement statement = con.prepareStatement(query);
//            statement.setInt(1, article.getId());
            statement.setString(1, article.getTitle());
            statement.setString(2, article.getContent() );
            statement.setString(3, article.getCategory().name());
            statement.setDate(4, new Date(article.getCreated_at().getTime()));
            statement.setInt(5, article.getUser_id());
            statement.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteArticle(int id) {
        try {
            Connection con = DBHelper.getConnection();
            String query = "DELETE FROM Article WHERE id = ?";
            PreparedStatement statement = con.prepareStatement(query);
            statement.setInt(1, id);
            statement.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public ArrayList<Article> getArticlesByCategory(String selectedCategory) {
        ArrayList<Article> articles = new ArrayList<>();

        try {
            Connection connection = DBHelper.getConnection();
            String sql = "SELECT * FROM Article WHERE category = ?";
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, selectedCategory);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return articles;
    }

    public ArrayList<Article> searchListArticleByTitle(String title) {
        ArrayList<Article> articles = new ArrayList<>();
        try {
            Connection con = DBHelper.getConnection();
            String query = "SELECT * FROM Article WHERE title LIKE ?"; // Lấy tất cả bài viết có tiêu đề chứa từ khóa
            PreparedStatement statement = con.prepareStatement(query);
            statement.setString(1, "%" + title + "%"); // Tìm kiếm bài báo có tiêu đề chứa từ khóa
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {

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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return articles;
    }


    public ArrayList<Article> searchArticles(String keyword, int page) {
        int offset = (page - 1) * PAGE_SIZE;
        try {
            Connection con = DBHelper.getConnection();
            String query = "SELECT * FROM Article WHERE title LIKE ? ORDER BY created_at DESC LIMIT ? OFFSET ?";
            PreparedStatement statement = con.prepareStatement(query);
            statement.setString(1, "%" + keyword + "%");
            statement.setInt(2, PAGE_SIZE);
            statement.setInt(3, offset);

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

    public Article getArticleById(int id) {
        try {
            Connection con = DBHelper.getConnection();
            String query = "SELECT * FROM Article WHERE id = ?";
            PreparedStatement statement = con.prepareStatement(query);
            statement.setInt(1, id);

            ResultSet rs = statement.executeQuery();
            if (!rs.next()) {
                return null;
            }
            Article article = new Article(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getDate(5),
                    rs.getInt(6)
            );
            rs.close();
            statement.close();
            return article;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
