<%@ page import="Model.Bean.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Bean.UserShow" %><%--
  Created by IntelliJ IDEA.
  User: chauthi
  Date: 06/12/2024
  Time: 23:34
  To change this template use File | Settings | File Templates.
--%>
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
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.getElementById('articleForm');

        form.addEventListener('submit', function (event) {
            event.preventDefault(); // Ngăn submit mặc định

            const title = document.getElementById('title').value;
            const category = document.getElementById('category').value;
            const content = document.getElementById('content').innerHTML;

            // Tạo body dưới dạng x-www-form-urlencoded
            const formData = new URLSearchParams();
            formData.append('title', title);
            formData.append('category', category);
            formData.append('content', content);

            fetch('article?action=add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: formData.toString()
            })
                .then(response => {
                    if (response.redirected) {
                        // Nếu server gửi redirect, tự động chuyển hướng
                        window.location.href = response.url;
                    } else {
                        return response.text(); // Xử lý phản hồi khác (nếu có)
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    });
</script>
<div class="container">
    <% if (errorMessage != null) { %>
    <p style="color: red"><%= errorMessage %></p>
    <% } %>

  <div class="form-container">
    <h1>Đăng bài viết mới</h1>

    <form id="articleForm">

      <div class="form-group">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title">
      </div>

        <div class="form-group">
            <label for="category" id="select-category">Chuyên mục:</label>
            <select id="category" name="category" required>
                <%
                    for (Category category : categories) {
                %>
                <option value="<%= category.name() %>"><%= category.getCategory_name() %></option>
                <%
                    }
                    %>
            </select>
        </div>

      <div class="form-group">
        <div id="contentContainer">
          <button type="button" onclick="openImagePicker()" id="imagePickerButton">Chèn hình ảnh</button>
            <div name="content" id="content" contenteditable="true" class="content-editable" required></div>
        </div>
      </div>

        <input type="hidden" id="contentInput" name="content">
      <button type="submit" onclick="getContent()" >Submit</button>
    </form>
  </div>

</div>
</body>
</html>
