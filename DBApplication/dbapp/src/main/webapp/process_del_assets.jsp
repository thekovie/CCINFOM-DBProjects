<%--
  Created by IntelliJ IDEA.
  User: johnn
  Date: 08/04/2023
  Time: 5:32 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, java.sql.*, java.sql.Date, assetmanagement.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<html lang = "en">
<head>
    <title>Delete Asset</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <link rel="icon" href="https://img.icons8.com/fluency/48/null/data-configuration.png" type="image/png">
</head>
<body>
<jsp:useBean id="asset" class="assetmanagement.assets" scope="session"/>
<%
    int asset_id = Integer.parseInt(request.getParameter("asset_select"));

    asset.asset_id = asset_id;
    Boolean check = asset.delete_asset();
%>

<div class="container">
    <div class="center">
        <%
            if (check) {
        %>
        <h1 class="h1-welcome" style="color: rgba(28, 166, 25, 0.737);">Asset Deleted!</h1>
        <p>Asset deletion success!</p>
        <p><b>Deleted Asset ID: </b><%=asset.asset_id%></p>
        <%
        } else {
        %>
        <h1 class="h1-welcome" style="color: crimson;">Deletion Failed!</h1>
        <p>There was an error while deleting this asset. Please try again.</p>
        <p><b>Error Message:</b></p>
        <p style="font-size: small"><%=asset.error_msg%></p>
        <%
            }
        %>
        <a href=index.html><button >< Back to Main Menu</button></a>
    </div>
    <div class="logo-right">
        <%
            if (check) {
        %>
        <img src="https://img.icons8.com/officel/300/null/checked--v1.png" alt="Check Logo">
        <%
        } else {
        %>
        <img src="https://img.icons8.com/office/300/null/cancel.png" alt="Fail Logo">
        <%
            }
        %>
    </div>
</div>
<footer>
    <p>© CCINFOM Group 7</p>
</footer>
</body>
</html>
