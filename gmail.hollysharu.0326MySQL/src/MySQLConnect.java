import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class MySQLConnect {

	public static void main(String[] args) {

		//1. 드라이버 클래스를 로드 - 처음에 한 번만 하면 됨
		//이 부분에서 오류가 발생하면 
		//1) 드라이버 클래스 이름 오류 2) 드라이버 파일을 build path에 추가하지 않은 것 
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch(Exception e) {
			System.out.printf("드라이버 클래스 로드:%s\n", e.getMessage());
		}
		
		//2. 데이터베이스 연결 
		//try(){} : try with resource 구문으로 AutoCloeable 인터페이스를
		//implements한 클래스의 인스턴스를 생성하는 구문을 삽입할 수 있는데 
		//이 경우에는 close()를 호출하지 않아도 영역을 벗어나면 자동으로 호출함 
		try(Connection con = DriverManager.getConnection(
				//한글 사용은 ?useUnicode ~~ UTF-8 <- 추가해야 함 
				"jdbc:mysql://localhost:3306/sample?useUnicode=yes&characterEncoding=UTF-8", "root", "1111");
				//sql 실행 객체 - 입력 받아서 넣는 자리는 ?로 설정 
				PreparedStatement pstmt = con.prepareStatement(
						"update usertbl set addr=? where userid=?;");){
			
			//sql의 실행 객체에 ?가 있으면 ?에 실제 데이터 대입 - 바인딩 
			pstmt.setString(1, "인천");
			pstmt.setString(2, "haru");
//			pstmt.setInt(3, 2009);
//			pstmt.setString(4, "인천");
//			pstmt.setString(5, "01012345678");
			//Date를 생성할 때는 Calendar를 이용해서 생성 
			Calendar cal = new GregorianCalendar(2009, 2, 16);
			Date date = new Date(cal.getTimeInMillis());
//			pstmt.setDate(6, date);
			
			//SQL 실행 
			//select는 ResultSet으로 리턴 - List나 일반 객체 또는 스칼라 데이터
			//나머지는 SQL은 전부 정수로 리턴 
			//정수의 값을 가지고 성공여부를 판단해야 함 
			//이 정수값은 영향 받은 행의 개수 
			//삽입은 0보다 크면 삽입 성공 
			
			//수정 SQL 실행 
			//수정은 0보다 크면 수정할 데이터가 있어서 수정한 것이고 
			//0이 리턴되면 수정할 데이터가 없어서 수정을 안 한 것
			int result = pstmt.executeUpdate();
			if(result > 0) {
//				System.out.printf("데이터 삽입 성공");
				System.out.printf("데이터 수정 성공");

			}
			else {
//				System.out.printf("데이터 삽입 성공");
				System.out.printf("조건에 맞는 데이터가 없습니다");
			}
			
			
			}
		catch(Exception e) {
			System.out.printf("데이터베이스 사용 예외:%s\n", e.getMessage());
		}

		
		
	}
}
