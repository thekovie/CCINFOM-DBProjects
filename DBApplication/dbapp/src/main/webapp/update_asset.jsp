<%--
  Created by IntelliJ IDEA.
  User: kovie
  Date: 4/7/23
  Time: 3:16 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, java.sql.*, assetmanagement.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Asset</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <link rel="icon" href="https://img.icons8.com/fluency/48/null/data-configuration.png" type="image/png">
</head>
<body>
<jsp:useBean id="asset" class="assetmanagement.assets" scope="session"/>
<%
    assets a = new assets();
    a.load_assetinfo(request.getParameter("asset_select"));
%>
<div class="container">
    <div class="center-forms">
        <a class="return-link" href="search_asset.jsp">< Return to Select Asset</a>
        <h1 class="h1-welcome">Assets</h1>
        <h2>Update your Asset</h2>
        <%
            if (a.isDisposed()) {
        %>
        <p style="color: crimson;"><b>This asset is already disposed and <u>cannot be modified</u>.</b></p>
        <%
            } else {
        %>
        <p style="color: crimson;">*Fill up the required fields</p>
        <%
            }
        %>
        <form action="process_upd_assets.jsp">
            <label for="asset_id">Asset ID:</label><br>
            <input type="number" id="asset_id" name="asset_id" placeholder="Asset ID" maxlength="45" value="<%=a.asset_id%>" <% if (a.isDisposed()) { %> disabled <% } else { %> readonly <% } %>><br>
            <label for="asset_name">Name:</label><br>
            <input type="text" id="asset_name" name="asset_name" placeholder="Asset Name" maxlength="45" value="<%=a.asset_name%>" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><br>
            <label for="asset_type">Asset Type:</label><br>
            <select id="asset_type" name="asset_type" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>>
                <option value="property" <% if (a.asset_type.equals("property")) {%> selected <% } %>>Property</option>
                <option value="equipment" <% if (a.asset_type.equals("equipment")) {%> selected <% } %>>Equipment</option>
                <option value="fnf" <% if (a.asset_type.equals("fnf")) {%> selected <% } %>>Furnitures & Fixtures</option>
                <option value="Others" <% if (a.asset_type.equals("Others")) {%> selected <% } %>>Others</option>
            </select><br>
            <label for="asset_description">Description:</label><br>
            <textarea id="asset_description" name="asset_description" placeholder="Asset Description" rows="4" cols="50" maxlength="45" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><%=a.asset_description%></textarea><br>
            <label for="acquisition_date">Acquisition Date:</label><br>
            <input type="date" id="acquisition_date" name="asset_date" value="<%=a.asset_acq_date%>" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><br>
            <labal for="rent_status">Rent Status:</labal><br>
            <select id="rent_status" name="rent_status" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>>
                <option value="for_rent" <% if (a.asset_rent_status.equals("rented")) {%> selected <% } %>>For Rent</option>
                <option value="not_forrent" <% if (a.asset_rent_status.equals("not_forrent")) {%> selected <% } %>>Not For Rent</option>
            </select><br>
            <label for="asset_value">Value:</label><br>
            <input type="number" id="asset_value" name="asset_value" placeholder="Asset Value" value="<%=a.asset_value%>" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><br>
            <label for="asset_status">Status:</label><br>
            <select id="asset_status" name="asset_status" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>>
                <option value="working" <% if (a.asset_status.equals("working")) {%> selected <% } %>>Working</option>
                <option value="deteriorated" <% if (a.asset_status.equals("deteriorated")) {%> selected <% } %>>Deteriorated</option>
                <option value="for_repair" <% if (a.asset_status.equals("for_repair")) {%> selected <% } %>>For Repair</option>
                <option value="for_disposal" <% if (a.asset_status.equals("for_disposal")) {%> selected <% } %>>For Disposal</option>
                <option value="disposed" <% if (a.asset_status.equals("disposed")) {%> selected <% } %> <% if (!a.canDispose()) { %> disabled <% } %>>Disposed</option>
            </select><br>
            <label for="asset_loc_long">Location (Longitude):</label><br>
            <input type="text" id="asset_loc_long" name="asset_loc_long" placeholder="Asset Location (Longitude)" maxlength="8" value="<%=a.asset_longitude%>" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><br>
            <label for="asset_loc_lat">Location (Latitude):</label><br>
            <input type="text" id="asset_loc_lat" name="asset_loc_lat" placeholder="Asset Location (Latitude)" maxlength="8" value="<%=a.asset_latitude%>" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><br>

            <label for="hoa_name">Select HOA:</label><br>
            <jsp:useBean id="hoa_select" class="assetmanagement.assets" scope="session"/>
            <select id="hoa_name" name="hoa_name" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>>
                <%
                    assets b = new assets();
                    b.load_hoalist();
                    for (String s : b.asset_HoaList) {
                %>
                <option value="<%=s%>" <% if (a.asset_hoa.equals(s)) {%> selected <% } %>> <%=s%> </option>
                <%
                    }
                %>
            </select><br>
            <label for="select_room">Select Room:</label><br>
            <jsp:useBean id="room_select" class="assetmanagement.assets" scope="session"/>
            <select id="select_room" name="select_room" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>>
                <option value="null" <% if (a.asset_room_id.equals("null")) {%> selected <% } %>>No room selected</option>
                <%
                    assets c = new assets();
                    c.load_rooms();
                    for (int i = 0; i < c.asset_selectList.size(); i++) {
                %>
                <option value="<%=c.asset_idList.get(i)%>" <% if (a.asset_room_id.equals(c.asset_idList.get(i))) {%> selected <% } %>><%=c.asset_selectList.get(i)%></option>
                <%
                    }
                %>
            </select><br>
            <%
                if (!a.isDisposed()) {
            %>
            <input type="submit" value="Submit">
            <input type="reset" value="Reset">
            <%
                }
            %>
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

