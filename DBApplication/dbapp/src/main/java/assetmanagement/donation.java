package assetmanagement;

import javax.lang.model.type.ArrayType;
import java.sql.*;
import java.util.ArrayList;

public class donation {
    public String donor_name;
    public String donor_address;
    public double donation_amount;
    public int accepting_officer_id;
    public boolean donor_exists;
    public static Boolean existing_donator = false;
    public officer accepting_officer;
    public int donation_id;
    public String donation_asset;


    public ArrayList<officer> officer_list = new ArrayList<>();
    public ArrayList<String> donation_pics = new ArrayList<>();
    public ArrayList<donor> donor_list = new ArrayList<>();
    public ArrayList<Integer> donor_idList = new ArrayList<>();
    public ArrayList<String> donor_name_list = new ArrayList<>();
    public ArrayList<String> donation_list = new ArrayList<>();

    public class officer {
        public int officer_id;
        public String officer_name;
        public String officer_position;
        public Date officer_elect_date;
    }

    public static class donor {
        public String donor_name;
        public String donor_address;
    }

    public donation() {

    }

    public void load_donors() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "kVgdrBtq7oGs^S");
            System.out.println("Connected to database");

            PreparedStatement pstmt = con.prepareStatement("SELECT donorname, address FROM donors");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                donor d = new donor();
                d.donor_name = rs.getString("donorname");
                d.donor_address = rs.getString("address");
                donor_list.add(d);
            }
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public String get_donor_address(String name) {
        String address = "";
        load_donors();
        for (donor d : donor_list) {
            if (d.donor_name.equals(name)) {
                address = d.donor_address;
                break;
            }
        }
        return address;
    }
    public Boolean register_donation() {
        Boolean reg_status = assets.register_asset();
        Boolean donation_status = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "kVgdrBtq7oGs^S");
            System.out.println("Connected to database");

            // get donation id
            PreparedStatement pstmt = con.prepareStatement("SELECT MAX(donation_id) + 1 AS donationID FROM asset_donations");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                donation_id = rs.getInt("donationID");
            }
            list_officers();
            // get accepting officer
            for (officer o : officer_list) {
                if (o.officer_id == accepting_officer_id) {
                    accepting_officer = o;
                    break;
                }
            }
            String firstName = donor_name.split(" ")[0].toLowerCase();

            // check if donor exists
            pstmt = con.prepareStatement("SELECT donorname FROM donors WHERE donorname = ?");
            pstmt.setString(1, donor_name);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                donor_exists = true;
            }

            // fill donors table
            if (!donor_exists) {
                pstmt = con.prepareStatement("INSERT INTO donors (donorname, address) VALUES(?, ?)");
                pstmt.setString(1, donor_name);
                pstmt.setString(2, donor_address);
                pstmt.executeUpdate();
            }

            // fill asset_donations table
            pstmt = con.prepareStatement("INSERT INTO asset_donations (donation_id, donor_completename, donation_formfile, date_donation, accept_hoid, accept_position, accept_electiondate, isdeleted) VALUES(?, ?, ?, ?, ?, ?, ?, 0)");
            pstmt.setInt(1, donation_id);
            pstmt.setString(2, donor_name);
            pstmt.setString(3, donation_id + firstName + ".pdf");
            pstmt.setDate(4, assets.asset_acq_date);
            pstmt.setInt(5, accepting_officer.officer_id);
            pstmt.setString(6, accepting_officer.officer_position);
            pstmt.setDate(7, accepting_officer.officer_elect_date);
            pstmt.executeUpdate();

            // fill donated_assets table
            pstmt = con.prepareStatement("INSERT INTO donated_assets (donation_id, asset_id, amount_donated) VALUES(?, ?, ?)");
            pstmt.setInt(1, donation_id);
            pstmt.setInt(2, assets.asset_id);
            pstmt.setDouble(3, donation_amount);
            pstmt.executeUpdate();

            // fill donation_pictures table
            if (donation_pics.size() > 0)
                for (String pic : donation_pics) {
                    pstmt = con.prepareStatement("INSERT INTO donation_pictures (donation_id, picturefile) VALUES(?, ?)");
                    pstmt.setInt(1, donation_id);
                    pstmt.setString(2, donation_id + "-" + pic);
                    pstmt.executeUpdate();
                }
            donation_pics.clear();
            donation_status = true;
            pstmt.close();
            con.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            assets.error_msg = e.getMessage();
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "kVgdrBtq7oGs^S");
                System.out.println("Connected to database");
                PreparedStatement pstmt;
                pstmt = con.prepareStatement("DELETE FROM donation_pictures WHERE donation_id = ?");
                pstmt.setInt(1, donation_id);
                pstmt.executeUpdate();

                pstmt = con.prepareStatement("DELETE FROM donated_assets WHERE donation_id = ?");
                pstmt.setInt(1, donation_id);
                pstmt.executeUpdate();

                if (!donor_exists) {
                    pstmt = con.prepareStatement("DELETE FROM donors WHERE donorname = ?");
                    pstmt.setString(1, donor_name);
                    pstmt.executeUpdate();
                }

                pstmt = con.prepareStatement("DELETE FROM asset_donations WHERE donation_id = ?");
                pstmt.setInt(1, donation_id);
                pstmt.executeUpdate();

                pstmt.close();
                con.close();
                assets.delete_asset();
            }
            catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        }


        return  reg_status && donation_status;
    }

    public Boolean update_donation() {
        Boolean isUpdated = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "kVgdrBtq7oGs^S");
            System.out.println("Connected to database");

            list_officers();
            // get accepting officer
            for (officer o : officer_list) {
                if (o.officer_id == accepting_officer_id) {
                    accepting_officer = o;
                    break;
                }
            }

            // update asset_donations table
            PreparedStatement pstmt = con.prepareStatement("UPDATE asset_donations SET accept_hoid = ?, accept_position = ?, accept_electiondate = ? WHERE donation_id = ?");
            pstmt.setInt(1, accepting_officer.officer_id);
            pstmt.setString(2, accepting_officer.officer_position);
            pstmt.setDate(3, accepting_officer.officer_elect_date);
            pstmt.setInt(4, donation_id);
            pstmt.executeUpdate();

            // update donated_assets table
            pstmt = con.prepareStatement("UPDATE donated_assets SET amount_donated = ? WHERE donation_id = ?");
            pstmt.setDouble(1, donation_amount);
            pstmt.setInt(2, donation_id);
            pstmt.executeUpdate();

            // update donation_pictures table
            pstmt = con.prepareStatement("DELETE FROM donation_pictures WHERE donation_id = ?");
            pstmt.setInt(1, donation_id);
            pstmt.executeUpdate();
            if (donation_pics.size() > 0)
                for (String pic : donation_pics) {
                    pstmt = con.prepareStatement("INSERT INTO donation_pictures (donation_id, picturefile) VALUES(?, ?)");
                    pstmt.setInt(1, donation_id);
                    pstmt.setString(2, donation_id + "-" + pic);
                    pstmt.executeUpdate();
                }

            isUpdated = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
//            error_msg = e.getMessage();
        }

        return isUpdated;
    }


    public void list_officers() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "kVgdrBtq7oGs^S");
            System.out.println("Connected to database");

            PreparedStatement pstmt = con.prepareStatement("SELECT o.ho_id, o.position, o.election_date, CONCAT(p.firstname, ' ', p.lastname) AS fullname FROM officer o JOIN people p ON p.peopleid = o.ho_id WHERE o.end_date >= NOW()");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                officer o = new officer();
                o.officer_id = rs.getInt("ho_id");
                o.officer_position = rs.getString("position");
                o.officer_elect_date = rs.getDate("election_date");
                o.officer_name = rs.getString("fullname");
                officer_list.add(o);
            }
            pstmt.close();
            con.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void load_donationlist() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "kVgdrBtq7oGs^S");
            System.out.println("Connected to database");

            PreparedStatement pstmt = con.prepareStatement("SELECT a.asset_name, ad.donor_completename, ad.donation_id  FROM donated_assets da JOIN assets a ON da.asset_id = a.asset_id JOIN asset_donations ad ON da.donation_id = ad.donation_id");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                donation_list.add(rs.getString("asset_name") + " - " + rs.getString("donor_completename").split(" ")[0]);
                donor_idList.add(rs.getInt("donation_id"));
            }

            pstmt.close();
            con.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void load_donationinfo(String donationId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://hoa.cwxgaovkt2sy.ap-southeast-2.rds.amazonaws.com/HOADB", "root", "kVgdrBtq7oGs^S");
            System.out.println("Connected to database");

            PreparedStatement pstmt;
            ResultSet rs;
            // Get Donation Information
            pstmt = con.prepareStatement("SELECT donation_id, accept_hoid, donor_completename FROM asset_donations WHERE donation_id = ?");
            pstmt.setInt(1, Integer.parseInt(donationId));
            rs = pstmt.executeQuery();

            while (rs.next()) {
                donation_id = rs.getInt("donation_id");
                accepting_officer_id = rs.getInt("accept_hoid");
                donor_name = rs.getString("donor_completename");
            }

            // Get Donor Information
            pstmt = con.prepareStatement("SELECT address FROM donors WHERE donorname = ?");
            pstmt.setString(1, donor_name);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                donor_address = rs.getString("address");
            }



            pstmt = con.prepareStatement("SELECT amount_donated FROM donated_assets WHERE donation_id = ?");
            pstmt.setInt(1, Integer.parseInt(donationId));
            rs = pstmt.executeQuery();

            while (rs.next()) {
                donation_amount = rs.getDouble("amount_donated");
            }

            // Get Donation Pictures
            pstmt = con.prepareStatement("SELECT picturefile FROM donation_pictures WHERE donation_id = ?");
            pstmt.setInt(1, Integer.parseInt(donationId));
            rs = pstmt.executeQuery();

            while (rs.next()) {
                donation_pics.add(rs.getString("picturefile").substring(rs.getString("picturefile").indexOf("-") + 1));
            }

            pstmt.close();
            con.close();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }



    public static void main(String[] args) {
        // TODO code application logic here
    }
}
