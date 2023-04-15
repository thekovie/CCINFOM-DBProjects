<%--
  Created by IntelliJ IDEA.
  User: johnn
  Date: 15/04/2023
  Time: 5:14 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, java.sql.*, assetmanagement.*" %>
<jsp:useBean id="asset" class="assetmanagement.assets" scope="session"/>
<jsp:useBean id="donate" class="assetmanagement.donation" scope="session"/>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Update Asset</title>
  <link rel="stylesheet" href="style.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
  <link rel="icon" href="https://img.icons8.com/fluency/48/null/data-configuration.png" type="image/png">
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="container">
  <div class="center-forms">
    <a class="return-link" href="index.html">< Return to Menu</a>
    <h1 class="h1-welcome">Assets</h1>
    <h2>Update Donation</h2>

    <form action="update_donation.jsp">
      <label for="donator_select">Select Donation:</label><br>
      <select id="donator_select" name="asset_select">
        <%
            donation d = new donation();
            d.load_donationlist();
          for (int i = 0; i < d.donation_list.size(); i++) {
        %>
        <option value="<%=d.donor_idList.get(i)%>"><%=d.donation_list.get(i)%></option>
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
