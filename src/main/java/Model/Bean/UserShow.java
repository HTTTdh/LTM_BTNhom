package Model.Bean;

public class UserShow {
    private int id;
    private String fullName;
    private String username;
    private boolean is_Active;
    private String nameRole;

    public UserShow(int id, String fullName, String username, boolean is_Active, String nameRole) {
        this.id = id;
        this.fullName = fullName;
        this.username = username;
        this.is_Active = is_Active;
        this.nameRole = nameRole;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean getIs_Active() {
        return is_Active;
    }

    public void setIs_Active(boolean is_Active) {
        this.is_Active = is_Active;
    }

    public String getNameRole() {
        return nameRole;
    }

    public void setNameRole(String nameRole) {
        this.nameRole = nameRole;
    }
}
