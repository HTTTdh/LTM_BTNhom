<%@ page import="Model.Bean.Category" %>
<%@ page import="java.util.ArrayList" %><%--
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
    <script src="../static/scripts/post.js"></script>
    <link rel="stylesheet" href="../static/css/header_footer.css">
    <link rel="stylesheet" href="../static/css/PageHomeStyle.css">
</head>
<style>
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
  }

  .container {
    display: flex;
    max-width: 1200px;
      margin: 0px 80px;
    padding: 20px;
    gap: 20px; /* Khoảng cách giữa form và các bài báo */
    align-items: flex-start; /* Căn chỉnh các mục con theo chiều dọc */
  }

  .form-container {
    flex: 2; /* Form sẽ chiếm 2 phần */
  }

  .medical-articles {
    flex: 1; /* Các bài báo sẽ chiếm 1 phần */
    margin-top: 100px; /* Đẩy phần bài báo xuống để ngang hàng với nút Chèn hình ảnh */
  }

  .medical-articles h2 {
    margin-top: 0;
    color: #2d6fb6; /* Màu xanh dương cho tiêu đề */
  }

  .medical-article {
    display: flex;
    align-items: flex-start;
    margin-bottom: 20px;
  }

  .medical-article img {
    max-width: 100px;
    margin-right: 10px;
  }

  .article-content {
    max-width: calc(100% - 110px);
  }

  .article-content h3 {
    margin: 0;
    font-size: 1.1em;
  }

  .article-content p {
    margin: 5px 0 0;
    font-size: 0.9em;
    color: #555;
  }
  h1 {
      text-align: center;
      color: #2d6fb6; /* Màu xanh dương cho tiêu đề */
  }

  form {
      margin-bottom: 20px;
  }

  .form-group {
      margin-bottom: 10px;
  }

  label {
      display: block;
      color: #2d6fb6; /* Màu xanh dương cho tiêu đề */
  }

  input[type="text"],
  input[type="date"],
  textarea,
  input[type="file"] {
      width: 100%;
      padding: 8px;
      margin-top: 3px;
      margin-bottom: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
  }

  button[type="submit"],
  button[id="imagePickerButton"]
  {
      background-color: #4CAF50;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
  }

  button[type="submit"]:hover,
  button[id="imagePickerButton"]:hover {
      background-color: #45a049;
  }

  #contentContainer {
      position: relative;
  }

  #imagePickerButton {
      display: block;
      margin-bottom: 5px;
  }

  .content-editable {
      width: 100%;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
      min-height: 500px; /* Tăng chiều cao tối thiểu của trường content */
      overflow-y: auto;
  }

  select[id="select-category"] {
      width: 100%;
      padding: 10px 15px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 5px;
      background-color: #f9f9f9;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      outline: none;
      transition: border-color 0.3s, box-shadow 0.3s;
  }

  select:focus {
      border-color: #007bff;
      box-shadow: 0 0 8px rgba(0, 123, 255, 0.25);
      background-color: #fff;
  }

</style>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
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
