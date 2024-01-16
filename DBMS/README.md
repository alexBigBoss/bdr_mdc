# Manejador de DBMS

A continuación se describe los pasos para desplegar el manejador de base de datos mediante docker-compose.

**Nota**: El propósito solamente es para conocer detalles técnicos para desplegar el manejador y no tiene relación para alguna evaluación.

## Archivo de variables entorno

Las configuraciones descritas a continuación se debe configurar un archivo de variables de entorno para guardar los valores sensibles y los mismos no se encuentren expuestos en los repositorios públicos.

 1. **POSTGRES_USER**: 
 - **Descripción:** Especifica el nombre de usuario que se utilizará para conectarse al servidor PostgreSQL.
 - **Uso típico:** Se utiliza durante la instalación y configuración de PostgreSQL para establecer el nombre de usuario principal.
 2. **POSTGRES_PASSWORD:**
- **Descripción:** Define la contraseña asociada al usuario de PostgreSQL especificado en POSTGRES_USER.
- **Uso típico:** Necesaria para autenticarse en el servidor PostgreSQL. Asegura la seguridad de la cuenta de usuario.
3. **PGADMIN_DEFAULT_EMAIL:**
- **Descripción:** Establece la dirección de correo electrónico asociada al usuario predeterminado en PgAdmin.
- **Uso típico:** Utilizado durante la instalación y configuración de PgAdmin para establecer la dirección de correo electrónico predeterminada del administrador.
4. **PGADMIN_DEFAULT_PASSWORD:**
- **Descripción:** Define la contraseña asociada al usuario especificado en PGADMIN_DEFAULT_EMAIL para autenticarse en PgAdmin.
- **Uso típico:** Necesaria para iniciar sesión en la interfaz web de PgAdmin. Asegura la seguridad del acceso al administrador web.

## ¿Cómo correr?

Abrir una terminal o consola y correr el siguiente comando:

```sh
docker-compose --env-file .env up -d
```