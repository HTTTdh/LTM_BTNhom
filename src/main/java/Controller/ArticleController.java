package Controller;

import Model.BO.ArticleBO;
import Model.Bean.Article;
import Model.Bean.ArticleShow;
import Model.Bean.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/article")
public class ArticleController extends HttpServlet {
    public ArticleBO bo = new ArticleBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)  {
        String action = req.getParameter("action");
        try{
            switch (action) {
                case "home":
                    showHome(req, resp);
                    return;
                case "add":
                    showAddPage(req, resp);
                    return;
                case "search":
                    showSearchResult(req, resp);
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void showAddPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String errorMessage = (String) req.getAttribute("errorMessage");
        if (errorMessage != null) {
            req.setAttribute("errorMessage", errorMessage);
        }
        ArrayList<Category> categories = bo.getAllCategories();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/templates/AddArticle.jsp").forward(req, resp);
    }

    private void showHome(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pageParam = req.getParameter("page");
        int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

        ArrayList<ArticleShow> articles = bo.getTenArticlesAtPage(page);
        req.setAttribute("articles", articles);

        ArrayList<String> introductionLines = bo.getIntroductionLines(articles);
        req.setAttribute("introductionLines", introductionLines);

        ArrayList<Category> categories = bo.getAllCategories();
        req.setAttribute("categories", categories);

        req.getRequestDispatcher("/templates/PageHome.jsp").forward(req, resp);
    }

    private void showSearchResult(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String pageParam = req.getParameter("page");
        int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
        ArrayList<ArticleShow> articles = bo.searchArticles(keyword, page);

        req.setAttribute("articles", articles);
        req.getRequestDispatcher("/searchResults.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try{
            switch (action) {
                case "add":
                    handleAdd(req, resp);
                    return;
                case "edit":
                    handleEdit(req, resp);
                    return;
                    case "delete":
                    handleDelete(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String id = req.getParameter("id");
        int article_id = Integer.parseInt(id);
        boolean result = bo.deleteArticle(article_id);

        if (result) {
            resp.sendRedirect("article?action=home");
        } else {
            req.setAttribute("errorMessage", "Failed to delete article");
            req.getRequestDispatcher("YourArticles.jsp").forward(req, resp);
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String category = req.getParameter("category");
        HttpSession session = req.getSession();
//        int user_id = (int) session.getAttribute("user_id");
        int user_id = 1;

        Article article = new Article(title, content, category, user_id);
        boolean result = bo.addArticle(article);

        if (result) {
            resp.sendRedirect("article?action=home");
        } else {
//            req.setAttribute("errorMessage", "Failed to add article");
//            req.getRequestDispatcher("/templates/AddArticle.jsp").forward(req, resp);
        }

    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp) {
    }


}
