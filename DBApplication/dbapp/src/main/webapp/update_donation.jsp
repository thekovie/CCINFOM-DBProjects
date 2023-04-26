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
<jsp:useBean id="donate" class="assetmanagement.donation" scope="session"/>
<%
    donation a = new donation();
    a.load_donationinfo(request.getParameter("asset_select"));
%>
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


<div class="container" style="margin-top: 70px; max-width: 1500px; margin-bottom: 80px">
<form action="process_upd_donation.jsp" method="post" onsubmit="return validateFilenames()">
    <div class="col">
        <div class="row">
            <div class="logo-left" style="padding: 100px;">
                <img class="img-fluid" src="https://img.icons8.com/cotton/350/null/petition.png" alt="HOA Logo">
            </div>
            <div class="col">
                <div class="form-group">
                    <a class="btn btn-outline-info" href="search_donation.jsp">< Return to Donator List</a><br><br>
                    <h1>Donation</h1>
                    <h2>Update your Donation</h2>
                    <p style="color: crimson;">*Fill up the required fields</p>
                        <div id="donor_info_div">
                            <h3>Donor Information</h3>
                            <label for="donor_name">Full Name:</label><br>
                            <input type="text" class="form-control" id="donor_name" name="donor_name" placeholder="Full Name" maxlength="45" value="<%=a.donor_name%>" disabled><br>
                            <label for="donor_address">Address:</label><br>
                            <textarea id="donor_address" class="form-control" name="donor_address" placeholder="Home Address" rows="4" cols="50" maxlength="100" disabled><%=a.donor_address%></textarea><br>
                        </div>
                        <h3>Donation Information</h3>
                        <label for="donation_id">Donation ID:</label><br>
                        <input type="text" class="form-control" id="donation_id" name="donation_id" placeholder="Donation ID" maxlength="45" value="<%=a.donation_id%>" readonly><br>
                        <label for="donor_amount">Amount Donated:</label><br>
                        <input type="number" class="form-control" id="donor_amount" name="donor_amount" placeholder="Amount Donated" min="0" value="<%=a.donation_amount%>" required><br>
                        <div id="donate-proof-fields">
                            <label for="donation_pics">Proof of Donation:</label>
                            <small class="form-text text-muted">*Enter filename with image or PDF extension</small>
                            <br>
                            <%
                                for (int i = 0; i < a.donation_pics.size(); i++) {
                                    if (i == 0) {
                             %>
                            <input type="text" class="form-control m-input" id="donation_pics" name="donation_pics[]" placeholder="Enter filename with image or PDF extension" maxlength="45" value="<%= a.donation_pics.get(i) %>" required>
                            <%
                                    } else {
                            %>
                                <div id="row">
                                    <div class="input-group m-3" style="margin-left:none;">
                                        <input type="text" class="form-control m-input" id="donation_pics" name="donation_pics[]" placeholder="Enter filename" maxlength="45" value="<%= a.donation_pics.get(i) %>" required>
                                        <button type="button" class="btn btn-danger" id="remove_field" aria-label="Close" onclick="removeField(this)"><span aria-hidden="true">&times;</span></button><br>
                                    </div>
                                </div>
                            <%
                                }
                            %>
                            <%
                                }
                            %>
                        </div><br>
                        <button type="button" class="btn btn-info" onclick="addFilename()">Add Another File</button><br><br>
                        <label for="accepting_officer">Accepting Officer:</label><br>
                        <select id="accepting_officer" class="form-control" name="accepting_officer"">
                            <%
                                donation d = new donation();
                                d.list_officers();

                                for (int i = 0; i < d.officer_list.size(); i++) {
                            %>
                            <option value="<%= d.officer_list.get(i).officer_id %>" <% if (d.officer_list.get(i).officer_id == a.accepting_officer_id) {%> selected <%}%>><%= d.officer_list.get(i).officer_id %> - <%= d.officer_list.get(i).officer_name %></option>
                            <%
                                }
                            %>
                        </select><br>
                        <input type="submit" class="btn" style="background-color: #3A98B9; color: white;" value="Submit">
                        <input type="reset" class="btn" style="background-color: white;" value="Reset">
                </div>
            </div>
        </div>
    </div>
</form>
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
<script>
    function addFilename() {
        const container = document.getElementById("donate-proof-fields");
        const newField = document.createElement("div");
        newField.innerHTML = '<div id="row"><div class="input-group m-3" style="margin-left:none;">' +
                             '<input type="text" class="form-control m-input" name="donation_pics[]" placeholder="Enter filename" maxlength="45" required>\n' +
                             '<button type="button" class="btn btn-danger" id="remove_field" aria-label="Close" onclick="removeField(this)"><span aria-hidden="true">&times;</span></button></div></div>';
        container.appendChild(newField);
    }

    function removeField(button) {
        button.parentNode.remove();
    }

    function validateFilenames() {
        const filenames = document.getElementsByName("donation_pics[]");
        for (let i = 0; i < filenames.length; i++) {
            const ext = filenames[i].value.split('.').pop().toLowerCase();
            if (!["jpg", "jpeg", "png", "pdf"].includes(ext)) {
                alert("Invalid file extension. Please enter a valid image or PDF file.");
                return false;
            }
        }
        return true;
    }
</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>