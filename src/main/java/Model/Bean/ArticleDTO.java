package Model.Bean;

import java.util.Date;

public class ArticleDTO {
    private int id;
    private String title;
    private String content;
    private Category category;
    private Date created_at;
    private String user_fullname;
    private String first_image;

    public ArticleDTO(int id, String title, String content, Category category, Date created_at, String user_fullname, String first_image) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.category = category;
        this.created_at = created_at;
        this.user_fullname = user_fullname;
        this.first_image = first_image;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public Category getCategory() {
        return category;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public String getUser_fullname() {
        return user_fullname;
    }

    public String getFirst_image() {
        return first_image;
    }
}
