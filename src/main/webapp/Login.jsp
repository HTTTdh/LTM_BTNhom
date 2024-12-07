<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<style>
    body {
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    form {
        background-color: #ffffff;
        padding: 20px 30px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        width: 300px;
    }

    label {
        display: block;
        font-size: 16px;
        margin-bottom: 8px;
        color: #333;
    }

    input {
        width: 100%;
        padding: 8px 10px;
        margin-bottom: 16px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }
</style>
<body>
<form action="login" method="POST">
    <%
        if (request.getAttribute("errorMessage") != null) {
    %>
        <h3 style="color: red;"><%= request.getAttribute("errorMessage") %></h3>
    <%
        }
    %>
    <label>username: </label>
    <input type="text" name="username"/>

    <label>Password: </label>
    <input type="text" name="password"/>

    <button type="submit">OK</button>
    <button type="reset">Reset</button>
</form>

</body>
</html>