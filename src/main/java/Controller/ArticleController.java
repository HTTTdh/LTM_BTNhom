package Controller;

import Model.BO.AdminBO;
import Model.Bean.Article;
import Model.BO.ArticleBO;
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
    public AdminBO adminBO = new AdminBO();

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
                case "categorize":
                    System.out.println("Đã loc ");
                    showDetailCategory(req, resp);
                    return;
                case "detail":
                    showArticleDetail(req, resp);
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void showAddPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if ( session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login");
        }else {
//            req.getRequestDispatcher("article?action=home").forward(req, resp);
            String errorMessage = (String) req.getAttribute("errorMessage");
            if (errorMessage != null) {
                req.setAttribute("errorMessage", errorMessage);
            }
            ArrayList<Category> categories = bo.getAllCategories();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/templates/AddArticle.jsp").forward(req, resp);
        }
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

    private void showDetailCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryParam = req.getParameter("category");

        System.out.println("Chu de da chon la  : " + categoryParam);
        String selectedCategory = null;
        if (categoryParam != null) {
            try {
                selectedCategory = categoryParam ;
            } catch (IllegalArgumentException e) {
                req.setAttribute("error", "Chủ đề không hợp lệ");
                req.getRequestDispatcher("/templates/PageError.jsp").forward(req, resp);
                return;
            }
        }

        // Lấy danh sách bài viết theo chủ đề
        ArrayList<Article> articles = bo.getArticlesByCategory(selectedCategory);
        System.out.println("danh sach bai bao "+ articles);
        // Danh sách các bài viết đã chuyển đổi sang ArticleShow
        ArrayList<ArticleShow> ListCategory = new ArrayList<>();

        for (Article article : articles) {

            String firstImage = bo.extractFirstImage(article.getContent());
            ArticleShow articleShow = new ArticleShow(
                    article.getId(),
                    article.getTitle(),
                    article.getContent(),
                    article.getCategory(),
                    article.getCreated_at(),
                    null,
                    firstImage
            );

            ListCategory.add(articleShow);
        }
        System.out.println(" đây là danh sách đã lọc : "+ListCategory);
        req.setAttribute("ListCategory", ListCategory);
        ArrayList<Category> categories = bo.getAllCategories();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/templates/category.jsp").forward(req, resp);
    }

    private void showArticleDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        int article_id = Integer.parseInt(id);
        ArticleShow article = bo.getArticleById(article_id);
        req.setAttribute("article", article);

        ArrayList<Category> categories = bo.getAllCategories();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/templates/ArticleDetail.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try{
            switch (action) {
                case "add":
                    handleAdd(req, resp);
                    return;
                case "searchinfor":
                    System.out.println("Đã vào hàm thực hiện chức năng ");
                    handleSearchListRequest(req, resp);
                    return;
                    case "delete":
                    handleDelete(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void handleSearchListRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("query");
        System.out.println("Input received: " + query);

        ArrayList<Article> articles = bo.searchListArticleByTitle(query);

        ArrayList<ArticleShow> articleShows = new ArrayList<>();

        for (int i = 0; i < articles.size(); i++) {
            Article article = articles.get(i);

            // Lấy ảnh đầu tiên từ nội dung bài viết
            String firstImage = bo.extractFirstImage(article.getContent()); // Trích xuất ảnh đầu tiên

            // Tạo ArticleShow từ Article và thêm ảnh đầu tiên vào
            ArticleShow articleShow = new ArticleShow(
                    article.getId(),
                    article.getTitle(),
                    article.getContent(),
                    article.getCategory(),
                    article.getCreated_at(),
                    null,
                    firstImage
            );

            articleShows.add(articleShow);
        }
        req.setAttribute("articleShows", articleShows);
        req.setAttribute("keyword", query);
        ArrayList<Category> categories = bo.getAllCategories();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("templates/SearchResults.jsp").forward(req, resp);
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

}
