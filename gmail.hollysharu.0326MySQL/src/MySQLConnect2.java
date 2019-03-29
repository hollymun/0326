import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class MySQLConnect2 {

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
						//"select avg(price) from buytbl");){
						//"select userid from buytbl group by userid");){
						"select userid, sum(price * amount) from buytbl group by userid");){
						
			
			
/*			//1) select avg(price) from buytbl를 저장할 자료구조
			double avg = -1; 
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				avg = rs.getDouble("avg(price)");
			}
			System.out.printf("평균:%f\n", avg);
			rs.close();
			
			
			//2) select userid from buytbl group by userid을 저장할 자료구조			
			List<String> list = new ArrayList<String>(); 
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String temp = rs.getString("userid");
				list.add(temp);
			}
			rs.close();
			System.out.printf("%s\n", list);
*/
			
			//3) select userid, sum(price * amount) from buytbl group by userid를 저장할 자료구조
			//조회할 내용이 연산식인 경우는 연산식에 별명을 사용하는 것이 좋음 
			List<Map<String, Object>> list = new ArrayList<Map<String,Object>>(); 
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				//HashMap - 키의 순서를 모름 
				//LinkedHashMap - 키의 순서대로 저장 
				//TreeMap - 키를 오름차순으로 정렬해서 저장 (실제 정렬x,트리구조로 저장)
				Map<String, Object> map = new LinkedHashMap<String, Object>();
				map.put("userid", rs.getString("userid"));
				map.put("sum", rs.getInt(2)); //또는 sum ~'별명' 설정해두고 대입
				
				list.add(map);
			}
			rs.close();
			System.out.printf("%s\n", list);
			
			
		}
		catch(Exception e) {
			System.out.printf("데이터베이스 사용 예외:%s\n", e.getMessage());
		}

		
		
	}
}
