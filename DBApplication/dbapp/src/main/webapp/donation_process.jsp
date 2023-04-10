<%--
  Created by IntelliJ IDEA.
  User: johnn
  Date: 10/04/2023
  Time: 11:36 am
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
<jsp:useBean id="donate" class="assetmanagement.donation" scope="session"/>
<%
    String donorName = request.getParameter("donor_name");
    String donorAddress = request.getParameter("donor_address");
    double donorAmount = Double.parseDouble(request.getParameter("donation_amount"));
    String acceptingOfficer = request.getParameter("accepting_officer");
    String[] donationPics = request.getParameterValues("donation_pics[]");


    donate.donor_name = donorName;
    donate.donor_address = donorAddress;
    donate.donation_amount = donorAmount;
    donate.accepting_officer = acceptingOfficer;
    donate.donation_pics.addAll(Arrays.asList(donationPics));



    Boolean check = donate.register_donation();
%>

<div class="container">
    <div class="center">
        <%
            if (check) {
        %>
        <h1 class="h1-welcome" style="color: rgba(28, 166, 25, 0.737);">Registration Successful!</h1>
        <p>Your registration process is complete!</p>
        <p><b>Registered Asset ID: </b><%=assets.asset_id%></p>
        <%
        } else {
        %>
        <h1 class="h1-welcome" style="color: crimson;">Registration Unsuccessful!</h1>
        <p>There was an error with your registration process. Please try again.</p>
        <p><b>Error Message:</b></p>
        <p style="font-size: small"><%=assets.error_msg%></p>
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
