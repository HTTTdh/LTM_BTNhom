<%@ page import="Model.Bean.Article" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Bean.User" %>
<%@ page import="Model.Bean.UserShow" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="./admin/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<%
    List<UserShow> list = (List<UserShow>) request.getAttribute("listUsers");
%>
<script>
    function confirmDelete(id) {
        if (confirm('Bạn có chắc chắc muốn xóa bài báo này?')) {
            window.location.href = "admin?action=deleteUser&idUser=" + id;
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
                <li><a href="?action=home">Trang chủ</a> </li>
                <li><a href="?action=listArticle"><i class="fas fa-newspaper"></i> Danh sách bài báo</a></li>
                <li><a href="?action=listUser"><i class="fas fa-users"></i> Danh sách người dùng</a></li>
                <li><a href="#settings"><i class="fas fa-cog"></i> Cài đặt </a></li>
                <li><a href="#logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất </a></li>
            </ul>
        </nav>
    </aside>

    <main class="main-content">
        <h1>Danh sách người dùng</h1>
        <table class="data-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Fullname</th>
                <th>Username</th>
                <th>Role</th>
                <th>is_Active</th>
                <th>Delete</th>
            </tr>
            </thead>
            <tbody>
            <%
                for(int i =0;i<list.size();i++){
            %>
            <tr>
                <td><%=list.get(i).getId()%></td>
                <td><%=list.get(i).getFullName()%></td>
                <td><%=list.get(i).getUsername()%></td>
                <td><%=list.get(i).getNameRole()%></td>
                <td><%=list.get(i).getIs_Active()%></td>
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
