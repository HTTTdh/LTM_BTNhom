package Model.Bean;

public class Roles {
    private static int idCounter = 1;
    private int id;
    private String nameRole;
    private String description;

    public Roles(int id, String nameRole, String description) {
        this.id = idCounter++;
        this.nameRole = nameRole;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNameRole() {
        return nameRole;
    }

    public void setNameRole(String nameRole) {
        this.nameRole = nameRole;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
