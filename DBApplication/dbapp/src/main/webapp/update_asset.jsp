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
        assets a = new assets();
        a.load_assetinfo(request.getParameter("asset_select"));
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <div class="container" style="margin-top: 70px; max-width: 1500px; margin-bottom: 80px">
        <form method="post" id="reg_asset_form" action="process_upd_assets.jsp">
        <div class="col">
            <div class="row">
                <div class="logo-left" style="padding: 100px;">
                    <img class="img-fluid" src="https://img.icons8.com/cotton/350/null/petition.png" alt="HOA Logo">
                </div>
                <div class="col">
                    <div class="form-group">
                        <a class="btn btn-outline-info" href="search_asset.jsp">< Return to Asset Select</a><br><br>
                        <h1>Assets</h1>
                        <h2>Update Asset</h2>
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
                        <label for="asset_id">Asset ID:</label><br>
                        <input type="number" class="form-control" id="asset_id" name="asset_id" placeholder="Asset ID" maxlength="45" value="<%=a.asset_id%>" <% if (a.isDisposed()) { %> disabled <% } else { %> readonly <% } %>><br>
                        </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="asset_name">Name:</label><br>
                                <input type="text" class="form-control" id="asset_name" name="asset_name" placeholder="Asset Name" maxlength="45" value="<%=a.asset_name%>" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><br>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="asset_type">Asset Type:</label>
                                <select id="asset_type" class="form-control" name="asset_type" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>>
                                    <option value="property" <% if (a.asset_type.equals("property")) {%> selected <% } %>>Property</option>
                                    <option value="equipment" <% if (a.asset_type.equals("equipment")) {%> selected <% } %>>Equipment</option>
                                    <option value="fnf" <% if (a.asset_type.equals("fnf")) {%> selected <% } %>>Furnitures & Fixtures</option>
                                    <option value="Others" <% if (a.asset_type.equals("Others")) {%> selected <% } %>>Others</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="asset_description">Description:</label><br>
                                <textarea id="asset_description" class="form-control" name="asset_description" placeholder="Asset Description" rows="4" cols="50" maxlength="45" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><%=a.asset_description%></textarea><br>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="acquisition_date">Acquisition Date:</label><br>
                                    <input type="date" class="form-control" id="acquisition_date" name="asset_date" value="<%=a.asset_acq_date%>" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><br>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for ="rent_status">Rent Status:</label><br>
                                    <select id="rent_status" class="form-control" name="rent_status" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>>
                                        <option value="for_rent" <% if (a.asset_rent_status.equals("rented")) {%> selected <% } %>>For Rent</option>
                                        <option value="not_forrent" <% if (a.asset_rent_status.equals("not_forrent")) {%> selected <% } %>>Not For Rent</option>
                                    </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="asset_value">Value:</label><br>
                                    <input type="number" class="form-control" id="asset_value" name="asset_value" placeholder="Asset Value" min="0" value="<%=a.asset_value%>" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><br>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="asset_status">Status:</label><br>
                                    <select class="form-control" id="asset_status" name="asset_status" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>>
                                        <option value="working" <% if (a.asset_status.equals("working")) {%> selected <% } %>>Working</option>
                                        <option value="deteriorated" <% if (a.asset_status.equals("deteriorated")) {%> selected <% } %>>Deteriorated</option>
                                        <option value="for_repair" <% if (a.asset_status.equals("for_repair")) {%> selected <% } %>>For Repair</option>
                                        <option value="for_disposal" <% if (a.asset_status.equals("for_disposal")) {%> selected <% } %>>For Disposal</option>
                                        <option value="disposed" <% if (a.asset_status.equals("disposed")) {%> selected <% } %> <% if (!a.canDispose()) { %> disabled <% } %>>Disposed</option>
                                    </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="asset_loc_long">Location (Longitude):</label><br>
                                    <input type="text" class="form-control" id="asset_loc_long" name="asset_loc_long" placeholder="Asset Location (Longitude)" maxlength="8" value="<%=a.asset_longitude%>" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><br>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="asset_loc_lat">Location (Latitude):</label><br>
                                    <input type="text" class="form-control" id="asset_loc_lat" name="asset_loc_lat" placeholder="Asset Location (Latitude)" maxlength="8" value="<%=a.asset_latitude%>" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>><br>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="hoa_name">Select HOA:</label><br>
                                    <select id="hoa_name" class="form-control" name="hoa_name" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>>
                                        <%
                                            assets b = new assets();
                                            b.load_hoalist();
                                            for (String s : b.asset_HoaList) {
                                        %>
                                        <option value="<%=s%>" <% if (a.asset_hoa.equals(s)) {%> selected <% } %>><%=s%></option>
                                        <%
                                            }
                                        %>
                                    </select><br>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="select_room">Select Room:</label><br>
                                    <select id="select_room" class="form-control" name="select_room" <% if (a.isDisposed()) { %> disabled <% } else { %> required <% } %>>
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
                                </div>
                            </div>
                            <%
                                if (!a.isDisposed()) {
                            %>
                            <input type="submit" class="btn" style="background-color: #3A98B9; color: white;" value="Submit">
                            <input type="reset" class="btn" style="background-color: white;" value="Reset">
                            <%
                               }
                            %>
                    </div>
                </div>
            </div>
    </form>
    </div>
    <div class="bottom" style="background-color: #3A98B9;">
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


