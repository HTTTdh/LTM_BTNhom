<%@ page import="Model.Bean.ArticleShow" %>
<%@ page import="Model.Bean.UserShow" %>
<%@ page import="Model.Bean.Category" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: chauthi
  Date: 09/12/2024
  Time: 09:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    ArticleShow article = (ArticleShow) request.getAttribute("article");
%>
<head>
    <title><%= article.getTitle() %></title>
    <link rel="stylesheet" href="../static/css/header_footer_style.css">
    <link rel="stylesheet" href="../static/css/main_page.css">
    <link rel="stylesheet" href="../static/css/article_detail.css">
</head>
<%
    ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
%>
<body>
<header class="header">
    <div class="header-content">
        <img src="../static/resources/logo.png" alt="Logo" class="logo">
        <div class="text">
            <span id="current-date"></span>
        </div>
        <div>
            <label for="location-select">Địa điểm: </label>
            <select id="location-select">
                <option value="HaNoi">Hà Nội</option>
                <option value="HoChiMinh">Hồ Chí Minh</option>
                <option value="DaNang">Đà Nẵng</option>
                <option value="HaiPhong">Hải Phòng</option>
                <option value="CanTho">Cần Thơ</option>
            </select>
        </div>
        <div>
            <input type="search" placeholder="Tìm kiếm thông tin...">
            <button> Submit </button>
        </div>
        <div>
            <% UserShow user = (UserShow) session.getAttribute("user"); %>
            <h4>
                Xin chào,
                <%=user.getFullName() %>
            </h4>
        </div>
        <div>
            <button>
                <i class="fas fa-sign-in-alt"></i> Đăng xuất
            </button>
        </div>
        <div>
            <i class="fas fa-bell"></i>
        </div>
    </div>
    <nav style="padding-top: 25px; padding-bottom: 15px;">
        <ul>
            <li><a href="/home"><h3>Trang chủ</h3></a></li>
            <%
                for (Category category : categories) {
            %>
            <li><a href="#"><h3><%= category.getCategory_name() %></h3></a>
            </li>
            <%
                }
            %>
            <li><a href="/article?action=add"><h3>Đăng bài</h3></a>
            <li><a href="#">
                <div class="hamburger-menu"></div>
                <div class="hamburger-menu"></div>
                <div class="hamburger-menu"></div>
            </a>
            </li>
        </ul>
    </nav>
</header>
<main>
    <div class="article-container">
        <header class="article-header">
            <h1 class="article-title"><%= article.getTitle() %></h1>
            <p class="article-date">Published on: <%= article.getCreated_at() %></p>
        </header>

        <section class="article-content">
            <p><%= article.getContent() %></p>
        </section>
    </div>
</main>
</body>
</html>