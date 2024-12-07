<%@ page import="Model.Bean.Article" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Bean.ArticleShow" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

</head>
<%
  List<ArticleShow> list = (List<ArticleShow>) request.getAttribute("listArticles");
%>
<script>
  function confirmDelete(id) {
    if (confirm('Bạn có chắc chắc muốn xóa bài báo này?')) {
      window.location.href = "admin?action=deleteArticle&idArticles=" + id;
    }
  }
</script>
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
        <li><a href="admin?action=home">Trang chủ</a> </li>
        <li><a href="admin?action=listArticle"><i class="fas fa-newspaper"></i> Danh sách bài báo</a></li>
        <li><a href="admin?action=listUser"><i class="fas fa-users"></i> Danh sách người dùng</a></li>
        <li><a href="#settings"><i class="fas fa-cog"></i> Cài đặt </a></li>
        <li><a href="#logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất </a></li>
      </ul>
    </nav>
  </aside>

  <main class="main-content">
    <h1>Danh sách bài báo</h1>
    <div class="actions">
      <input type="text" placeholder="Search articles..." class="search-bar">
      <select class="filter">
        <option value="">All</option>
        <option value="approved">Approved</option>
        <option value="pending">Pending</option>
      </select>
    </div>
    <table class="data-table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Content</th>
        <th>Category</th>
        <th>Date</th>
        <th>Author</th>
        <th>Edit</th>
        <th>Delete</th>
      </tr>
      </thead>
      <tbody>
      <%
        for(int i =0;i<list.size();i++){
      %>
      <tr>
        <td><%=list.get(i).getId()%></td>
        <td><%=list.get(i).getTitle()%></td>
        <td><%=list.get(i).getContent()%></td>
        <td><%=list.get(i).getCategory()%></td>
        <td><%=list.get(i).getCreated_at()%></td>
        <td><%=list.get(i).getAuthor()%></td>
        <td>
          <button class="edit-btn"><a href="admin?action=editArticle&idArticles=<%=list.get(i).getId()%>">Edit</a></button>

        </td>
        <td><button class="delete-btn" onclick="confirmDelete(<%=list.get(i).getId()%>)">Delete</button></td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </main>
</div>
</body>
</html>
