<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Bean.*" %><%--
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
    ArrayList<CommentShow> comments = (ArrayList<CommentShow>) request.getAttribute("comments");
%>
<head>
    <title><%= article.getTitle() %></title>
    <link rel="stylesheet" href="./static/css/header_footer_style.css">
    <link rel="stylesheet" href="./static/css/main_page.css">
    <link rel="stylesheet" href="../static/css/article_detail.css">
</head>
<%
    ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
%>
<body>
<header class="header">
    <div class="header-content">
        <img src="./static/resources/logo.png" alt="Logo" class="logo">
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
        <div class="weather-info">
            <i class="fas fa-cloud"></i> <!-- Biểu tượng mây -->
            <span>21°C</span> <!-- Nhiệt độ -->
        </div>
        <div>
            <input type="search" placeholder="Tìm kiếm thông tin...">
            <button> Submit </button>
        </div>

            <%
                if (session.getAttribute("user") != null) {
                    UserShow user = (UserShow) session.getAttribute("user");
            %>
        <div>
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
            <%
            }else{
        %>
        <div>
            <button onclick="navigateToLogin()">
                <i class="fas fa-sign-in-alt"></i> Đăng nhập
            </button>
        </div>
            <%
            }
        %>

        <div style="width: 100%">

            <nav style="padding-top: 25px; padding-bottom: 15px;">
                <ul>
                    <li><a href="article?action=home"><h3>Trang chủ</h3></a></li>
                    <%
                        for (Category category : categories) {
                    %>
                    <li><a href="#"><h3><%= category.getCategory_name() %></h3></a>
                    </li>
                    <%
                        }
                    %>
                    <li><a href="article?action=add"><h3>Đăng bài</h3></a>
                    <li><a href="#">
                        <div class="hamburger-menu"></div>
                        <div class="hamburger-menu"></div>
                        <div class="hamburger-menu"></div>
                    </a>
                    </li>
                </ul>
            </nav>
        </div>
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
    <div class="comments-section">
        <h2 class="comments-title">Bình luận</h2>
        <%
            if (session.getAttribute("user") != null) {
                UserShow user = (UserShow) session.getAttribute("user");
        %>
        <!-- Form thêm bình luận -->
        <form class="comment-form" action="comment?action=add" method="post">
            <input type="hidden" name="article_id" value="<%= article.getId() %>">
            <input type="hidden" name="user_id" value="<%= user.getId()%>">
            <textarea name="content" class="comment-input" placeholder="Hãy viết bình luận của bạn..." required></textarea>
            <button type="submit" class="comment-submit">Đăng bình luận</button>
        </form>
        <% } else { %>
            <p class="comment-login">Đăng nhập để bình luận</p>
        <% } %>

        <!-- Danh sách các bình luận -->
        <div class="comments-list">
            <% if (comments == null || comments.isEmpty()) { %>
                <p class="no-comments">Chưa có bình luận! Hãy là người bình luận đầu tiên</p>
            <% } else { %>
            <% for (CommentShow comment : comments) { %>
            <div class="comment">
                <p class="comment-user">Người dùng <%= comment.getUser().getFullName() %> bình luận:</p>
                <p class="comment-text"><%= comment.getContent() %></p>
                <p class="comment-date"><%= comment.getCreated_at() %></p>
            </div>
            <% } %>
            <% }%>
        </div>
    </div>
</main>
</body>
</html>