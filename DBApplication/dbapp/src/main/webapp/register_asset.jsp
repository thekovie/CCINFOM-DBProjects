<%--
  Created by IntelliJ IDEA.
  User: johnn
  Date: 06/04/2023
  Time: 5:17 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, java.sql.*, assetmanagement.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register Asset</title>
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
            <h2>Register Asset</h2>
            <p style="color: crimson;">*Fill up the required fields</p>
            <form method="post" id="reg_asset_form" action="process_assets.jsp">
                <label for="reg_type">Is this a donation?</label><br>
                <label><input type="checkbox" name="donation-check" id="donation_checkbox">Yes, this is a donation.</label><br><br>
                <label for="asset_name">Name:</label><br>
                <input type="text" id="asset_name" name="asset_name" placeholder="Asset Name" maxlength="45" required><br>
                <label for="asset_type">Asset Type:</label><br>
                <select id="asset_type" name="asset_type" required>
                    <option value="property">Property</option>
                    <option value="equipment">Equipment</option>
                    <option value="fnf">Furnitures & Fixtures</option>
                    <option value="Others">Others</option>
                </select><br>
                <label for="asset_description">Description:</label><br>
                <textarea id="asset_description" name="asset_description" placeholder="Asset Description" rows="4" cols="50" maxlength="45" required></textarea><br>
                <label for="acquisition_date">Acquisition Date:</label><br>
                <input type="date" id="acquisition_date" name="asset_date" required><br>
                <label for ="rent_status">Rent Status:</label><br>
                <select id="rent_status" name="rent_status" required>
                    <option value="for_rent">For Rent</option>
                    <option value="not_forrent">Not For Rent</option>
                </select><br>
                <label for="asset_value">Value:</label><br>
                <input type="number" id="asset_value" name="asset_value" placeholder="Asset Value" min="0" required><br>
                <label for="asset_status">Status:</label><br>
                <select id="asset_status" name="asset_status" required>
                    <option value="working">Working</option>
                    <option value="deteriorated" disabled>Deteriorated</option>
                    <option value="for_repair" disabled>For Repair</option>
                    <option value="for_disposal" disabled>For Disposal</option>
                </select><br>
                <label for="asset_loc_long">Location (Longitude):</label><br>
                <input type="text" id="asset_loc_long" name="asset_loc_long" placeholder="Asset Location (Longitude)" maxlength="8" required><br>
                <label for="asset_loc_lat">Location (Latitude):</label><br>
                <input type="text" id="asset_loc_lat" name="asset_loc_lat" placeholder="Asset Location (Latitude)" maxlength="8" required><br>

                <label for="hoa_name">Select HOA:</label><br>
                <jsp:useBean id="hoa_select" class="assetmanagement.assets" scope="session"/>
                <select id="hoa_name" name="hoa_name" required>
                    <%
                        assets a = new assets();
                        a.load_hoalist();
                        for (String s : a.asset_HoaList) {
                    %>
                    <option value="<%=s%>"><%=s%></option>
                    <%
                        }
                    %>
                </select><br>
                <label for="select_room">Select Room:</label><br>
                <jsp:useBean id="room_select" class="assetmanagement.assets" scope="session"/>
                <select id="select_room" name="select_room">
                    <option value="null">No room selected</option>
                    <%
                        assets b = new assets();
                        b.load_rooms();
                        for (int i = 0; i < b.asset_selectList.size(); i++) {
                    %>
                    <option value="<%=b.asset_idList.get(i)%>"><%=b.asset_selectList.get(i)%></option>
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
