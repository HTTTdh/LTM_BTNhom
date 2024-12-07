<%@ page import="Model.Bean.Article" %>
<%@ page import="Model.DAO.ArticleDAO" %>
<%@ page import="Model.Bean.ArticleShow" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sửa thông tin bài báo</title>
  <link rel="stylesheet" href="edit.css">
</head>
<body>
<div class="admin-dashboard">
  <header class="header">
    <div class="logo">Trang Admin</div>
    <div class="user-info">
      <span>Welcome, Admin</span>
      <button class="logout-btn">Logout</button>
    </div>
  </header>

  <aside class="sidebar">
    <nav>
      <ul>
        <li><a href="admin?action=home">Trang chủ</a></li>
        <li><a href="admin?action=listArticle">Danh sách bài báo</a></li>
        <li><a href="admin?action=listUser">Danh sách người dùng</a></li>
        <li><a href="#settings">Cài đặt</a></li>
        <li><a href="#logout">Đăng xuất</a></li>
      </ul>
    </nav>
  </aside>

  <main class="main-content">
    <h1>Sửa thông tin bài báo</h1>

    <%
     ArticleShow article = (ArticleShow) request.getAttribute("articles");
    %>

    <form action="admin?action=editArticle" method="post">
      <label for="id">Id:</label>
      <input type="text" id="id" name="id" value="<%= article.getId() %>" readonly>

      <label for="title">Title:</label>
      <input type="text" id="title" name="title" value="<%= article.getTitle() %>" required>

      <label for="content">Content:</label>
      <textarea id="content" name="content" required><%= article.getContent() %></textarea>

      <label for="category">Category:</label>
      <input type="text" id="category" name="category" value="<%= article.getCategory() %>" required>

      <label for="created_at">Created At:</label>
      <input type="text" id="created_at" name="created_at" value="<%= article.getCreated_at() %>" disabled>

      <label for="author">Author:</label>
      <input type="text" id="author" name="author" value="<%= article.getAuthor() %>" disabled>
      <button type="submit" class="save-btn">Save Changes</button>
    </form>
  </main>
</div>
</body>
</html>
