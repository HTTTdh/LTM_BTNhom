package Model.Bean;

import java.util.Date;

public class CommentShow {
    private int id;
    private int article_id;
    private UserShow user;
    private String content;
    private Date created_at;

    public CommentShow(int id, int article_id, UserShow user, String content, Date created_at) {
        this.id = id;
        this.article_id = article_id;
        this.user = user;
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

    public UserShow getUser() {
        return user;
    }

    public void setUser(UserShow user) {
        this.user = user;
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
