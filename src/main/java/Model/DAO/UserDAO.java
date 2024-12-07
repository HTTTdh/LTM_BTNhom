package Model.DAO;

import Model.Bean.Article;
import Model.Bean.User;
import Model.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {

    public User getUserById(int user_id){
        try{
            Connection con = DBHelper.getConnection();
            String sql = "SELECT * FROM User WHERE id = ? ";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, user_id);

            ResultSet rs = stmt.executeQuery();
            rs.next();

            User user = new User(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getBoolean(5),
                    rs.getInt(6)
            );
            rs.close();
            stmt.close();
            return user;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

}
