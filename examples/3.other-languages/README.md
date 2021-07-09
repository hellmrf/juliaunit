# "Multiple Questions" Workflow

Ao resolver uma série de exercícios semelhantes, é comum que as mesmas variáveis sejam utilizadas em questões diferentes e, logicamente, com valores diferentes.
Nesse caso, não é viável utilizar o workflow "report", já que apenas a última aparição de cada variável se aplicaria a todas as questões.

Este mini-projeto propõe um workflow para esse tipo de caso.

## Compilação

Primeiro de tudo: coloque o `juliaunit.sty` no diretório do arquivo .tex ou no `texmf` local.

Este mini-projeto contém um arquivo `.latexmkrc` que é responsável por configurar o `latexmk` de forma que funcione corretamente com o PythonTeX. Então, para compilar este exemplo, simplesmente execute:

```shell
latexmk main.tex
```

Entretanto, você pode usar o workflow padrão descrito no README.