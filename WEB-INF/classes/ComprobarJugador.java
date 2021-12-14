import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import pojos.*;

public class ComprobarJugador extends HttpServlet{
	
	public void proceso (HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		ServletContext contexto = getServletContext();
		HttpSession miSesion = request.getSession();
		
		Lista lista = (Lista) contexto.getAttribute("juegoAhorcado");
		HashMap<String,Jugador> jugadores = lista.getJugadores();
		String nombreUsuario = request.getParameter("nombreUsu");
		Jugador jug = (Jugador) miSesion.getAttribute("jugador");
		
		if(jugadores.containsKey(nombreUsuario)){
			jug = jugadores.get(nombreUsuario);
		}else{
			jug.setNombreUsu(nombreUsuario);
			jug.setPasswd(request.getParameter("passwd"));
			jugadores.put(nombreUsuario, jug);
		}
		
		miSesion.setAttribute("jugador", jug);
	}
	
	@Override
	protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		proceso(request,response);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		proceso(request,response);
	}
}