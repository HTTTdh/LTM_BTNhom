<%@ page import="Model.Bean.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Bean.ArticleShow" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>New Article</title>
    <script src="https://cdn.jsdelivr.net/npm/interactjs/dist/interact.min.js"></script>
    <script src="./static/scripts/post.js"></script>
    <link rel="stylesheet" href="./static/css/header_footer_style.css">
    <link rel="stylesheet" href="./static/css/main_page.css">
    <link rel="stylesheet" href="./static/css/add_article.css">
</head>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
    ArticleShow articleShow = (ArticleShow) request.getAttribute("articleShow");
%>
<body>
<header class="header">
    <div class="header-content">
        <img src="/static/resources/logo.png" alt="Logo" class="logo">
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
            <button>
                <i class="fas fa-sign-in-alt"></i> Đăng nhập
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
            <li><a href="#"><h3>Đăng bài</h3></a>
            <li><a href="#">
                <div class="hamburger-menu"></div>
                <div class="hamburger-menu"></div>
                <div class="hamburger-menu"></div>
            </a>
            </li>
        </ul>
    </nav>
</header>

<div class="container">
    <% if (errorMessage != null) { %>
    <p style="color: red"><%= errorMessage %></p>
    <% } %>

    <div class="form-container">
        <h1>Cập nhật thông tin bài viết</h1>

        <form action="article?action=edit" method="POST">

            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" value="<%= articleShow.getTitle() %>" required>
            </div>

            <div class="form-group">
                <label for="category" id="select-category">Chuyên mục:</label>
                <select id="category" name="category" required>
                    <% for (Category category : categories) { %>
                    <option value="<%= category.name() %>" <%= category.name().equals(articleShow.getCategory()) ? "selected" : "" %>>
                        <%= category.getCategory_name() %>
                    </option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <div id="contentContainer">
                    <button type="button" onclick="" id="imagePickerButton">Chèn hình ảnh</button>
                    <div name="content" id="content"
                         class="content-editable" value="<%=articleShow.getContent()%>" required></div>
                </div>
            </div>

            <button type="submit" >Submit</button>
        </form>
    </div>

</div>
</body>
</html>
