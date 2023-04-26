<%--
  Created by IntelliJ IDEA.
  User: johnn
  Date: 06/04/2023
  Time: 10:46 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, java.sql.*, java.sql.Date, assetmanagement.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<html lang = "en">
<head>
    <title>Register Asset</title>
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
    <jsp:useBean id="asset" class="assetmanagement.assets" scope="session"/>
    <%
        String assetName = request.getParameter("asset_name");
        String assetType = request.getParameter("asset_type");
        String assetDesc = request.getParameter("asset_description");
        String acqDateString = request.getParameter("asset_date");
        String rentStatus = request.getParameter("rent_status");
        double assetValue = Double.parseDouble(request.getParameter("asset_value"));
        String assetStatus = request.getParameter("asset_status");
        double loc_long = Double.parseDouble(request.getParameter("asset_loc_long"));
        double loc_lat = Double.parseDouble(request.getParameter("asset_loc_lat"));
        String hoaName = request.getParameter("hoa_name");
        String roomName = request.getParameter("select_room");
        String donateCheck = request.getParameter("donation-check");

        System.out.println(donateCheck);

        Boolean rentStatusBool = false;
        if (rentStatus.equals("for_rent")) {
            rentStatusBool = true;
        }

        Boolean donateStatusBool = false;
        if (donateCheck != null) {
            donateStatusBool = true;
        }


        switch(assetType) {
            case "property": assetType = "P"; break;
            case "equipment": assetType = "E"; break;
            case "fnf": assetType = "F"; break;
            default: assetType = "O"; break;
        }

        switch(assetStatus) {
            case "working": assetStatus = "W"; break;
            case "deteriorated": assetStatus = "D"; break;
            case "for_repair": assetStatus = "P"; break;
            case "for_disposal": assetStatus = "S"; break;
            case "disposed": assetStatus = "X"; break;
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date parsedDate = dateFormat.parse(acqDateString);
        java.sql.Date acqDate = new Date(parsedDate.getTime());

        asset.asset_name = assetName;
        asset.asset_type = assetType;
        asset.asset_description = assetDesc;
        asset.asset_acq_date = acqDate;
        asset.asset_rent = rentStatusBool;
        asset.asset_value = assetValue;
        asset.asset_status = assetStatus;
        asset.asset_longitude = loc_long;
        asset.asset_latitude = loc_lat;
        asset.asset_hoa = hoaName;
        asset.asset_room_id = roomName;

        Boolean check = false;
        if (donateStatusBool) {
            response.sendRedirect("record_donation.jsp");
        } else {
             check = asset.register_asset();
        }
    %>
    <nav class="navbar navbar-expand-lg navbar-light" style="background-color: #fde7c7;">
        <a class="navbar-brand" href="index.html"><img src="https://img.icons8.com/fluency/48/null/data-configuration.png" width="30" height="30" class="d-inline-block align-top" alt=""> HOA Management</a>
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
      <div class="container" style="margin-top: 100px; margin-bottom: 100px; max-width: 1200px;">
        <div class="col">
            <div class="row">
                <div class="logo-left">
                    <%
                        if (check) {
                    %>
                    <img src="https://img.icons8.com/officel/300/null/checked--v1.png" class="img-fluid" style="padding: 100px;" alt="Check Logo">
                    <%
                        } else {
                    %>
                    <img src="https://img.icons8.com/office/300/null/cancel.png" class="img-fluid" style="padding: 100px;" alt="Fail Logo">
                    <%
                        }
                    %>
                </div>
                <div class="col" style="margin-top: 100px;">
                    <%
                        if (check) {
                    %>
                    <h1 style="color: rgba(28, 166, 25, 0.737);">Registration Successful!</h1>
                    <p>Your registration process is complete!</p>
                    <p><b>Registered Asset ID: </b><%=asset.asset_id%></p>
                    <%
                        } else {
                    %>
                    <h1 style="color: crimson;">Registration Unsuccessful!</h1>
                    <p>There was an error with your registration process. Please try again.</p>
                        <p><b>Error Message:</b></p>
                        <p style="font-size: small"><%=asset.error_msg%></p>
                    <%
                        }
                    %>
                        <a href=index.html><button class="btn btn-outline-info">< Back to Main Menu</button></a>
                </div>
            </div>
        </div>
    </div>
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