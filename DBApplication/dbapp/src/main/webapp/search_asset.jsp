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
<div class="container">
    <div class="center-forms">
        <a class="return-link" href="index.html">< Return to Menu</a>
        <h1 class="h1-welcome">Assets</h1>
        <h2>Modify Assets</h2>

        <form method="post" action="">
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
            <label for="select_transact">Select Transaction:</label><br>
            <label><input type="radio" id="update-button" name="action" value="update">Update</label><br>
            <label><input type="radio" id="delete-button" name="action" value="delete">Delete</label><br>
            <br>
            <input type="submit" value="Submit">
        </form>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            // When radio is select, modify form action but verify if the user wants to really delete it
            $(document).ready(function () {
                $('input[type="radio"]').click(function () {
                    if ($(this).attr("value") == "delete") {
                        if (confirm("Selecting the delete option will delete the asset from the database.\nAre you sure you want to select this option?")) {
                            $("form").attr("action", "delete_asset.jsp");
                        } else {
                            $("#delete-button").prop("checked", false);
                        }
                    }
                    if ($(this).attr("value") == "update") {
                        $("form").attr("action", "update_asset.jsp");
                    }
                });
            });
        </script>
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
