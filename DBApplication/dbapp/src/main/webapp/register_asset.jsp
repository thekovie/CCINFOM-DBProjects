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
        <form method="post" id="reg_asset_form" action="process_assets.jsp">
        <div class="col">
            <div class="row">
                <div class="logo-left" style="padding: 100px;">
                    <img class="img-fluid" src="https://img.icons8.com/cotton/350/null/petition.png" alt="HOA Logo">
                </div>
                <div class="col">
                    <div class="form-group">
                        <a class="btn btn-outline-info" href="index.html">< Return to Menu</a><br><br>
                        <h1>Assets</h1>
                        <h2>Register Asset</h2>
                        <p style="color: crimson;">*Fill up the required fields</p><br>
                            <label for="reg_type">Is this a donation?</label><br>
                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" name="donation-check" id="donation_checkbox"><label class="form-check-label" for="donation_checkbox">Yes, this is a donation.</label><br><br>
                            </div>
                        </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="asset_name">Name:</label><br>
                                <input type="text" class="form-control" id="asset_name" name="asset_name" placeholder="Asset Name" maxlength="45" required><br>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="asset_type">Asset Type:</label>
                                <select id="asset_type" class="form-control" name="asset_type" required>
                                    <option value="property">Property</option>
                                    <option value="equipment">Equipment</option>
                                    <option value="fnf">Furnitures & Fixtures</option>
                                    <option value="Others">Others</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="asset_description">Description:</label><br>
                                <textarea id="asset_description" class="form-control" name="asset_description" placeholder="Asset Description" rows="4" cols="50" maxlength="45" required></textarea><br>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="acquisition_date">Acquisition Date:</label><br>
                                    <input type="date" class="form-control" id="acquisition_date" name="asset_date" required><br>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for ="rent_status">Rent Status:</label><br>
                                    <select id="rent_status" class="form-control" name="rent_status" required>
                                        <option value="for_rent">For Rent</option>
                                        <option value="not_forrent">Not For Rent</option>
                                    </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="asset_value">Value:</label><br>
                                    <input type="number" class="form-control" id="asset_value" name="asset_value" placeholder="Asset Value" min="0" required><br>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="asset_status">Status:</label><br>
                                    <select class="form-control" id="asset_status" name="asset_status" required>
                                        <option value="working">Working</option>
                                        <option value="deteriorated" disabled>Deteriorated</option>
                                        <option value="for_repair" disabled>For Repair</option>
                                        <option value="for_disposal" disabled>For Disposal</option>
                                    </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="asset_loc_long">Location (Longitude):</label><br>
                                    <input type="text" class="form-control" id="asset_loc_long" name="asset_loc_long" placeholder="Asset Location (Longitude)" maxlength="8" required><br>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="asset_loc_lat">Location (Latitude):</label><br>
                                    <input type="text" class="form-control" id="asset_loc_lat" name="asset_loc_lat" placeholder="Asset Location (Latitude)" maxlength="8" required><br>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="hoa_name">Select HOA:</label><br>
                                    <jsp:useBean id="hoa_select" class="assetmanagement.assets" scope="session"/>
                                    <select id="hoa_name" class="form-control" name="hoa_name" required>
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
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="select_room">Select Room:</label><br>
                                    <jsp:useBean id="room_select" class="assetmanagement.assets" scope="session"/>
                                    <select id="select_room" class="form-control" name="select_room" required>
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
                                </div>
                            </div>
                            <input type="submit" class="btn" style="background-color: #3A98B9; color: white;" value="Submit">
                            <input type="reset" class="btn" style="background-color: white;" value="Reset">
                    </div>
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
