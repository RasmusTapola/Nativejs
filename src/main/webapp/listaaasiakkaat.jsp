<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
<body>
<table id="listaus">
<thead>
		<tr>
			<th colspan="4"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>
		<tr>
			<th colspan="3"><span id="poistaAsiakas">Poista asiakas</span></th>
			<th><input type="button" value="Poista" id="poistonappi"></th>
		</tr>
	<tr>
	<th> Hakusana:</th>
	<th colspan="2"><input type="text" id="hakusana" id="hakusana"></th>
	<th><input type="button" value="Hae" id="hakunappi"></th>
	</tr>

	
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelinnumero</th>
			<th>Sähköposti</th>
		</tr>
	</thead>
	<tbody>
	
	</tbody>
</table>
<script>	
$(document).ready(function(){
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	$("#poistonappi").click(function(){
		poista(etunimi);
	});
	haeAsiakkaat();
	$("#hakunappi").click(function(){
		haeAsiakkaat();
	});
	
	$(document.body).on("keydown", function(event){
		if(event.which==13){
			haeAsiakkaat();
		}
	});
	
	$("#hakusana").focus();
});

function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({
		url:"asiakkaat/"+$("#hakusana").val(),
		type:"GET",
		dataType:"json",
		success:function(result){
			
			$.each(result.asiakkaat, function(i, field){
				var htmlStr;
				htmlStr+="<tr>";
				htmlStr+="<td>"+field.etunimi+"</td>";
				htmlStr+="<td>"+field.sukunimi+"</td>";
				htmlStr+="<td>"+field.puh+"</td>";
				htmlStr+="<td>"+field.sposti+"</td>";
				htmlStr+="</tr>";
				$("#listaus tbody").append(htmlStr);
				});
			}});
		}
function poista(etunimi){
	if(confirm("Poista asiakas " + etunimi +"?")){
		$.ajax({url:"asiakkaat/"+etunimi, type:"DELETE", dataType:"json", success:function(result) { 
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+etunimi)
	        	alert("Asiakkaan " + etunimi +" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}
	
</script>
</body>
</html>