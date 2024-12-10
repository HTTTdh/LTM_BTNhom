package Controller;

import Model.BO.UserBO;
import Model.Bean.UserShow;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    public UserBO bo = new UserBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("Login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        UserShow user = bo.login(username, password);

        if (user != null) {
            req.getSession().setAttribute("user", user);
            String nameRole = user.getNameRole();
            System.out.println(user.getFullName());
            System.out.println(nameRole);
            if (nameRole.equals("ADMIN")) {
                resp.sendRedirect("admin?action=home");
            }
            else {
                resp.sendRedirect("article?action=home");
            }
        } else {
            req.setAttribute("errorMessage", "Invalid username or password");
            req.getRequestDispatcher("Login.jsp").forward(req, resp);
        }
    }
}