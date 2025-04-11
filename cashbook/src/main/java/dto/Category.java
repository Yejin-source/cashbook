package dto;
// import java.lang.*; | 자동으로 생성

public class Category extends Object{
	/*
		public Category() { // 자동으로 생성
			super(); // Object();
			// new 생성자 : new heap 영역에 this 필드를 생성하고 초기화
			
			// 생성자에서 필드를 만들어달라고 했기 때문에 만들어지는 것
			// 클래스에 필드가 있기 때문에 만들어지는 것이 아님
			this.categoryNo = 0;
			this.kind = null;
			this.title = null;
			this.createdate = null;
		}
	*/
	
	private int categoryNo; // 헷갈려서 categoryNo로 수정
	private String kind;
	private String title;
	private String createdate;
	
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	
	@Override
	public String toString() {
		return "Category [categoryNo=" + categoryNo + ", kind=" + kind + ", title=" + title + ", createdate="
				+ createdate + "]";
	}	
	
}
