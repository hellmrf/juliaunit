# Other languages

Em português e em diversos idiomas, como o alemão, o separador de decimais é a vírgula.
Este exemplo mostra como isso pode ser configurado no pacote `siunitx`.

## Compilação

Primeiro de tudo: coloque o `juliaunit.sty` no diretório do arquivo .tex ou no `texmf` local.

Este mini-projeto contém um arquivo `.latexmkrc` que é responsável por configurar o `latexmk` de forma que funcione corretamente com o PythonTeX. Então, para compilar este exemplo, simplesmente execute:

```shell
latexmk main.tex
```

Entretanto, você pode usar o workflow padrão descrito no README.