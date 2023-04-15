<%--
  Created by IntelliJ IDEA.
  User: johnn
  Date: 15/04/2023
  Time: 11:27 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, java.sql.*, assetmanagement.*" %>
<jsp:useBean id="donate" class="assetmanagement.donation" scope="session"/>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Remove Donor</title>
  <link rel="stylesheet" href="style.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
  <link rel="icon" href="https://img.icons8.com/fluency/48/null/data-configuration.png" type="image/png">
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%
  donation d = new donation();
  d.load_donors();
%>
<div class="container">
  <div class="center-forms">
    <a class="return-link" href="index.html">< Return to Menu</a>
    <h1 class="h1-welcome">Donor</h1>
    <h2>Remove Donor</h2>
    <form action="process_del_donors.jsp">
      <label for="donor_select">Select Donor:</label><br>
      <select id="donor_select" name="donor_select">
        <%

          for (int i = 0; i < d.donor_list.size(); i++) {
        %>
        <option value="<%=d.donor_list.get(i).donor_name%>"><%=d.donor_list.get(i).donor_name%></option>
        <%
          }
        %>
      </select><br>
      <label for="hoa_president">Select President:</label><br>
      <select id="hoa_president" name="hoa_president">
      <%
        donation o = new donation();
        o.load_presidents();

        for (int i = 0; i < o.officer_list.size(); i++) {
      %>
        <option value="<%=o.officer_list.get(i).officer_id%>"><%=o.officer_list.get(i).officer_name%></option>
        <%
            }
        %>
        </select><br>
      <input type="submit" value="Delete" style="background-color: crimson">
    </form>
    <script>
      $(document).ready(function() {
        $('input[type="submit"]').click(function(e) {
          if (!confirm('All donor information will be deleted. Are you sure you want to delete this donor?')) {
            e.preventDefault();
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