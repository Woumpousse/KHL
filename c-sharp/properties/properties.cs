public class Book {
    private String title;
    private int pageCount;

@@    public string Title {`\label{line:properties:Book:Title:start}`
@@        get {
            return title;
@@        }
@@        set {
            if ( !IsValidTitle(title) ) {
                throw new ArgumentException();
            }
            else {
                this.title = title;
            }
@@        }
@@    }`\label{line:properties:Book:Title:end}`

@@    public int PageCount {`\label{line:properties:Book:PageCount:start}`
@@        get {
            return pageCount;`\label{line:properties:Book:PageCounter:getter}`
@@        }
@@        set {
            if ( value < 0 ) {`\label{line:properties:Book:PageCounter:setter:start}`
                throw new ArgumentException();`\label{line:properties:Book:PageCounter:exception}`
            }
            else {
                this.pageCount = value;
            }`\label{line:properties:Book:PageCounter:setter:end}`
@@        }`\label{line:properties:Book:PageCount:end}`
    }
}
