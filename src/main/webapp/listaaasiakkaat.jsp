<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<title>Insert title here</title>
<style>
th{
	color: white;
	border-radius: 10px;
	background: black;
	padding:screenwidth;
	width: screenwidth;
	height: 30px;
}</style>
<style>
tbody{
	color: white;
	border-radius: 10px;
	background: black;
	padding: 10px;
	width: screenwidth;
	height: 30px;
}
</style>
<style>
p{
	color: white;
	border-radius: 10px;
	background: black;
	padding: 10px;
	width: 300px;
	height: 30px;
	text-align:center;
}</style>
</head>
<body onkeydown="tutkiKey(event)">
<table id="listaus">
<thead>
		<tr>
			<th colspan="4">
			<th><a id="uusiAsiakas" href="lisaaasiakas.jsp">Lisää uusi asiakas</a></th>
		</tr>
		<tr>
			<th colspan="3"><span id="poistaAsiakas">Poista asiakas</span></th>
			<th><input type="button" value="Poista" id="poistonappi"></th>
		</tr>
	<tr>
	<th> Hakusana:</th>
	<th colspan="2"><input type="text" id="hakusana"></th>
	<th><input type="button" value="Hae" id="hakunappi" onclick="haeTiedot()"></th>
	</tr>

	
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelinnumero</th>
			<th>Sähköposti</th>
		</tr>
	</thead>
	<tbody id="tbody">
	</tbody>
</table>
<script>	

document.getElementById("hakusana").focus();

function tutkiKey(event){
	if(event.keyCode==13){
		haeTiedot();
	}		
}

function haeTiedot(){	
	document.getElementById("tbody").innerHTML = "";
	fetch("Asiakkaat/" + document.getElementById("hakusana").value,{
	      method: 'GET'
	    })
	.then(function (response) {
		return response.json()	
	})
	.then(function (responseJson) {		
		var asiakkaat = responseJson.Asiakkaat;	
		var htmlStr="";
		for(var i=0;i<asiakkaat.length;i++){			
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+asiakkaat[i].etunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].sukunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].puhelin+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].sposti+"</td>";  
        	htmlStr+="<td><a href='muutaasiakas.jsp?etunimi="+asiakkaat[i].etunimi+"'>Muuta</a>&nbsp;";
        	htmlStr+="<span class='poista' onclick=poista('"+asiakkaat[i].etunimi+"')>Poista</span></td>";
        	htmlStr+="</tr>";        	
		}
		document.getElementById("tbody").innerHTML = htmlStr;		
	})	
}

function poista(etunimi){
	if(confirm("Poista asiakas " + etunimi + " " + sukunimi +"?")){	
		fetch("Asiakkaat/" + etunimi,{
		      method: 'DELETE'		      	      
		    })
		.then(function (response) {
			return response.json()
		})
		.then(function (responseJson) {	
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Asiakkaan poisto epäonnistui.";
	        }else if(vastaus==1){	        	
	        	document.getElementById("ilmo").innerHTML="Asiakkaan " + etunimi + " " + sukunimi +" poisto onnistui.";
				haeTiedot();        	
			}	
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		})		
	}	
}

	
</script>
</body>
</html>