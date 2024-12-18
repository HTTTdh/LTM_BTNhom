package Controller;

import Model.BO.CommentBO;
import Model.BO.UserBO;
import Model.Bean.Comment;
import Model.Bean.UserShow;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/comment")
public class CommentController extends HttpServlet {
    public CommentBO bo = new CommentBO();
    public UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        String action = req.getParameter("action");
        try {

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            switch (action) {
                case "add":
                    addComment(req, resp);
                    return;
                case "delete":
//                    deleteComment(req, resp);
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace();
    }
}

    private void addComment(HttpServletRequest req, HttpServletResponse resp) {
        int article_id = Integer.parseInt(req.getParameter("article_id"));
        int user_id = Integer.parseInt(req.getParameter("user_id"));
        String content = req.getParameter("content");
        HttpSession session = req.getSession();

        bo.addComment(new Comment( article_id, user_id, content));

        try {
            resp.sendRedirect("article?action=detail&id=" + article_id);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
