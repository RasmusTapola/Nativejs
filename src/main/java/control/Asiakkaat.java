package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import model.Asiakas;
import model.dao.Dao;


@WebServlet("/Asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Asiakkaat() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doGet()");
		String pathInfo=request.getPathInfo();
		String hakusana = "";
		String strJSON = "";
		Dao dao = new Dao();
		ArrayList<Asiakas> asiakkaat;
		if(pathInfo==null) {
			asiakkaat = dao.listaaKaikki(hakusana);
			strJSON = new JSONObject().put("Asiakkaat", asiakkaat).toString();
		}
		else if(pathInfo.indexOf("haeyksi")!=-1) {
			 String etunimi = pathInfo.replace("/haeyksi/", "");
			 Asiakas asiakas = dao.etsiAsiakas(etunimi);
			 JSONObject JSON = new JSONObject();
			 JSON.put("etunimi", asiakas.getEtunimi());
			 JSON.put("sukunimi", asiakas.getSukunimi());
			 JSON.put("puh", asiakas.getPuh());
			 JSON.put("sposti", asiakas.getSposti());
			 strJSON = JSON.toString();
		}
		else {
			hakusana=pathInfo.replace("/", "");
			asiakkaat=dao.listaaKaikki(hakusana);
			strJSON = new JSONObject().put("Asiakkaat", asiakkaat).toString();
		}
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.println(strJSON);
 	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPost()");
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuh(jsonObj.getString("puh"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		if(dao.lisaaAsiakas(asiakas)) {
			out.println("response:1");
		}else {
			out.println("response:2");
		}
	}


	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()");
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		String vanhaetunimi = jsonObj.getString("vanhaetunimi");
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuh(jsonObj.getString("puh"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		if(dao.muutaAsiakas(asiakas, vanhaetunimi)) {
			out.println("response:1");
		}else {
			out.println("response:2");
		}
	}


	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()");	
		String pathInfo = request.getPathInfo();			
		int asiakas_id = Integer.parseInt(pathInfo.replace("/", ""));		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.poistaAsiakas(asiakas_id)){ 
			out.println("response:1");  
		}else{
			out.println("response:0");  
	
		}
		}
}
