package Model.Bean;

public class User {
    private static int idCounter = 1; // Biến tĩnh để giữ giá trị id hiện tại
    private int id;
    private String fullName;
    private String username;
    private String password;
    private boolean isActive;
    private int idRole;

    public User(int id, String fullName, String username, String password, boolean isActive, int idRole) {
        this.id = id;
        this.fullName = fullName;
        this.username = username;
        this.password = password;
        this.isActive = isActive;
        this.idRole = idRole;
    }

    // Constructor
    public User(String fullName, String username, String password, boolean isActive, int idRole) {
        this.id = idCounter++; // Gán giá trị và tăng lên
        this.fullName = fullName;
        this.username = username;
        this.password = password;
        this.isActive = isActive;
        this.idRole = idRole;
    }

    // Getters và setters
    public int getId() {
        return id;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    public int getIdRole() {
        return idRole;
    }

    public void setIdRole(int idRole) {
        this.idRole = idRole;
    }

    @Override
    public String toString() {
        return "User{id=" + id + ", fullName='" + fullName + '\'' +
                ", username='" + username + '\'' +
                ", isActive=" + isActive +
                ", idRole=" + idRole + '}';
    }
}
