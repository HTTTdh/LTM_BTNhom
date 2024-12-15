package Model.BO;

import Model.Bean.Comment;
import Model.DAO.CommentDAO;

import java.util.ArrayList;

public class CommentBO {
    public CommentDAO dao = new CommentDAO();
    public ArrayList<Comment> getTenCommentsPerPage(int page, int article_id) {
        return dao.getTenCommentsPerPage(page, article_id);
    }

    public boolean addComment(Comment comment) {
        return dao.addNewComment(comment);
    }
}
