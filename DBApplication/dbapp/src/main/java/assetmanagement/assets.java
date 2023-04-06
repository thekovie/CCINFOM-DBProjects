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


    public ArrayList<String> asset_HoaList = new ArrayList<String>();


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

            System.out.println("Asset Registered");

            pstmt.close();
            con.close();

            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        System.out.println("Asset Registration Failed");
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
    public static void main(String args[]) {
//        assets a = new assets();
//        a.get_hoalist();
//        System.out.println(a.asset_HoaList);
    }
}
