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
  <!-- <link rel="stylesheet" href="style.css"> -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
  <link rel="icon" href="https://img.icons8.com/fluency/48/null/data-configuration.png" type="image/png">
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
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #fde7c7;">
  <a class="navbar-brand" href="#"><img src="https://img.icons8.com/fluency/48/null/data-configuration.png" width="30" height="30" class="d-inline-block align-top" alt=""> HOA Management</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="index.html">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Assets
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="register_asset.jsp">Register an Asset</a>
          <a class="dropdown-item" href="search_asset.jsp">Update Assets</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="delete_asset.jsp" style="color: crimson;">Delete Asset</a>
        </div>
      </li>
      <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Donation
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <a class="dropdown-item" href="search_donation.jsp">Update Information</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="delete_donation.jsp" style="color: crimson;">Delete Donor</a>
          </div>
        </li>
      <li class="nav-item">
      <a class="nav-link" href="#">About Us</a>
      </li>
    </ul>
  </div>
</nav>
<form action="update_donation.jsp">
  <div class="container" style="margin-top: 70px; max-width: 1500px; margin-bottom: 80px">
  <div class="col">
    <div class="row">
      <div class="logo-left" style="padding: 100px;">
        <img class="img-fluid" src="https://img.icons8.com/cotton/350/null/petition.png" alt="HOA Logo">
      </div>
      <div class="col">
        <div class="form-group">
          <a class="btn btn-outline-info" href="index.html">< Return to Menu</a><br><br>
          <h1 class="h1-welcome">Donation</h1>
          <h2>Update Donation</h2>
            <label for="donator_select">Select Donation:</label><br>
            <select id="donator_select" class="form-control" name="asset_select">
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
            <input type="submit" class="btn" style="background-color: #3A98B9; color: white;" value="Submit">
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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
