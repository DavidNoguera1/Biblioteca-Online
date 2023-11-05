/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package umariana.tareas;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletContext;

/**
 *
 * @author David Noguera
 */
// En esta clase se crearan todos los metodos que involucren a los usuarios
// Esto incluye tambien su array list
public class MetodosU {

    public static ArrayList<Usuario> darUsuarios = new ArrayList<>();

    //Metodo para guardar los Usuarios en archivo
    public static void guardarUsuario(ArrayList<Usuario> usuarios, ServletContext context) throws IOException {
        String relativePath = "/data/usuarios.txt";
        String absPath = context.getRealPath(relativePath);

        try (BufferedWriter escritor = new BufferedWriter(new FileWriter(absPath))) {
            for (Usuario usuario : usuarios) {
                String linea = usuario.getCedula() + ","
                        + usuario.getNombre() + ","
                        + usuario.getContrasenia();
                escritor.write(linea);
                escritor.newLine();
            }
            System.out.println("Datos de usuarios guardados exitosamente en: usuarios.txt");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error al guardar los datos de usuarios: " + e.getMessage());
        }
    }

    // Método para cargar los usuarios desde el archivo
    public static ArrayList<Usuario> cargarUsuario(ServletContext context) throws IOException {
        ArrayList<Usuario> darUsuarios = new ArrayList<>();

        String relativePath = "/data/usuarios.txt";
        String absPath = context.getRealPath(relativePath);

        try (BufferedReader lector = new BufferedReader(new FileReader(absPath))) {
            String linea = lector.readLine();
            while (linea != null) {
                String[] datos = linea.split(",");
                if (datos.length == 3) {
                    String cedula = datos[0];
                    String nombre = datos[1];
                    String contrasenia = datos[2];

                    Usuario nuevoUsuario = new Usuario();
                    nuevoUsuario.setCedula(cedula);
                    nuevoUsuario.setNombre(nombre);
                    nuevoUsuario.setContrasenia(contrasenia);

                    darUsuarios.add(nuevoUsuario);
                } else {
                    // Manejo del caso de que la línea no tenga los datos esperados
                    System.out.println("La línea no contiene los datos esperados: " + linea);
                }
                linea = lector.readLine();
            }
            System.out.println("Datos de usuarios cargados exitosamente desde: usuarios.txt");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error al cargar los datos de usuarios: " + e.getMessage());
        }
        return darUsuarios;
    }

    // Método para verificar el inicio de sesión de un usuario
    public static String loginUsuario(String cedula, String contrasenia, ServletContext context) throws IOException {
        // Cargar la lista de usuarios desde el archivo
        ArrayList<Usuario> usuarios = cargarUsuario(context);

        // Iterar a través de la lista de usuarios y verificar las credenciales
        for (Usuario usuario : usuarios) {
            if (usuario.getCedula().equals(cedula) && usuario.getContrasenia().equals(contrasenia)) {
                // Las credenciales coinciden, usuario autenticado
                return usuario.getNombre(); // Devolver el nombre de usuario
            }
        }

        // Si no se encontró ninguna coincidencia, el inicio de sesión falla
        return null;
    }

}
