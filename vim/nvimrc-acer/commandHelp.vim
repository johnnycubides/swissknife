function CommandHelp()
  let txt = "\tf, F -> buscar letra hacia adelante o hacia atrás\n"
  let txt .= "\t\\text n, N -> buscar texto en el documento y rastrear coincidencias\n"
  let txt .= "\t% -> ir al inicio o final de un ambito tipo {} () otros.\n"
  let txt .= "\t0 $ -> Ir al inicio o final de una línea\n"
  let txt .= "\t* # -> buscar palabra bajo el cursor (adelante/atrás)\n"
  let txt .= "\tz-t, z-z, z-b, -> cursor en top, medio, botton del documento\n"
  let txt .= "\tu -> deshacer, ^r -> rehacer\n"
  let txt .= "\to, O -> Crear nueva linea arriba o abajo del cursor\n"
  let txt .= "\tgg, G ir al inicio o al final del documento a editar\n"
  let txt .= "\t[-s, ]-s -> Mostrar opciones de spell\n"
  let txt .= "\tv-w, v-b, v-e -> Ir adelante, hacia atrás y al final de una palabra\n"
  let txt .= "\tv-g-c -> quitar o poner en comentario la línea bajo el cursor\n"
  let txt .= "\tdd, yy, p -> Borrar, copiar y pegar línea, ej: 3yy, 3dd, 3p\n"
  let txt .= "\t%s/palabra/nueva_palabra/g sustituir de manera general, otro ej: 1,2s/palabra/nueva_palabra/g\n"
  let txt .= "\tm-letra, '-letra, marks -> marcar una línea con una letra, ir a la línea marcada por la letra, ver marcas\n"
  let txt .= "\tnum-j, num-k, num-h, num-l -> subir o bajar num filas o columnas\n"
  let txt .= "\t,-b -> Abrir menu de buffers abiertos\n"
  let txt .= "\t,-v, ,-h -> abrir buffer vertical y horizontal\n"
  let txt .= "\t\n"
  let txt .= "\t\n"
  return txt
endfunction

nnoremap <F12> :echo CommandHelp()<CR>
