package Model.Bean;

import java.util.Date;

public class ArticleShow {
    private int id;
    private String title;
    private String content;
    private Category category;
    private Date created_at;
    private UserShow author;
    private String first_image;
    public ArticleShow() {}
    public ArticleShow(int id, String title, String content, Category category, Date created_at, UserShow author) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.category = category;
        this.created_at = created_at;
        this.author = author;
    }

    public ArticleShow(int id, String title, String content, Category category, Date created_at, UserShow author, String first_image) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.category = category;
        this.created_at = created_at;
        this.author = author;
        this.first_image = first_image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public UserShow getAuthor() {
        return author;
    }

    public void setAuthor(UserShow author) {
        this.author = author;
    }

    public String getFirst_image() {
        return first_image;
    }

    public void setFirst_image(String first_image) {
        this.first_image = first_image;
    }
}
