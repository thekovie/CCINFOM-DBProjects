<%--
  Created by IntelliJ IDEA.
  User: johnn
  Date: 05/04/2023
  Time: 2:09 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, java.sql.*, assetmanagement.*" %>
<jsp:useBean id="asset" class="assetmanagement.assets" scope="session"/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Asset</title>
    <link rel="stylesheet" href="style.css">
    <link rel="icon" href="https://img.icons8.com/fluency/48/null/data-configuration.png" type="image/png">
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="container">
    <div class="center-forms">
        <a class="return-link" href="index.html">< Return to Menu</a>
        <h1 class="h1-welcome">Assets</h1>
        <h2>Update Assets</h2>

        <form action="update_asset.jsp">
            <label for="asset_select_label">Select Asset:</label><br>
            <select id="asset_select" name="asset_select">
                <%
                    assets a = new assets();
                    a.load_assets();
                    for (int i = 0; i < a.asset_selectList.size(); i++) {
                %>
                <option value="<%=a.asset_idList.get(i)%>"><%=a.asset_selectList.get(i)%></option>
                <%
                    }
                %>
            </select><br>
            <input type="submit" value="Submit">
        </form>
    </div>
    <div class="logo-right">
        <img src="https://img.icons8.com/cotton/350/null/petition.png" alt="HOA Logo">
    </div>
</div>
<footer>
    <p>© CCINFOM Group 7</p>
</footer>
</body>
</html>
