/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.jd.biblioteca;

/**
 *
 * @author David Noguera
 */
// Definimos los atributos que se le asignaran a cada usuario
public class Usuario {
    
    private String cedula;
    private String nombre;
    private String contrasenia;

    public Usuario() {
    }

    public Usuario(String cedula, String nombre, String contrasenia) {
        this.cedula = cedula;
        this.nombre = nombre;
        this.contrasenia = contrasenia;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }

  
    
    
}

