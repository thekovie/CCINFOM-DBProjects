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
  <!-- <link rel="stylesheet" href="style.css"> -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
  <link rel="icon" href="https://img.icons8.com/fluency/48/null/data-configuration.png" type="image/png">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <style>
      body {
          font-family: Poppins, sans-serif;
          background-color: #FFF1DC;
      }
  </style>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%
  donation d = new donation();
  d.load_donors();
%>
<form action="process_del_donors.jsp">
<div class="container" style="margin-top: 70px; max-width: 1200px; margin-bottom: 80px">
  <div class="col">
    <div class="row">
      <div class="logo-left" style="padding: 100px;">
        <img class="img-fluid" src="https://img.icons8.com/cotton/350/null/petition.png" alt="HOA Logo">
      </div>
      <div class="col">
        <div class="form-group">
          <a class="btn btn-outline-info" href="index.html">< Return to Menu</a><br><br>
          <h1 class="h1-welcome">Donor</h1>
          <h2>Remove Donor</h2>
          
            <label for="donor_select">Select Donor:</label><br>
            <select id="donor_select" class="form-control" name="donor_select">
              <%

                for (int i = 0; i < d.donor_list.size(); i++) {
              %>
              <option value="<%=d.donor_list.get(i).donor_name%>"><%=d.donor_list.get(i).donor_name%></option>
              <%
                }
              %>
            </select><br>
            <label for="hoa_president">Select President:</label><br>
            <select id="hoa_president" class="form-control" name="hoa_president">
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
              <input type="submit" class="btn" value="Delete" style="background-color: crimson; color:white">
        </div>
      </div>
    </div>
  </div>
</form>
  <div class="fixed-bottom" style="background-color: #3A98B9;">
    <div class="container" style="padding-top: 15px;">
        <div class="row">
            <div class="col">
                <p class="text-center text-white">© 2023 HOA Management. CCINFOM S19 Group 7</p>
            </div>
        </div>
    </div>
  </div>
  <script>
    $(document).ready(function() {
      $('input[type="submit"]').click(function(e) {
        if (!confirm('All donor information will be deleted. Are you sure you want to delete this donor?')) {
          e.preventDefault();
        }
      });
    });
  </script>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>