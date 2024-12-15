package Model.Bean;

import java.util.Date;

public class Comment {
    private int id;
    private int article_id;
    private int user_id;
    private String content;
    private Date created_at;

    public Comment(int id, int article_id, int user_id, String content, Date created_at) {
        this.id = id;
        this.article_id = article_id;
        this.user_id = user_id;
        this.content = content;
        this.created_at = created_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getArticle_id() {
        return article_id;
    }

    public void setArticle_id(int article_id) {
        this.article_id = article_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }
}
