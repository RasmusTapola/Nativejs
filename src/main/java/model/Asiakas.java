package model;

public class Asiakas {
	private int asiakas_id;
	private String etunimi, sukunimi, puh, sposti;

	public Asiakas() {
		super();
		
	}

	public Asiakas(int asiakas_id, String etunimi, String sukunimi, String puh, String sposti) {
		super();
		this.asiakas_id =asiakas_id;
		this.etunimi = etunimi;
		this.sukunimi = sukunimi;
		this.puh = puh;
		this.sposti = sposti;
	}
	
	public int getAsiakas_id() {
		return asiakas_id;
	}
	
	public void setAsiakas_id(int asiakas_id) {
		this.asiakas_id = asiakas_id;
	}
	
	public String getEtunimi() {
		return etunimi;
	}

	public void setEtunimi(String etunimi) {
		this.etunimi = etunimi;
	}

	public String getSukunimi() {
		return sukunimi;
	}

	public void setSukunimi(String sukunimi) {
		this.sukunimi = sukunimi;
	}

	public String getPuh() {
		return puh;
	}

	public void setPuh(String puh) {
		this.puh = puh;
	}

	public String getSposti() {
		return sposti;
	}

	public void setSposti(String sposti) {
		this.sposti = sposti;
	}

	@Override
	public String toString() {
		return "Asiakas [asiakas_id=" + asiakas_id + "etunimi=" + etunimi + ", sukunimi=" + sukunimi + ", puh=" + puh + ", sposti=" + sposti + "]";
	}
	
}
