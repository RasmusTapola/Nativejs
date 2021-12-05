<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>Insert title here</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelinnumero</th>
				<th>Sähköposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puh" id="puh"></td>
				<td><input type="text" name="sposti" id="sposti"></td>
				<td><input type="submit" id="tallenna" value="Hyväksy"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="vanhaetunimi" id="vanhaetunimi">
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	var etunimi = requestURLParam("etunimi");
	$.ajax({url:"Asiakkaat/haeyksi/"+etunimi, type:"GET", dataType:"json", success:function(result){
		$("#vanhaetunimi").val(result.etunimi);
		$("#etunimi").val(result.etunimi);
		$("#sukunimi").val(result.sukunimi);	
		$("#puh").val(result.puh);
		$("#sposti").val(result.sposti);
	}});
	
	$("#tiedot").validate({
		rules:{
			etunimi:{
				required: true,
				minlength: 3
			},
			sukunimi:{
				required: true,
				minlength: 3
			},
			puh:{
				required: true,
				minlength: 3
			},
			sposti:{
				required: true,
				email: true
			}
		},
		messages: {
			etunimi:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sukunimi:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			puh:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sposti:{
				required: "Puuttuu",
				email: "Ei kelpaa"
		}
	},
		submitHandler: function(form){
		muutaTiedot();
		}
	});
	});

	function muutaTiedot(){
		var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
		$.ajax({url:"Asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result){
			if(result.response==0){
				$("#ilmo").html("Asiakkaan muuttaminen epäonnistui.");
			}
			else if (result.response==1){
				$("#ilmo").html("Asiakkaan muuttaminen onnistui.");
				$("#etunimi", "#sukunimi", "#puh","#sposti").val("");
			}
			}});
	}
</script>
</html>