package model.dao;


	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.util.ArrayList;
	import model.Asiakas;

	public class Dao {
		private Connection con = null;
		private ResultSet rs = null;
		private PreparedStatement stmtPrep=null;
		private String sql;
		private String db ="myynti.sqlite";
		
		
		
		private Connection yhdista() {
			Connection con = null;
			String url ="jdbc:sqlite:C:/Users/Uusio/eclipse-workspace/"+ db;
			try {
				Class.forName("org.sqlite.JDBC");
				con = DriverManager.getConnection(url);
				System.out.println("Yhteys muodostettu");
			}catch (Exception e) {
				System.out.println("Yhteys ep‰onnistui");
				e.printStackTrace();
			}
			return con;
		}

	public ArrayList<Asiakas> listaaKaikki(){
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		sql = "SELECT * FROM asiakkaat";
		try {
			con=yhdista();
			if(con!=null) {
				stmtPrep = con.prepareStatement(sql);
				rs=stmtPrep.executeQuery();
				if(rs!=null) {
					while (rs.next()) {
						Asiakas asiakas = new Asiakas();
						asiakas.setEtunimi(rs.getString(2));
						asiakas.setSukunimi(rs.getString(3));
						asiakas.setPuh(rs.getString(4));
						asiakas.setSposti(rs.getString(5));
						asiakkaat.add(asiakas);
					}
				}
			}
			con.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return asiakkaat;
	}

	public ArrayList<Asiakas> listaaKaikki(String hakusana){
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		sql = "SELECT * FROM asiakkaat WHERE etunimi LIKE ? or sukunimi LIKE ? or puh LIKE ? or sposti LIKE ?";      
		try {
			con=yhdista();
			if(con!=null){
				stmtPrep = con.prepareStatement(sql);
				stmtPrep.setString(1, "%" + hakusana + "%");
				stmtPrep.setString(2, "%" + hakusana + "%");   
				stmtPrep.setString(3, "%" + hakusana + "%"); 
				stmtPrep.setString(4, "%" + hakusana + "%");
        		rs = stmtPrep.executeQuery();   
				if(rs!=null){				
					while(rs.next()){
						Asiakas asiakas = new Asiakas();
						asiakas.setEtunimi(rs.getString(1));
						asiakas.setSukunimi(rs.getString(2));
						asiakas.setPuh(rs.getString(3));	
						asiakas.setSposti(rs.getString(4));	
						asiakkaat.add(asiakas);
					}					
				}				
			}	
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return asiakkaat;
	}
	public boolean lisaaAsiakas(Asiakas asiakas){
		boolean paluuArvo=true;
		sql="INSERT INTO autot VALUES(?,?,?,?)";						  
		try {
			con = yhdista();
			stmtPrep=con.prepareStatement(sql); 
			stmtPrep.setString(1, asiakas.getEtunimi());
			stmtPrep.setString(2, asiakas.getSukunimi());
			stmtPrep.setString(3, asiakas.getPuh());
			stmtPrep.setString(4, asiakas.getSposti());
			stmtPrep.executeUpdate();
	        con.close();
		} catch (Exception e) {				
			e.printStackTrace();
			paluuArvo=false;
		}				
		return paluuArvo;
	}
	
	public boolean poistaAsiakas(String etunimi){ //Oikeassa el‰m‰ss‰ tiedot ensisijaisesti merkit‰‰n poistetuksi.
		boolean paluuArvo=true;
		sql="DELETE FROM asiakkaat WHERE etunimi=?";						  
		try {
			con = yhdista();
			stmtPrep=con.prepareStatement(sql); 
			stmtPrep.setString(1, etunimi);			
			stmtPrep.executeUpdate();
	        con.close();
		} catch (Exception e) {				
			e.printStackTrace();
			paluuArvo=false;
		}				
		return paluuArvo;
	}	
}
