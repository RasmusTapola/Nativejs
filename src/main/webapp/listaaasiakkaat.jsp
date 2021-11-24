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
	<p>
	Hakusana:
	<input type="text" id="hakusana" name="hakusana">
	<input type="button" value="Hae" onclick="teeHaku()">
	</p>
<table id="listaus">
	<thead>
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
function teeHaku(){
	
$(document).ready(function(){
	$.ajax({
		url:"Asiakkaat",
		type:"GET",
		dataType:"json",
		success:function(result){
			
			$.each(result.asiakkaat, function(i, field){
				var htmlStr;
				var hakusana=document.getElementById("hakusana").value;
				htmlStr+="<tr>";
				htmlStr+="<td>"+field.etunimi+"</td>";
				htmlStr+="<td>"+field.sukunimi+"</td>";
				htmlStr+="<td>"+field.puh+"</td>";
				htmlStr+="<td>"+field.sposti+"</td>";
				htmlStr+="</tr>";
				
				if(htmlStr.includes(hakusana)){
					$("#listaus tbody").append(htmlStr);
				}
			});
		}});
	})
	
	};
</script>
</body>
</html>