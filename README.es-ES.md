# Apple Music to Discord (M2D)
<img width="286" alt="image" src="https://github.com/user-attachments/assets/b9d2e79f-6176-4dc8-86e0-d5f91852d1d5">

Muestra tu estado de reproducción de Apple Music en Discord.

<!--
<a href='https://github.com/0xWDG/Apple-Music-to-Discord/raw/main/AM2D.zip'>
  <img alt="Download" src="https://img.shields.io/badge/Download-Beta-6bbee8?style=for-the-badge">
</a>
-->
 
# Funciones completadas
- [x] Leer información de la canción actual desde Apple Music
- [x] Actualizar la presencia de Discord para mostrar la información
- [x] Obtener la portada del álbum
- [x] Soporte de indicador para estados de Detenido/Reproduciendo/Pausa
- [x] Eliminar el requisito de iniciar Discord primero (reintentar conexión al fallar)
- [x] Verificar si Apple Music ha iniciado para la información inicial de la canción (ahora la información se obtendrá al conectar con Discord)
- [x] Hacer que los botones `<` (atrás), `=` (pausa), `>` (siguiente) funcionen.
- [x] ~~Eliminar el spinner si falla la carga de la portada.~~ El spinner ahora tiene el mismo tamaño que la portada y se ocultará si falla.
- [x] Soporte para inicio automático al iniciar sesión
- [x] Mejor manejo de errores

# Cómo usar

Abre `AM2D.xcodeproj` y cambia `DISCORD_API_KEY.swift` para incluir tu propia clave API de Discord.  
Puedes crear una (gratis) en https://discord.com/developers/applications

Asegúrate de ir a `YOUR_APP_NAME` -> `Settings` -> `Rich Presence` -> `Art Assets` y subir el logo de Apple Music allí (llamado `am`) o usar el logo de tu propia aplicación.

# Depuración

Para ver más información sobre lo que está sucediendo:
- Puedes mantener presionada la tecla `Option` y hacer clic en el icono de `M2D` en la barra de menús.
- Puedes abrir la aplicación Consola y buscar `nl.wesleydegroot.am2d`.

# Capturas de pantalla
<table>
  <tr>
    <th>AM2D</th>
    <td>Discord</td>
  </tr>
  <tr>
    <td>
      <img width="392" alt="image" src="https://github.com/user-attachments/assets/f2734a81-ff49-4b28-979c-2b9cb3cac78a">
    </td>
    <td>
      <img width="230" alt="image" src="https://github.com/0xWDG/Apple-Music-to-Discord/assets/1290461/ee99c9db-2e3d-44d6-af20-351629d67ac8"><br />
      <img width="286" alt="image" src="https://github.com/user-attachments/assets/b9d2e79f-6176-4dc8-86e0-d5f91852d1d5">
    </td>
  </tr>
</table>

# FAQ

<details><summary>¿Llegará esta aplicación a la App Store?</summary>Probablemente no, ya que no funciona con el sandbox habilitado.</details>

# Soporte / Reporte de errores

Por favor, [crea un issue](https://github.com/0xWDG/Apple-Music-to-Discord/issues/new).

## Contacto

🦋 [@0xWDG](https://bsky.app/profile/0xWDG.bsky.social)
🐘 [mastodon.social/@0xWDG](https://mastodon.social/@0xWDG)
🐦 [@0xWDG](https://x.com/0xWDG)
🧵 [@0xWDG](https://www.threads.net/@0xWDG)
🌐 [wesleydegroot.nl](https://wesleydegroot.nl)
🤖 [Discord](https://discordapp.com/users/918438083861573692)

¿Interesado en aprender más sobre Swift? [Visita mi blog](https://wesleydegroot.nl/blog/).


# Cambios

17-NOV-2024:
- Pequeñas mejoras.
- Limpieza de código.
- Proyecto liberado como código abierto.
- README actualizado para ser más informativo.
- Capturas de pantalla actualizadas.

<details>
  <summary>15-DEC-2023</summary>
  &bull; Los botones de Reproducir/Pausa, Anterior y Siguiente ya funcionan<br />
  &bull; Corrección del tiempo restante incorrecto al cambiar a una nueva canción<br />
  &bull; GUI ligeramente actualizada.<br>
  <strong>Revisión 1</strong><br>
  &bull; Reintentar si no se encuentra Discord.<br />
  &bull; Verificar si Apple Music se está ejecutando.<br />
  &bull; Eliminar el requisito de iniciar todo en un orden particular.
</details>
<details><summary>05-DEC-2023</summary>&bull; Versión inicial.</details>
