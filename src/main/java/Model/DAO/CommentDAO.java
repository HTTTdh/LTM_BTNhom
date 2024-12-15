package Model.DAO;

import Model.Bean.Comment;
import Model.DBHelper;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDAO {
    private static final int COMMENT_SIZE_PER_PAGE = 10;

    public ArrayList<Comment> getTenCommentsPerPage(int page, int article_id) {
        int offset = (page - 1) * COMMENT_SIZE_PER_PAGE;
        try{
            Connection con = DBHelper.getConnection();
            String sql = "SELECT * FROM COMMENT WHERE article_id = ? ORDER BY created_at DESC LIMIT ? OFFSET ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, article_id);
            stmt.setInt(2, COMMENT_SIZE_PER_PAGE);
            stmt.setInt(3, offset);

            ResultSet rs = stmt.executeQuery();
            ArrayList<Comment> cmts = new ArrayList<>();
            while (rs.next()) {
                cmts.add(new Comment(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getDate(5)
                ));
            }

            rs.close();
            stmt.close();
            return cmts;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public boolean addNewComment(Comment comment){
        try {
            Connection con = DBHelper.getConnection();
            String query = "INSERT INTO COMMENT(article_id, user_id, content, created_at ) VALUE (? ,? , ?, ?)";
            PreparedStatement statement = con.prepareStatement(query);
            statement.setInt(1, comment.getArticle_id());
            statement.setInt(2, comment.getUser_id() );
            statement.setString(3, comment.getContent());
            statement.setDate(4, new Date(comment.getCreated_at().getTime()));
            statement.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
