package Model.Bean;

public enum Category {
    CURRENT_EVENTS("Thời sự"),
    BUSINESS("Kinh doanh"),
    SCIENCE("Khoa học"),
    ENTERTAINMENT("Giải trí"),
    SPORTS("Thể thao"),
    LAW("Pháp luật"),
    EDUCATION("Giáo dục"),
    HEALTH("Sức khỏe");

    private final String category_name;

    // Constructor
    Category(String category_name) {
        this.category_name = category_name;
    }

    // Getter để truy xuất giá trị
    public String getCategory_name() {
        return category_name;
    }
}