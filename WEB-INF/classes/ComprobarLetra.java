import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import pojos.*;

public class ComprobarLetra extends HttpServlet{
	
	public void proceso (HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		HttpSession miSesion = request.getSession();
		
		Partida partida = (Partida) miSesion.getAttribute("miPartida");
		char[] miPalabra = partida.getMiPalabra();
		char[] palabraAcertada = partida.getPalabraAcertada();
		String letraIntr = request.getParameter("letraIntroducida");
		char letra = letraIntr.charAt(0);
		partida.getLetrasUsadas().add(letra);
		boolean acierto = false;
		
		for(int i = 0; i < miPalabra.length; i++){
			if(miPalabra[i] == letra){
				acierto = true;
				partida.addAcierto();
				partida.addPuntos(2);
				palabraAcertada[i] = letra;
			}
		}
		if(!acierto){
			partida.addFallo();
			partida.addPuntos(-1);
		}
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