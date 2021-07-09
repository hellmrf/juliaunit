# "Report" Workflow

Este exemplo mostra como é possível utilizar um arquivo .jl externo para
testar o código antes de inclui-lo no documento final.

## Compilação

Primeiro de tudo: coloque o `juliaunit.sty` no diretório do arquivo .tex ou no `texmf` local.

Este mini-projeto contém um arquivo `.latexmkrc` que é responsável por 
configurar o `latexmk` de forma que funcione corretamente com o PythonTeX.
Então, para compilar este exemplo, simplesmente execute:

```shell
latexmk main.tex
```

Entretanto, você pode usar o workflow padrão descrito no README.