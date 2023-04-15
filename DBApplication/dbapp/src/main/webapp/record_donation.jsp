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
        <form action="donation_process.jsp" method="post" onsubmit="return validateFilenames()">
            <label for="exist_checkbox"><b>Donator Status:</b></label><br> 
            <label><input type="checkbox" name="exist-checkbox" id="exist_checkbox">Existing donator</label><br><br>
            <div id ="exist_donor_div" style="display: none;">
                <label for="donor_id">Donor:</label><br>
                <select id="donor_id" name="donor_id">
                    <%
                        donation e = new donation();
                        e.load_donors();

                        for (int i = 0; i < e.donor_list.size(); i++) {
                    %>
                    <option value="<%= e.donor_list.get(i).donor_name %>"><%=e.donor_list.get(i).donor_name%></option>
                    <%
                        }
                    %>
                </select><br>
            </div>
            <div id="donor_info_div">
                <h3>Donor Information</h3>
                <label for="donor_name">Full Name:</label><br>
                <input type="text" id="donor_name" name="donor_name" placeholder="Full Name" maxlength="45" required><br>
                <label for="donor_address">Address:</label><br>
                <textarea id="donor_address" name="donor_address" placeholder="Home Address" rows="4" cols="50" maxlength="100" required></textarea><br>
            </div>
            <h3>Donation Information</h3>
            <label for="donor_amount">Amount Donated:</label><br>
            <input type="number" id="donor_amount" name="donor_amount" placeholder="Amount Donated" min="0" required><br>
            <div id="donate-proof-fields">
                <label for="donation_pics">Proof of Donation:</label><br>
                <input type="text" id="donation_pics" name="donation_pics[]" placeholder="Enter filename with image or PDF extension" maxlength="45" required>
            </div>
            <button type="button" onclick="addFilename()">Add Another File</button><br>
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
        <script>
            function addFilename() {
                const container = document.getElementById("donate-proof-fields");
                const newField = document.createElement("div");
                newField.innerHTML = '<input type="text" name="donation_pics[]" placeholder="Enter filename with image or PDF extension" maxlength="45" required>\n' +
                    '                <button type="button" id="remove_field" style="width: 8%; background-color: crimson;" onclick="removeField(this)">X</button>';
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

            const checkbox = document.getElementById('exist_checkbox');
            const div_newdonor = document.getElementById('donor_info_div');
            const div_olddonor = document.getElementById('exist_donor_div');

            checkbox.addEventListener('change', (event) => {
                if (event.target.checked) {
                    div_newdonor.style.display = 'none';
                    div_olddonor.style.display = 'block';
                } else {
                    div_newdonor.style.display = 'block';
                    div_olddonor.style.display = 'none';
                }
            });
        </script>
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