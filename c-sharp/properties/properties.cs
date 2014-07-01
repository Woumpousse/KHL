public class Book {
    private String title;
    private int pageCount;

    @1public@ string Title {
        get {
            return title;
        }
        set {
            if ( !isValidTitle(title) ) {
                throw new ArgumentException();
            }
            else {
                this.title = title;
            }
        }
    }

    public int PageCount {
        get {
            return pageCount;
        }
        set {
            if ( !isValidPageCount(pageCount) ) {
                throw new ArgumentException();
            }
            else {
                this.pageCount = pageCount;
            }
        }
    }
}
