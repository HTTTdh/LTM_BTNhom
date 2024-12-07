package Model.BO;

import Model.Bean.User;
import Model.Bean.UserShow;
import Model.DAO.UserDAO;

public class UserBO {
    public UserDAO dao = new UserDAO();
    public User getUserById(int user_id){
        return dao.getUserById(user_id);
    }
    public UserShow mapToUserShow(User user){
        String role = "USER";
        if (user.getIdRole() == 1){
            role = "ADMIN";
        }
        return new UserShow(user.getId(), user.getFullName(), user.getUsername(), user.isActive(), role);
    }
    public UserShow login(String username, String password){
        User user = dao.login(username, password);
        if (user == null){
            return null;
        }
        return mapToUserShow(user);
    }
}
