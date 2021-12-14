<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="pojos.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="jugador" scope="session" class="pojos.Jugador"/>
<jsp:setProperty name="jugador" property="addPuntos" value="${sessionScope.miPartida.puntos}"/>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Juego Ahorcado</title>
		<link rel="stylesheet" href="style.css">
	</head>
	<body>
		<h1>Gracias por jugar, ${sessionScope.miPartida.nombreUsu}</h1>
		<h3>Recuerda que tus puntos se guardarán en este usuario.</h3>
		<h3>Puntos hasta ahora: ${sessionScope.miPartida.puntos}</h3>
		<% session.invalidate(); %>
		<form action="index.jsp">
			<input type="submit" class="btn_sub" value="Volver a inicio"/>
		</form>
 	</body>
</html>

