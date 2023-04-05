<%--
  Created by IntelliJ IDEA.
  User: johnn
  Date: 05/04/2023
  Time: 2:09 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Asset</title>
    <link rel="stylesheet" href="style.css">
    <link rel="icon" href="../resources/icons8-database-administrator-48.png" type="image/png">
</head>
<body>
<div class="container">
    <div class="center-forms">
        <a class="return-link" href="index.html">< Return to Menu</a>
        <h1 class="h1-welcome">Assets</h1>
        <h2>Update your Asset</h2>
        <p style="color: crimson;">*Fill up the required fields</p>

        <form>
            <label type="assetname" for="asset_name">Asset Name:</label><br>
            <select id="assets" name="asset_name">
                <option value="asset1">Asset 1</option>
                <option value="asset2">Asset 2</option>
                <option value="asset3">Asset 3</option>
                <option value="asset4">Asset 4</option>
                <option value="asset5">Asset 5</option>
            </select>
            <input type="button" value="🔎︎">
        </form>

        <form action="index.html">
            <h2>Details of the Asset</h2>
            <label type="text" for="asset_id">Asset ID:</label><br>
            <input type="text" id="asset_id" name="asset_id" placeholder="Asset ID" disabled><br>
            <label for="asset_name">Name:</label><br>
            <input type="text" id="asset_name" name="asset_name" placeholder="Asset Name" required>
            <br>
            <label for="asset_type">Asset Type:</label><br>
            <input type="text" id="asset_type" name="asset_type" placeholder="Asset Type" required>
            <br>
            <label for="asset_description">Description:</label><br>
            <textarea id="asset_description" name="asset_description" placeholder="Asset Description" rows="4" cols="50" required></textarea>
            <br>
            <input type="submit" value="Update">
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
