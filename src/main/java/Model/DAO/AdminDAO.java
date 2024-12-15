package Model.DAO;

import Model.Bean.*;
import Model.DBHelper;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    public List<ArticleShow> listArticle() {
        List<ArticleShow> articles = new ArrayList<ArticleShow>();
        try{
            String sql =
                    "SELECT " +
                            "    Article.id AS article_id, " +
                            "    User.id AS user_id, " +
                            "    Article.*, " +
                            "    User.*, " +
                            "    Role.* " +
                            "FROM Article " +
                            "INNER JOIN User ON User.id = Article.user_id " +
                            "INNER JOIN Role ON Role.id = User.id_role";
            PreparedStatement ps = DBHelper.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                articles.add(new ArticleShow(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        Category.valueOf(rs.getString("category")),
                        rs.getDate("created_at"),
                        new UserShow(rs.getInt("id"), rs.getString("fullname"),
                                rs.getString("username"), rs.getBoolean("is_active"),
                                rs.getString("role")))
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return articles;
    }

    public List<UserShow> listUser() {
        List<UserShow> users = new ArrayList<>();
        try{
            String sql = "select User.*, Role.* from User inner join Role on User.id_role = Role.id";
            PreparedStatement ps = DBHelper.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add( new UserShow(
                        rs.getInt("id"),
                        rs.getString("fullname"),
                        rs.getString("username"),
                        rs.getBoolean("is_active"),
                        rs.getString("role")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
    public boolean deleteArticles(int id) {
        boolean check = false;
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = DBHelper.getConnection();
            if (connection == null) {
                System.out.println("Kết nối cơ sở dữ liệu không thành công.");
                return false;
            }

            String sql = "DELETE FROM Article WHERE id=?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);

            int row = ps.executeUpdate();
            if (row > 0) {
                check = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return check;
    }

    public ArticleShow getArticles(int id) {
        ArticleShow articles = new ArticleShow();
        Connection connection = null;
        try{
        String sql =   "SELECT " +
                "    Article.id AS article_id, " +
                "    User.id AS user_id, " +
                "    Article.*, " +
                "    User.*, " +
                "    Role.* " +
                "FROM Article " +
                "INNER JOIN User ON User.id = Article.user_id " +
                "INNER JOIN Role ON Role.id = User.id_role where Article.id=?";
        PreparedStatement ps = DBHelper.getConnection().prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
                articles.setId(rs.getInt("id"));
                articles.setTitle(rs.getString("title"));
                articles.setContent(rs.getString("content"));
                articles.setCategory(Category.valueOf(rs.getString("category")));
                articles.setCreated_at(rs.getTimestamp("created_at"));
                articles.setAuthor(
                        new UserShow(rs.getInt("id"), rs.getString("fullname"),
                                rs.getString("username"), rs.getBoolean("is_active"),
                                rs.getString("role"))
                );
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
        return articles;
    }

    public boolean updateArticles(String title, String content, String category, int id) {
        System.out.println(category);
        boolean check = false;
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = DBHelper.getConnection();
            String sql = "update Article set title=?, content=?, category=? where id=?";
            ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setString(3, category);
            ps.setInt(4, id);

            // Thực thi truy vấn
            int row = ps.executeUpdate();
            if (row > 0) {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }


    public boolean deleteUser(int id) {
        boolean check = false;
        try{
            Connection connection = DBHelper.getConnection();
            String sql = "DELETE FROM User WHERE id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,id);
            int row = ps.executeUpdate();
            if (row > 0) {check=true;}
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
}
