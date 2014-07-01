public class Book {
    private String title;
    private int pageCount;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        if ( !isValidTitle(title) ) {
            throw new IllegalArgumentException();
        }
        else {
            this.title = title;
        }
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        if ( !isValidPageCount(pageCount) ) {
            throw new IllegalArgumentException();
        }
        else {
            this.pageCount = pageCount;
        }
    }
}
