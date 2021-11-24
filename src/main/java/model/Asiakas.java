package model;

public class Asiakas {
	private String etunimi, sukunimi, puh, sposti;

	public Asiakas() {
		super();
		
	}

	public Asiakas(String etunimi, String sukunimi, String puh, String sposti) {
		super();
		this.etunimi = etunimi;
		this.sukunimi = sukunimi;
		this.puh = puh;
		this.sposti = sposti;
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
		return "Asiakas [etunimi=" + etunimi + ", sukunimi=" + sukunimi + ", puh=" + puh + ", sposti=" + sposti + "]";
	}
	
}
