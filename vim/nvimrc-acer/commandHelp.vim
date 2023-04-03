function CommandHelp()
  let txt = "\n"
  let txt .= "\t^f, ^b \t\t-> Adelante o atrás página completamente\n"
  let txt .= "\t^d, ^u \t\t-> Adelante o atrás media página\n"
  let txt .= "\tf, F \t\t-> buscar letra hacia adelante o hacia atrás\n"
  let txt .= "\t/text n, N \t-> buscar texto en el documento y rastrear coincidencias\n"
  let txt .= "\t% \t\t-> ir al inicio o final de un ambito tipo {} () otros.\n"
  let txt .= "\t0 $ \t\t-> Ir al inicio o final de una línea\n"
  let txt .= "\t* # \t\t-> buscar palabra bajo el cursor (adelante/atrás)\n"
  let txt .= "\tz-t, z-z, z-b, \t-> cursor en top, medio, botton del documento\n"
  let txt .= "\tu ^r\t\t-> deshacer, rehacer\n"
  let txt .= "\to, O \t\t-> Crear nueva linea arriba o abajo del cursor\n"
  let txt .= "\tgg, G \t\t-> ir al inicio o al final del documento a editar\n"
  let txt .= "\t[-s, ]-s \t-> Mostrar opciones de spell\n"
  let txt .= "\tv-w, v-b, v-e \t-> Ir adelante, hacia atrás y al final de una palabra\n"
  let txt .= "\tv-g-c \t\t-> quitar o poner en comentario la línea bajo el cursor\n"
  let txt .= "\tdd, yy, p \t-> Borrar, copiar y pegar línea, ej: 3yy, 3dd, 3p\n"
  let txt .= "\t,-b \t\t-> Abrir menu de buffers abiertos\n"
  let txt .= "\t,-v, ,-h \t-> abrir buffer vertical y horizontal\n"
  let txt .= "\tGrep\t\t-> Buscar una palabra en este directorios\n"
  let txt .= "\t%s/palabra/nueva_palabra/g \t-> sustituir de manera general, otro ej: 1,2s/palabra/nueva_palabra/g\n"
  let txt .= "\tm-letra, '-letra, marks \t-> marcar una línea con una letra, ir a la línea marcada por la letra, ver marcas\n"
  let txt .= "\tnum-j, num-k, num-h, num-l \t-> subir o bajar num filas o columnas\n"
  let txt .= "\t\n"
  let txt .= "\t\n"
  return txt
endfunction

nnoremap <F12> :echo CommandHelp()<CR>
