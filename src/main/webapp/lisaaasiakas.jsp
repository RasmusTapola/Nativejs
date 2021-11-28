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
				<td><input type="submit" id="tallenna" value="Lisää"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});

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
			minlength: 8
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
			minlength: "Liian lyhyt"
	}
},
	submitHandler: function(form){
	lisaaTiedot();
	}
});
});

function lisaaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result){
		if(result.response==0){
			$("#ilmo").html("Auton lisääminen epäonnistui.");
		}
		else if (result.response==1){
			$("#ilmo").html("Auton lisääminen onnistui.");
			$("#etunimi", "#sukunimi", "#puh","#sposti").val("");
		}
		}});
}
</script>
</html>