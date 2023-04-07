package assetmanagement;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;
import java.sql.*;

public class assets {
    public int asset_id;
    public String asset_name;
    public String asset_type;
    public String asset_description;
    public Date asset_acq_date;
    public Boolean asset_rent = false;
    public double asset_value;
    public String asset_status;
    public double asset_longitude;
    public double asset_latitude;
    public String asset_hoa;
    public String error_msg;
    public String asset_rent_status;


    public ArrayList<String> asset_HoaList = new ArrayList<String>();
    public ArrayList<String> asset_nameList = new ArrayList<String>();
    public ArrayList<String> asset_idList = new ArrayList<String>();
    public ArrayList<String> asset_selectList = new ArrayList<String>();



    public assets() {

    }

    public boolean register_asset() {
        try {
            // Connect to database online
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "12345678");
            System.out.println("Connected to database");

            // Get Latest Asset ID
            PreparedStatement pstmt = con.prepareStatement("SELECT MAX(asset_id) + 1 AS newID  FROM assets");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                asset_id = rs.getInt("newID");
            }




            // Insert new asset
            pstmt = con.prepareStatement("INSERT INTO assets(asset_id, asset_name, asset_description, acquisition_date, forrent, asset_value, type_asset, status, loc_lattitude, loc_longiture, hoa_name) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, asset_id);
            pstmt.setString(2, asset_name);
            pstmt.setString(3, asset_description);
            pstmt.setDate(4, asset_acq_date);
            pstmt.setBoolean(5, asset_rent);
            pstmt.setDouble(6, asset_value);
            pstmt.setString(7, asset_type);
            pstmt.setString(8, asset_status);
            pstmt.setDouble(9, asset_latitude);
            pstmt.setDouble(10, asset_longitude);
            pstmt.setString(11, asset_hoa);
            pstmt.executeUpdate();

            System.out.println("Asset Registered Successfully");

            pstmt.close();
            con.close();

            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            error_msg = e.getMessage();
        }
        System.out.println("Asset Registration Failed");
        return false;
    }

    public boolean update_asset() {
        try {
            // Connect to database online
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "12345678");
            System.out.println("Connected to database");


            // Insert new asset
            PreparedStatement pstmt = con.prepareStatement("UPDATE assets SET asset_name = ?, asset_description = ?, acquisition_date = ?, forrent = ?, asset_value = ?, type_asset = ?, status = ?, loc_lattitude = ?, loc_longiture = ?, hoa_name = ? WHERE asset_id = ?");
            pstmt.setString(1, asset_name);
            pstmt.setString(2, asset_description);
            pstmt.setDate(3, asset_acq_date);
            pstmt.setBoolean(4, asset_rent);
            pstmt.setDouble(5, asset_value);
            pstmt.setString(6, asset_type);
            pstmt.setString(7, asset_status);
            pstmt.setDouble(8, asset_latitude);
            pstmt.setDouble(9, asset_longitude);
            pstmt.setString(10, asset_hoa);
            pstmt.setInt(11, asset_id);
            pstmt.executeUpdate();

            System.out.println("Asset Update Successfully");

            pstmt.close();
            con.close();

            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            error_msg = e.getMessage();
        }
        System.out.println("Asset Update Failed");
        return false;
    }

    public void load_hoalist() {
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "12345678");
            System.out.println("Connected to database");

            PreparedStatement pstmt = con.prepareStatement("SELECT hoa_name FROM hoa");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                asset_HoaList.add(rs.getString("hoa_name"));
            }

            pstmt.close();
            con.close();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }

    public void load_assets() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "12345678");
            System.out.println("Connected to database");

            PreparedStatement pstmt = con.prepareStatement("SELECT asset_id, asset_name FROM assets");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                asset_nameList.add(rs.getString("asset_name"));
                asset_idList.add(rs.getString("asset_id"));
            }
            for (int i = 0; i < asset_idList.size(); i++) {
                asset_selectList.add(asset_idList.get(i) + " - " + asset_nameList.get(i));
            }

            pstmt.close();
            con.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        for (int i = 0; i < asset_selectList.size(); i++) {
            System.out.println(asset_idList.get(i));
        }
    }

    public void load_assetinfo(String assetId) {
        int assetIdInt = Integer.parseInt(assetId);

        asset_id = assetIdInt;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "12345678");
            System.out.println("Connected to database");

            PreparedStatement pstmt = con.prepareStatement("SELECT * FROM assets WHERE asset_id = ?");
            pstmt.setInt(1, assetIdInt);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                asset_id = rs.getInt("asset_id");
                asset_name = rs.getString("asset_name");
                asset_description = rs.getString("asset_description");
                asset_acq_date = rs.getDate("acquisition_date");
                asset_rent = rs.getBoolean("forrent");
                asset_value = rs.getDouble("asset_value");
                asset_type = rs.getString("type_asset");
                asset_status = rs.getString("status");
                asset_latitude = rs.getDouble("loc_lattitude");
                asset_longitude = rs.getDouble("loc_longiture");
                asset_hoa = rs.getString("hoa_name");
            }

            switch(asset_type) {
                case "P": asset_type = "property"; break;
                case "E": asset_type = "equipment"; break;
                case "F": asset_type = "fnf"; break;
                case "O": asset_type = "Others"; break;
            }

            switch(asset_status) {
                case "W": asset_status = "working"; break;
                case "D": asset_status = "deteriorated"; break;
                case "P": asset_status = "for_repair"; break;
                case "S": asset_status = "for_disposal"; break;
            }

            if (asset_rent == true) {
                asset_rent_status = "rented";
            } else {
                asset_rent_status = "not_rented";
            }

            pstmt.close();
            con.close();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public String getAssetId() {
        return Integer.toString(asset_id);
    }

    public String getErrorMessage() {
        return error_msg;
    }
    public static void main(String args[]) {
//        assets a = new assets();
//        a.get_hoalist();
//        System.out.println(a.asset_HoaList);
    }
}
