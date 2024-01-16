## Actividad 1 - Descripción de base de datos.

Se utiliza la siguiente estructura de datos dummy.

```
{
  "libros": [
    {
      "id": 1,
      "titulo": "El Aleph",
      "autor": {
        "nombre": "Jorge Luis Borges",
        "nacionalidad": "Argentino"
      },
      "publicacion": {
        "anio": 1949,
        "editorial": "Sur"
      },
      "generos": ["Ficción", "Fantasía"],
      "calificacion": 4.5
    },
    {
      "id": 2,
      "titulo": "Cien años de soledad",
      "autor": {
        "nombre": "Gabriel García Márquez",
        "nacionalidad": "Colombiano"
      },
      "publicacion": {
        "anio": 1967,
        "editorial": "Sudamericana"
      },
      "generos": ["Realismo mágico", "Novela"],
      "calificacion": 5.0
    }
  ]
}
```

En este ejemplo:

- **libros**: Es una colección de documentos, cada uno representando un libro.
- **id**: Identificador único del libro (tipo de dato: entero).
- **titulo**: Título del libro (tipo de dato: cadena de texto).
- **autor**: Objeto que representa al autor del libro.
- **nombre**: Nombre del autor (tipo de dato: cadena de texto).
- **nacionalidad**: Nacionalidad del autor (tipo de dato: cadena de texto).
- **publicacion**: Objeto que contiene información sobre la publicación del libro.
- anio: Año de publicación (tipo de dato: entero).
- **editorial**: Editorial del libro (tipo de dato: cadena de texto).
- **generos**: Lista de géneros del libro (tipo de dato: lista de cadenas de texto).
- **calificacion**: Calificación del libro (tipo de dato: número decimal).