package Model.BO;

import Model.Bean.Article;
import Model.Bean.ArticleShow;
import Model.Bean.User;
import Model.Bean.UserShow;
import Model.DAO.AdminDAO;

import java.util.List;

public class AdminBO {
    AdminDAO adminDAO = new AdminDAO();

    public boolean deleteArticles(int id){
        return adminDAO.deleteArticles(id);
    }
//    public ArticleShow getArticles(int id){
//        return adminDAO.getArticles(id);
//    }
    public boolean updateArticle(String title, String content, String category, int id){
        return adminDAO.updateArticles(title, content, category, id);
    }
    public boolean deleteUser(int id){
        return adminDAO.deleteUser(id);
    }
    public List<UserShow> listUser(){
        return adminDAO.listUser();
    }
//    public List<ArticleShow> listArticles(){
//        return adminDAO.listArticle();
//    }
}
