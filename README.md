# John Conway's Game Of Life

Nossa versão do game of life, feita para rodar no processador do Simões.
Link para o repositório do processador do ICMC (A.K.A. processador do Simões): https://github.com/simoesusp/Processador-ICMC

## 1. Como rodar isso na sua máquina

### 1.1 Caso vc use Linux

Abra seu terminal e digite:

```sh
git clone git@github.com:Gaius10/assembly-game-of-life.git
cd assembly-game-of-life
make run
```
### 1.2 Caso vc use Windows

Desinstale seu sistema operacional, instale alguma distro Linux e então pule para o capítulo 1.1

## 2. Organização das pastas

<pre>
<b>bin</b>
 |- <i>linker<i>: Executável responsável por efetivar diretivas do tipo #include (arquivo python)
 |- <i>montador</i>: Montador disponibilizado pelo Simões (pré-compilado)
 |- <i>simulador</i>: Simulador disponibilizado pelo Simões (pré-compilado)
</pre>

<pre>
<b>build</b>
  Pasta onde ficam os arquivos temporários usados nas etapas de montagem e execução do projeto.
</pre>

<pre>
<b>config</b>
  Arquivos de configuração.
</pre>

<pre>
<b>docs</b>
  Documentos úteis disponibilizados pelo Simões, colocados aqui para maior praticidade nas consultas.
</pre>
<pre>
<b>exemplos</b>
  Exemplos de alguns projetos antigos que rodam no simulador, colocados aqui para maior praticidade nas consultas.
</pre>
<pre>
<b>src</b>
  Arquivos fonte do seu projeto. Essa pasta deve, obrigariamente, conter ao menos um arquivo *main.asm* contendo os codigos de inicialização do seu programa.
</pre>
<pre>
<b>static</b>
  Arquivos estáticos do projeto (ex.: charmaps)
</pre>
## 3. Convenções

- r0 reservado para retorno de funções
- Passagem de argumentos sempre feita do r7 para trás

## 4. Gostou do framework? Quer copiar a gente?

Um esqueleto desse repositório ficará disponível em algum lugar do github.
Ele conterá apenas nosso makefile, os utilitários e a estrutura de pastas, é só baixar e começar a codar em assembly!

## 5. Como adicionar/editar cenários

Acessar o arquivo config/scenario_custom.asm e editá-lo com o cenário inicial de seu interesse ('@'s representam celulas vivas), em seguida executar o programa.
