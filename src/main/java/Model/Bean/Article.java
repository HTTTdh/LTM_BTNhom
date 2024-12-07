package Model.Bean;

import java.util.Date;

public class Article {
    private int id;
    private String title;
    private String content;
    private Category category;
    private Date created_at;
    private int user_id;

    private static int count = 0;
    public Article() {}
    public Article(String title, String content, String category, int user_id) {
        this.id = ++count;
        this.title = title;
        this.content = content;
        this.category = Category.valueOf(category);
        this.created_at = new Date();
        this.user_id = user_id;
    }

    public Article(int id, String title, String content, String category, Date created_at, int user_id) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.category = Category.valueOf(category);
        this.created_at = created_at;
        this.user_id = user_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
}
