package assetmanagement;

import java.util.*;
import java.sql.*;

public class assets {
    public int asset_id;
    public String asset_name;
    public String asset_type;
    public String asset_status;

    public ArrayList<Integer> asset_IdList = new ArrayList<Integer>();
    public ArrayList<String> asset_NameList = new ArrayList<String>();
    public ArrayList<String> asset_TypeList = new ArrayList<String>();
    public ArrayList<String> asset_StatusList = new ArrayList<String>();
    public ArrayList<String> asset_HoaList = new ArrayList<String>();

    public assets() {

    }

    public int register_asset() {
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

            // Save the new Asset
            //pstmt = con.prepareStatement("INSERT INTO assets (asset_id, asset_name, type_asset, asset_status) VALUES (?, ?, ?, ?)");

            pstmt.close();
            con.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public void get_hoalist() {
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
