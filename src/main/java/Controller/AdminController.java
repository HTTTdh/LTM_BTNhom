package Controller;

import Model.BO.AdminBO;
import Model.BO.ArticleBO;
import Model.Bean.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    AdminBO adminBO = new AdminBO();
    public ArticleBO bo = new ArticleBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idArticles = req.getParameter("idArticles");
        String idUser = req.getParameter("idUser");
        switch (action) {
            case "home":{
                req.getRequestDispatcher("admin/homeAdmin.jsp").forward(req, resp);
                break;
            }
            case "listArticle":{
                List<ArticleShow> articles = adminBO.listArticles();
                req.setAttribute("listArticles", articles);
                req.getRequestDispatcher("admin/listArticle.jsp").forward(req, resp);
                break;
            }
            case "listUser": {
                List<UserShow> users = adminBO.listUser();
                req.setAttribute("listUsers", users);
                req.getRequestDispatcher("admin/listUser.jsp").forward(req, resp);
                break;
            }
            case "editArticle": {
                if (idArticles!=null){
                    System.out.println(idArticles);
                ArticleShow articles = adminBO.getArticles(Integer.parseInt(idArticles));
                System.out.println(articles.getTitle());
                    ArrayList<Category> categories = bo.getAllCategories();
                    req.setAttribute("categories", categories);
                req.setAttribute("articles", articles);
                req.getRequestDispatcher("templates/EditArticles.jsp").forward(req, resp);

                }
            break;
            }
            case "deleteArticle": {
                if (idArticles!=null){
                   doPost(req, resp);
                }
            }
            case "deleteUser": {
                if (idUser!=null){
                    doPost(req, resp);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idArticles = req.getParameter("idArticles");
        String idUser = req.getParameter("idUser");
        switch (action) {
            case "editArticle":{
                    int id = Integer.parseInt(req.getParameter("id"));
                    String title = req.getParameter("title");
                    String content = req.getParameter("content");
                    String category = req.getParameter("category");
                    String author = req.getParameter("author");
                    boolean check = adminBO.updateArticle(title, content, category, id);
                    if (check) {
                        RequestDispatcher rd = req.getRequestDispatcher("admin/homeAdmin.jsp");
                        rd.forward(req, resp);
                    }
                    else {
                        ArticleShow articles = adminBO.getArticles(Integer.parseInt(idArticles));
                        ArrayList<Category> categories = bo.getAllCategories();
                        req.setAttribute("categories", categories);
                        req.setAttribute("articles", articles);
                        req.getRequestDispatcher("templates/EditArticles.jsp").forward(req, resp);

                    }
                break;
            }
            case "deleteArticle":{
                    adminBO.deleteArticles(Integer.parseInt(idArticles));
                    req.getRequestDispatcher("admin?action=listArticle").forward(req, resp);
                break;
            }
            case "deleteUser":{
                    adminBO.deleteUser(Integer.parseInt(idUser));
                req.getRequestDispatcher("admin?action=listUser").forward(req, resp);
                break;
            }
        }
    }
}
