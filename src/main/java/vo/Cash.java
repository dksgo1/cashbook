package vo;

public class Cash {
	private int cashNo;
	// Map 타입을 안쓸려면 private Category category; // INNER JOIN -> Cash타입
	private int categroyNo; // FK -> INNER JOIN -> Map타입
	private String memberId;
	private String cashDate;
	private long cashPrice;
	private String cashMemo;
	private String updatedate;
	private String createdate;
	public int getCashNo() {
		return cashNo;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public int getCategroyNo() {
		return categroyNo;
	}
	public void setCategroyNo(int categroyNo) {
		this.categroyNo = categroyNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getCashDate() {
		return cashDate;
	}
	public void setCashDate(String cashDate) {
		this.cashDate = cashDate;
	}
	public long getCashPrice() {
		return cashPrice;
	}
	public void setCashPrice(long cashPrice) {
		this.cashPrice = cashPrice;
	}
	public String getCashMemo() {
		return cashMemo;
	}
	public void setCashMemo(String cashMemo) {
		this.cashMemo = cashMemo;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	

}
