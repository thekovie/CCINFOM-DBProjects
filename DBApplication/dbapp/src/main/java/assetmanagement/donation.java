package assetmanagement;

import java.sql.*;
import java.util.ArrayList;

public class donation {
    public String donor_name;
    public String donor_address;
    public double donation_amount;
    public String accepting_officer;

    public ArrayList<officer> officer_list = new ArrayList<>();
    public ArrayList<String> donation_pics = new ArrayList<>();

    public class officer {
        public int officer_id;
        public String officer_name;
        public String officer_position;
        public Date officer_elect_date;
    }

    public donation() {

    }

    public Boolean register_donation() {
        Boolean reg_status = assets.register_asset();
        Boolean donation_status = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "12345678");
            System.out.println("Connected to database");


        } catch (Exception e) {
            System.out.println(e.getMessage());
        }


        return  reg_status && donation_status;
    }

    public void list_officers() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "12345678");
            System.out.println("Connected to database");

            PreparedStatement pstmt = con.prepareStatement("SELECT o.ho_id, o.position, o.election_date, CONCAT(p.firstname, ' ', p.lastname) AS fullname FROM officer o JOIN people p ON p.peopleid = o.ho_id");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                officer o = new officer();
                o.officer_id = rs.getInt("ho_id");
                o.officer_position = rs.getString("position");
                o.officer_elect_date = rs.getDate("election_date");
                o.officer_name = rs.getString("fullname");
                officer_list.add(o);
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }




    public static void main(String[] args) {
        // TODO code application logic here
    }
}
