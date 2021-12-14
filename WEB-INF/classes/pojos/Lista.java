package pojos;
import java.util.*;

public class Lista{
	private HashMap<Integer,String> palabras;
	private HashMap<String,Jugador> jugadores;
	private int numPalabra = 1;
	
	private static char[] abc = {'q','w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 'j',
	'k', 'l', 'ñ','z', 'x', 'c', 'v', 'b', 'n', 'm'};
	
	public Lista(){
		palabras = new HashMap();
		jugadores = new HashMap();
	}
	
	public Lista(HashMap<Integer,String> palabras, HashMap<String,Jugador> jugadores){
		this.palabras = palabras;
		this.jugadores = jugadores;
	}
	
	/*........Getter y Setters.......................................*/
	public char[] getAbc(){
		return this.abc;
	}
	
	public HashMap<Integer,String> getPalabras(){
		return this.palabras;
	}
	
	public void setPalabras(HashMap<Integer,String> palabras){
		this.palabras = palabras;
	}
	
	public HashMap<String,Jugador> getJugadores(){
		return this.jugadores;
	}
	
	public void setJugadores(HashMap<String,Jugador> jugadores){
		this.jugadores = jugadores;
	}
	
	public int getNumPalabra(){
		return this.numPalabra;
	}
	
	/*...............Otros Métodos....................................*/
	public Jugador obtenerJugador(String nick){
		return jugadores.get(nick);
	}
	
	public void setAddJugador(Jugador jug){
		jugadores.put(jug.getNombreUsu(), jug);
	}
	
	public void setCargarPalabras(String palabrasXml){
		String[] palabrasString = palabrasXml.split(",");
		
		for(String pal : palabrasString){
			palabras.put(numPalabra, pal);
			numPalabra++;
		}
	}
	
	public String getObtenerPalabra(String nombreJugador){
		ArrayList<String> palabrasJugadas = jugadores.get(nombreJugador).getPalabrasJugadas();
		String palabraElegida = palabras.get(numAleatorio(1, palabras.size()));
		while(palabrasJugadas.contains(palabraElegida)){
			palabraElegida = palabras.get(numAleatorio(1, palabras.size()));
		}
		return palabraElegida;
	}
	
	public HashMap<Integer,String> getPalabrasNoJugadas(String nombreUsu){
		HashMap<Integer,String> palabrasNoUsadas = new HashMap();
		ArrayList<String> palabrasJugadas = jugadores.get(nombreUsu).getPalabrasJugadas();
		
		for (Map.Entry<Integer, String> entry : palabras.entrySet()) {
			if(!palabrasJugadas.contains(entry.getValue())){
				palabrasNoUsadas.put(entry.getKey(),entry.getValue());
			}
		}
		
		return palabrasNoUsadas;
	}
	
	public static int numAleatorio(int min, int max){
		return (int) (Math.random()*(max-min))+min;
	}
}