<%--
  Created by IntelliJ IDEA.
  User: johnn
  Date: 08/04/2023
  Time: 11:14 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, java.sql.*, assetmanagement.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Record Donation</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <link rel="icon" href="https://img.icons8.com/fluency/48/null/data-configuration.png" type="image/png">
</head>
<body>
<jsp:useBean id="donate" class="assetmanagement.donation" scope="session"/>
<div class="container">
    <div class="center-forms">
        <a class="return-link" href="register_asset.jsp">< Return to Asset Registration</a>
        <h1 class="h1-welcome">Donation</h1>
        <h2>Record your Donation</h2>
        <p style="color: crimson;">*Fill up the required fields</p>
        <form action="#">
            <h3>Donor Information</h3>
            <label for="donor_name">Full Name:</label><br>
            <input type="text" id="donor_name" name="donor_name" placeholder="Full Name" maxlength="45" required><br>
            <label for="donor_address">Address:</label><br>
            <textarea id="donor_address" name="donor_address" placeholder="Home Address" rows="4" cols="50" maxlength="100" required></textarea><br>
            <h3>Donation Information</h3>
            <label for="donor_amount">Amount Donated:</label><br>
            <input type="number" id="donor_amount" name="donor_amount" placeholder="Amount Donated" min="0" required><br>
            <label for="donation_pic">Proof of Donation:</label><br>
            <input type="text" id="donation_pic" name="donation_pic" placeholder="Proof of Donation (Ex: image.jpeg)" maxlength="45" required><br>
            <label for="accepting_officer">Accepting Officer:</label><br>
            <select id="accepting_officer" name="accepting_officer">
                <%
                    donation d = new donation();
                    d.list_officers();

                    for (int i = 0; i < d.officer_list.size(); i++) {
                %>
                <option value="<%= d.officer_list.get(i).officer_id %>"><%= d.officer_list.get(i).officer_id %> - <%= d.officer_list.get(i).officer_name %></option>
                <%
                    }
                %>
            </select><br>
            <input type="submit" value="Submit">
            <input type="reset" value="Reset">
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