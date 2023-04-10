package assetmanagement;

import java.net.Inet4Address;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;
import java.sql.*;

public class assets {
    public static int asset_id;
    public static String asset_name;
    public static String asset_type;
    public static String asset_description;
    public static Date asset_acq_date;
    public static Boolean asset_rent;
    public static double asset_value;
    public static String asset_status;
    public static double asset_longitude;
    public static double asset_latitude;
    public static String asset_hoa;
    public static String error_msg;
    public static String asset_rent_status;
    public static String asset_room_id;


    public ArrayList<String> asset_HoaList = new ArrayList<String>();
    public ArrayList<String> asset_nameList = new ArrayList<String>();
    public ArrayList<String> asset_idList = new ArrayList<String>();
    public ArrayList<String> asset_selectList = new ArrayList<String>();



    public assets() {

    }

    public static boolean register_asset() {
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
            pstmt = con.prepareStatement("INSERT INTO assets(asset_id, asset_name, asset_description, acquisition_date, forrent, asset_value, type_asset, status, loc_lattitude, loc_longiture, hoa_name, enclosing_asset) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
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
            if (asset_room_id.equals("null")) {
                pstmt.setNull(12, Types.INTEGER);
            } else {
                pstmt.setInt(12, Integer.parseInt(asset_room_id));
            }
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
            PreparedStatement pstmt = con.prepareStatement("UPDATE assets SET asset_name = ?, asset_description = ?, acquisition_date = ?, forrent = ?, asset_value = ?, type_asset = ?, status = ?, loc_lattitude = ?, loc_longiture = ?, hoa_name = ?, enclosing_asset = ? WHERE asset_id = ?");
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
            if (asset_room_id.equals("null")) {
                pstmt.setNull(11, Types.INTEGER);
            } else {
                pstmt.setInt(11, Integer.parseInt(asset_room_id));
            }
            pstmt.setInt(12, asset_id);

            pstmt.executeUpdate();

            // Remove enclosing asset if asset is disposed
            if (asset_status.equals("X")) {
                pstmt = con.prepareStatement("UPDATE assets SET enclosing_asset = NULL WHERE asset_id= ?");
                pstmt.setInt(1, asset_id);
                pstmt.executeUpdate();
            }

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
                asset_room_id = rs.getString("enclosing_asset");
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
                case "X": asset_status = "disposed"; break;
            }

            if (asset_rent == true) {
                asset_rent_status = "for_rent";
            } else {
                asset_rent_status = "not_forrent";
            }

            if (asset_room_id == null) {
                asset_room_id = "null";
            }

            pstmt.close();
            con.close();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public static Boolean delete_asset() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "12345678");
            System.out.println("Connected to database");

            PreparedStatement pstmt = con.prepareStatement("DELETE FROM assets WHERE asset_id = ?");
            pstmt.setInt(1, asset_id);
            pstmt.executeUpdate();

            System.out.println("Asset Deleted Successfully");

            pstmt.close();
            con.close();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }


        return false;
    }

    public void load_del_assets() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "12345678");
            System.out.println("Connected to database");

            PreparedStatement pstmt = con.prepareStatement("SELECT asset_id, asset_name FROM assets WHERE asset_id NOT IN(SELECT asset_id FROM asset_transactions) AND asset_id NOT IN(SELECT enclosing_asset FROM assets WHERE enclosing_asset IN(SELECT asset_id FROM assets))");
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
    }

    public void load_rooms() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "12345678");
            System.out.println("Connected to database");

            PreparedStatement pstmt = con.prepareStatement("SELECT asset_id, asset_name FROM assets WHERE type_asset = 'P'");
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
    }

    public String getAssetId() {
        return Integer.toString(asset_id);
    }

    public String getErrorMessage() {
        return error_msg;
    }

    public Boolean isDisposed() {
        if (asset_status.equals("disposed")) {
            return true;
        } else {
            return false;
        }
    }

    public Boolean canForDisposal() {
        Boolean canForDisposal = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "12345678");
            System.out.println("Connected to database");

            PreparedStatement pstmt = con.prepareStatement("SELECT enclosing_asset FROM assets WHERE asset_id = ?");
            pstmt.setInt(1, asset_id);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                if (rs.getString("enclosing_asset") != null) {
                    canForDisposal = true;
                }
            }


        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return canForDisposal;
    }

    public Boolean canDispose() {
        Boolean canDispose = false;

        if (asset_status.equals("for_disposal")) {
            canDispose = true;
        }

        return canDispose;
    }
    public static void main(String args[]) {
//        assets a = new assets();
//        a.get_hoalist();
//        System.out.println(a.asset_HoaList);
    }
}
