Algoritmo "Campo_Minado"
// Autor(a)    : Alison Luiz da Silva
Var

   tabela: vetor [1..10,1..10] de inteiro
   tabela_real: vetor [1..10,1..10] de caracter
   qtdMinas: inteiro

   // ######################################################################
   //                         FAZENDO SORTEIO DAS MINAS
procedimento sorteio_minas(minas: inteiro)
var
   x, y: inteiro
   control: inteiro
inicio
   control <- 0
   enquanto control <> minas faca
      x <- randi(10)+1
      y <- randi(10)+1
      se (tabela[x,y] = 0) entao
         tabela[x,y] <- 99
         control <- control + 1
      fimse
   fimenquanto
   distanciaminas_parte_um
fimprocedimento
// ######################################################################
//                      DEFINIR DISTANCIA DAS MINAS
procedimento distanciaminas_parte_um
var
   x, y: inteiro
inicio
   para x de 1 ate 10 faca
      para y de 1 ate 10 faca
         tabela_real[x,y] <- "X"
         se (tabela[x,y] <> 99) entao
            distanciaminas_parte_dois(x,y)
         fimse
      fimpara
   fimpara
   exibirtabela
fimprocedimento
procedimento distanciaminas_parte_dois(x,y: inteiro)
var
   x1, x2, y1, y2, control: inteiro
inicio
   control <- 0
   x1 <- x - 1
   y1 <- y - 1
   x2 <- x + 1
   y2 <- y + 1
   enquanto x1 <= x2 faca
      enquanto y1 <= y2 faca
         se (x1 >= 1) e (x1 <= 10) e (y1 >= 1) e (y1 <= 10) entao
            se (tabela[x1,y1] = 99) entao
               control <- control + 1
            fimse
         fimse
         y1 <- y1 + 1
      fimenquanto
      y1 <- y - 1
      x1 <- x1 + 1
   fimenquanto
   tabela[x,y] <- control
fimprocedimento
// ######################################################################
//                           ESCREVER MATRIZ NA TELA
procedimento exibirtabela
var
   x,y: inteiro
   control: inteiro
inicio
   control <- 1
   escreval
   para x de 1 ate 10 faca
      escreva(" ",numpcarac(x), " ")
   fimpara
   escreva(" <- COLUNA")
   escreval
   para x de 1 ate 10 faca
      para y de 1 ate 10 faca
         escreva(" ",tabela_real[x,y], " ")
      fimpara
      escreva(numpcarac(control))
      control <- control + 1
      escreval
   fimpara
   escreval
   pergunta
fimprocedimento
// ######################################################################
//                         PERGUNTAR QUAL LINHA E COLUNA
procedimento pergunta
var
   linha, coluna: inteiro
inicio
   repita
      escreval("Coluna? ")
      leia(coluna)
   ate (coluna >= 1) e (coluna <= 10)
   repita
      escreval("Linha? ")
      leia(linha)
   ate (linha >= 1) e (linha <= 10)
   tabela_real[linha,coluna] <- numpcarac(tabela[linha,coluna])
   limpatela
   se (tabela[linha,coluna] = 99) entao
      tabela_real[linha,coluna] <- carac(157)
      finalizarjogo
   senao
      exibirtabela
   fimse
fimprocedimento
// ######################################################################
procedimento finalizarjogo
var
   x,y: inteiro
   control: inteiro
inicio
   control <- 1
   escreval
   para x de 1 ate 10 faca
      escreva(" ",numpcarac(x), " ")
   fimpara
   escreva(" <- COLUNA")
   escreval
   para x de 1 ate 10 faca
      para y de 1 ate 10 faca
         escreva(" ",tabela_real[x,y], " ")
      fimpara
      escreva(numpcarac(control))
      control <- control + 1
      escreval
   fimpara
   escreval
   escreval("VOCÊ PERDEU KKK")
   timer(10)
   explosao
fimprocedimento
// ######################################################################
procedimento explosao
inicio
limpatela
escreval()
escreval("             . . .")
escreval("              \|/")
escreval("            `--+--'")
escreval("              /|\")
escreval("             ' | '")
escreval("               |")
escreval("               |")
escreval("           ,--'#`--.")
escreval("           |#######|")
escreval("        _.-'#######`-._")
escreval("     ,-'###############`-.")
escreval("   ,'#####################`,")
escreval("  /#########################\")
escreval(" |###########################|")
escreval("|#############################|")
escreval("|#############################|")
escreval("|#############################|")
escreval("|#############################|")
escreval(" |###########################|")
escreval("  \#########################/")
escreval("   `.#####################,'")
escreval("     `._###############_,'")
escreval("        `--..#####..--'")
fimprocedimento
// ######################################################################
Inicio
   sorteio_minas(15)
Fimalgoritmo