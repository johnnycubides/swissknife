---
pagetitle: "Ejemplo de presentación con md2reveal"
lang: es
---

# Mi presentación

Una idea principal por diapositiva.

**Autor:** Nombre del presentador  
**Fecha:** Por definir

::: notes
Estas notas no aparecen en la pantalla del público.
Al abrir el HTML desde un servidor local, pulsa S para abrir la ventana
del presentador. Permite ventanas emergentes si el navegador las bloquea.

Para convertir este ejemplo desde bash/pandoc:

    ./md2reveal ejemplo-presentacion.md

O con recursos externos compartidos:

    ./md2reveal --assets ejemplo-presentacion.md
:::

---

# Objetivo y agenda

* Explicar el problema.
* Comparar dos opciones.
* Acordar el siguiente paso.

**Duración propuesta: 10 minutos.**

::: notes
El encabezado de nivel 1 es el título de la diapositiva.
Una línea con tres guiones, rodeada de líneas vacías, separa diapositivas.
El bloque YAML inicial configura los metadatos y no es una diapositiva.
:::

---

# El problema

**Situación:** necesitamos presentar información con claridad.

* Poco texto visible y títulos cortos.
* Explicaciones ampliadas en las notas.
* Dividir el contenido antes de reducir demasiado la letra.

::: notes
El script aplica un lienzo de 1280 x 720 y un estilo de presentación,
no el estilo de los informes HTML. Esto no evita automáticamente los
desbordamientos si agregamos demasiado contenido.
:::

---

# Comparar opciones

| Opción | Ventaja | Consideración |
|---|---|---|
| HTML autocontenido | Un archivo para presentar | Repite recursos en cada HTML |
| Carpeta assets | Reveal.js compartido | Trasladar HTML y assets juntos |

**Decisión:** elegir según cómo se distribuirán las presentaciones.

::: notes
--assets comparte el runtime y el CSS entre archivos del mismo directorio.
Las imágenes se separan por nombre de presentación para evitar colisiones.
No confundir una ventaja técnica con una decisión ya aprobada.
:::

---

# Mostrar comandos

Desde el directorio del ejemplo:

```bash
./md2reveal --assets ejemplo-presentacion.md
python3 -m http.server 8765 --bind 127.0.0.1
```

Abrir `http://127.0.0.1:8765/ejemplo-presentacion.html`.

::: notes
El servidor se ejecuta en la terminal y se detiene con Ctrl+C.
El convertidor no inicia servidores ni abre el navegador automáticamente.
La primera conversión requiere Internet para obtener Reveal.js.
:::

---

# Incorporar una imagen

Cuando tengas una imagen local, utiliza esta sintaxis:

```markdown
![Descripción de la imagen](images/diagrama.png){height=320px}
```

* La ruta se interpreta respecto al Markdown.
* Sustituye el ejemplo por un archivo que exista.
* Usa una diapositiva propia si el diagrama necesita espacio.

::: notes
El ejemplo anterior es código explicativo: no intenta cargar una imagen
inexistente. El texto entre corchetes describe la imagen; height limita
su altura en la diapositiva.
:::

---

# Cierre

* **Acuerdo:** qué se decidió.
* **Responsable:** quién acepta el siguiente paso.
* **Verificación:** qué resultado esperamos.

Preguntas y comentarios.

::: notes
Registrar los acuerdos fuera de la presentación cuando corresponda.
Las notas se escriben como bloques de Pandoc ::: notes, no con la sintaxis
Note: de reveal-md. No ejecutar esta fuente con reveal-md sin adaptarla.
:::
