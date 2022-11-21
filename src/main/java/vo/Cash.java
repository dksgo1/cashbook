package vo;

public class Cash {
	private int cashNo;
	// Map 타입을 안쓸려면 private Category category; // INNER JOIN -> Cash타입
	private int categroyNo; // FK -> INNER JOIN -> Map타입
	private long cashPrice;
	private String cashMemo;
	private String updatedate;
	private String createdate;
}
