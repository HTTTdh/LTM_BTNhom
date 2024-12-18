package Model.BO;

import Model.Bean.Comment;
import Model.Bean.CommentShow;
import Model.Bean.User;
import Model.Bean.UserShow;
import Model.DAO.CommentDAO;

import java.util.ArrayList;
import java.util.stream.Collectors;

public class CommentBO {
    public CommentDAO dao = new CommentDAO();
    public UserBO userBO = new UserBO();

    public ArrayList<CommentShow> getTenCommentsPerPage(int page, int article_id) {
        return dao.getTenCommentsPerPage(page, article_id).stream().map(this::mapToCommentShow).collect(Collectors.toCollection(ArrayList::new));
    }

    public boolean addComment(Comment comment) {
        return dao.addNewComment(comment);
    }

    public CommentShow mapToCommentShow(Comment comment) {
        UserShow user = userBO.mapToUserShow(userBO.getUserById(comment.getUser_id()));
        return new CommentShow(
                comment.getId(),
                comment.getArticle_id(),
                user,
                comment.getContent(),
                comment.getCreated_at()
        );
    }
}
