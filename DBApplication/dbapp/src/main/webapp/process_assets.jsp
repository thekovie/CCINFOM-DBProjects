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
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <link rel="icon" href="https://img.icons8.com/fluency/48/null/data-configuration.png" type="image/png">
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

        Boolean rentStatusBool = false;
        if (rentStatus.equals("for_rent")) {
            rentStatusBool = true;
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

        Boolean check = asset.register_asset();
    %>

    <div class="container">
        <div class="center">
          <%
              if (check) {
          %>
          <h1 class="h1-welcome" style="color: rgba(28, 166, 25, 0.737);">Registration Successful!</h1>
          <p>Your registration process is complete!</p>
          <p><b>Registered Asset ID: </b><%=asset.asset_id%></p>
          <%
              } else {
          %>
          <h1 class="h1-welcome" style="color: crimson;">Registration Unsuccessful!</h1>
          <p>There was an error with your registration process. Please try again.</p>
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