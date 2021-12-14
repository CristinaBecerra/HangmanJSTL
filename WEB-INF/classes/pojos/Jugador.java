package pojos;
import java.util.*;

public class Jugador{
	private String nombreUsu;
	private String passwd;
	private int puntuacion;
	private ArrayList<String> palabrasJugadas;
	
	public Jugador(){
		puntuacion = 0;
		palabrasJugadas = new ArrayList();
	}
	
	public Jugador(String nombreUsu, String passwd, int puntuacion){
		this.nombreUsu = nombreUsu;
		this.passwd = passwd;
		this.puntuacion = puntuacion;
		palabrasJugadas = new ArrayList();
	}
	
	/*........Getter y Setters.......................................*/
	public String getNombreUsu(){
		return this.nombreUsu;
	}
	
	public void setNombreUsu(String nombreUsu){
		this.nombreUsu = nombreUsu;
	}
	
	public String getPasswd(){
		return this.passwd;
	}
	
	public void setPasswd(String passwd){
		this.passwd = passwd;
	}
	
	public int getPuntuacion(){
		return this.puntuacion;
	}
	
	public void setPuntuacion(int puntuacion){
		this.puntuacion = puntuacion;
	}
	
	public ArrayList<String> getPalabrasJugadas(){
		return this.palabrasJugadas;
	}
	
	public void setPalabrasJugadas(ArrayList<String> nuevasPalabras){
		this.palabrasJugadas = nuevasPalabras;
	}
	
	/*...............Otros Métodos....................................*/
	public void setAddPuntos(int puntosNuevos){
		this.puntuacion += puntosNuevos;
	}
	
	public void setPalabraUsada(char[] palabra){
		String prueba = new String(palabra);
		this.palabrasJugadas.add(prueba);
	}
}