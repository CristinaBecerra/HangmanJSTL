<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="pojos.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="juegoAhorcado" scope="application" class="pojos.Lista"/>
<jsp:useBean id="jugador" scope="session" class="pojos.Jugador">
	<jsp:include page="/ComprobarJugador"/>
</jsp:useBean>

<!--................Creamos bean de partida.......................-->
<jsp:useBean id="miPartida" scope="session" class="pojos.Partida">
	<jsp:setProperty name="miPartida" property="nombreUsu" value="${param.nombreUsu}"/>
</jsp:useBean>

<c:if test="${!empty param.letraIntroducida}">
	<jsp:include page="/ComprobarLetra"/>
</c:if>

<!--................Si le da a volver a jugar cambiamos palabra.......................-->
<c:if test="${!empty param.numPalabra}">
	<jsp:setProperty name="miPartida" property="cambiarPalabra" value="${juegoAhorcado.palabras.get(Integer.parseInt(param.numPalabra))}"/>
</c:if>

<!-- Si va a añadir palabras -->
<c:if test="${!empty param.nuevasPalabras}">
	<jsp:setProperty name="juegoAhorcado" property="cargarPalabras" value="${param.nuevasPalabras}"/>
</c:if>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Juego Ahorcado</title>
		<link rel="stylesheet" href="style.css">
	</head>
	<body>
		<div class="estadisticas">
			<h3>Estadísticas de partida</h3>
			<p><b>Nombre: </b>${sessionScope.miPartida.nombreUsu}</p>
			<p><b>Puntos de la partida anterior: </b>${sessionScope.jugador.puntuacion}</p>
			<p><b>Puntos: </b>${sessionScope.miPartida.puntos}</p>
			<p><b>Aciertos: </b>${sessionScope.miPartida.aciertos}</p>
			<p><b>Fallos: </b>${sessionScope.miPartida.fallos}</p>
		</div>
		<img src="img/${miPartida.fallos}.jpg" alt="Imagen del ahorcado por fases">
		<h1>La palabra oculta es...</h1>
	
	<!-- Si no es la primera vez que entra...-->
	<c:if test="${empty param.nombreUsu}">
		<div class="palabra">
		<c:forEach var="letra" items="${sessionScope.miPartida.palabraAcertada}" >
			<p class="guion">${letra}</p>
		</c:forEach>
		</div>
		<div class="teclado">
			<!--..........Pintamos un teclado con las letras......................-->
			<c:forEach var="tecla" items="${juegoAhorcado.abc}">
				<form action="Ahorcado.jsp">
					<input type="hidden" name="letraIntroducida" value="${tecla}"/>
				<c:if test="${sessionScope.miPartida.letrasUsadas.contains(tecla)}">
					<input type="submit" name="letraT" value="${tecla}" disabled />
				</c:if>
				<c:if test="${!sessionScope.miPartida.letrasUsadas.contains(tecla)}">
					<input type="submit" name="letraT" value="${tecla}" />
				</c:if>						
				</form>
			</c:forEach>
		</div>
		
		<!--..........Pintamos la pista.....................-->
		<c:if test="${sessionScope.miPartida.fallos lt 5 && miPartida.aciertos lt miPartida.getAciertosMax()}">
			<button id="pista" title="${String.valueOf(sessionScope.miPartida.miPalabra)}">PISTA</button>
		</c:if>
		
		<!--..........Si has perdido.....................-->
		<c:if test="${sessionScope.miPartida.fallos eq 5}">
			<h2 class="red">HAS PERDIDO, TE HAN AHORCAO</h2>
		</c:if>
		
		<!--..........Si has ganado o si es la primera vez que entras.....................-->
		<c:if test="${miPartida.aciertos eq miPartida.getAciertosMax()}">
			<jsp:setProperty name="jugador" property="palabraUsada" value="${miPartida.miPalabra}"/>
			<jsp:setProperty name="miPartida" property="limpiaEstadisticas" value="${prueba}"/>
			<h2 class="green">HAS GANADO...¡¡ENHORABUENA!!</h2>
		</c:if>
	</c:if>
	
	<!--.......Si es la primera vez que entra o si ha ganado que elija palabra..... -->
	<c:if test="${!empty param.nombreUsu || miPartida.aciertos eq miPartida.getAciertosMax()}">
		<jsp:setProperty name="miPartida" property="aciertos" value="${0}"/>
		<c:if test="${juegoAhorcado.getPalabrasNoJugadas(miPartida.nombreUsu).size() gt 0}">
			<h2>Escoge nueva palabra:</h2>
			<form action="Ahorcado.jsp">
				<select name="numPalabra">
					<c:forEach var="palabra" items="${juegoAhorcado.getPalabrasNoJugadas(miPartida.nombreUsu)}">
						<option value="${palabra.key}">Palabra ${palabra.key}</option>
					</c:forEach>
				</select>
				<input class="btn_sub" type="submit" value="Jugar palabra"/>
			</form>
		</c:if>
		<c:if test="${juegoAhorcado.getPalabrasNoJugadas(miPartida.nombreUsu).size() eq 0}">
			${juegoAhorcado.numPalabra+1}
			<h2 class="green">Has superado todas las palabras. Ahora eres superadmin!</h2>
			<h2>Añade todas las palabras nuevas que quieras separándolas por coma:</h2>
			<form action="Ahorcado.jsp">
				<input type="text" name="nuevasPalabras" placeholder="Escribe aquí tus nuevas palabras"/>
				<input type="hidden" name="numPalabra" value="${juegoAhorcado.numPalabra+1}">
				<input class="btn_sub" type="submit" value="Añadir Palabras">
			</form>
		</c:if>
	</c:if>
	
	<form action="Terminar.jsp">
		<input class="btn_sub" type="submit" value="Cerrar Sesión"/>
	</form>
 	</body>
</html>