/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.jd.biblioteca;
import java.io.Serializable;

/**
 *
 * @author juand
 * Esta clase manejara los atributos de los libros a añadirse
 */
public class Libro implements Serializable {
    public String titulo;
    public String autor;
    public String anio;
    public String foto;

    public Libro() {
    }

    public Libro(String titulo, String autor, String anio, String foto) {
        this.titulo = titulo;
        this.autor = autor;
        this.anio = anio;
        this.foto = foto;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public String getAnio() {
        return anio;
    }

    public void setAnio(String anio) {
        this.anio = anio;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }
    
    
}
