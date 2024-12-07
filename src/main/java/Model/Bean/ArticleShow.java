package Model.Bean;

import java.util.Date;

public class ArticleShow {
    private int id;
    private String title;
    private String content;
    private Category category;
    private Date created_at;
    private String author;

    public ArticleShow(int id, String title, String content, String category, Date created_at, String author) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.category = Category.valueOf(category);
        this.created_at = created_at;
        this.author = author;
    }
    public ArticleShow() {}
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

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
}
