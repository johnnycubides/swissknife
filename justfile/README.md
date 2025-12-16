# Docuemtation

jusfile [global-vars] <recipe> [posicional argumentes]

1. Todo lo que tenga = al principio
→ es una variable global

2. El primer token que NO tiene =
→ es el nombre de la receta

3. Todo lo que viene después
→ son argumentos posicionales de esa receta


* [Funtions for miscellaneous](https://just.systems/man/en/functions.html#fallible)

Fallible

*  absolute_path(path) - Absolute path to relative path in the working directory. absolute_path("./bar.txt") in directory /foo is /foo/bar.txt.
*  canonicalize(path)1.24.0 - Canonicalize path by resolving symlinks and removing ., .., and extra /s where possible.
*  extension(path) - Extension of path. extension("/foo/bar.txt") is txt.
*  file_name(path) - File name of path with any leading directory components removed. file_name("/foo/bar.txt") is bar.txt.
*  file_stem(path) - File name of path without extension. file_stem("/foo/bar.txt") is bar.
*  parent_directory(path) - Parent directory of path. parent_directory("/foo/bar.txt") is /foo.
*  without_extension(path) - path without extension. without_extension("/foo/bar.txt") is /foo/bar.

These functions can fail, for example if a path does not have an extension, which will halt execution.
