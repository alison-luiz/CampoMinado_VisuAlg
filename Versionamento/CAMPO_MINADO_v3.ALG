Algoritmo "Campo_Minado"
// Autor(a)    : Alison Luiz da Silva
Var

   tabela: vetor [1..10,1..10] de inteiro // TABELA QUE CONTERA OS VALORES DAS MINAS EM VOLTA
   tabela_real: vetor [1..10,1..10] de caracter // TABELA QUE SERA MOSTRADA AO JOGADOR
   tabela_ganhador: vetor [1..10,1..10] de inteiro // TABELA DE CONTROLE PARA VALIDAR SE GANHOU O GAME
   qtdMinas: inteiro  // VALOR DA QUANTIDADE DE MINAS P/ VALIDAR O GANHADOR

   // ######################################################################
   //                     RESETANDO AS TEBELAS (NOVO GAME)
procedimento reset
var
   x, y: inteiro
inicio
   para x de 1 ate 10 faca
      para y de 1 ate 10 faca
         tabela[x,y] <- 0
         tabela_real[x,y] <- ""
         tabela_ganhador[x,y] <- 0
      fimpara
   fimpara
   menu_game
fimprocedimento
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
         tabela_ganhador[x,y] <- 99
         control <- control + 1
      fimse
   fimenquanto
   minas_parte_um
fimprocedimento
// ######################################################################
//                  DEFINIR QUANTIDADE DE MINAS P/ MATRIZ
procedimento minas_parte_um
var
   x, y: inteiro
inicio
   para x de 1 ate 10 faca
      para y de 1 ate 10 faca
         tabela_real[x,y] <- "X"
         se (tabela[x,y] <> 99) entao
            minas_parte_dois(x,y)
         fimse
      fimpara
   fimpara
   exibirtabela
fimprocedimento
procedimento minas_parte_dois(x,y: inteiro)
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
//                           ESCREVER MATRIZ DO GAME NA TELA
// DESENHOS PADRAO
//   _     _     _     _     _     _     _     _
//  / \   / \   / \   / \   / \   / \   / \   / \
// ( X ) ( 0 ) ( 1 ) ( 2 ) ( 3 ) ( 4 ) ( 5 ) ( 6 )
//  \_/   \_/   \_/   \_/   \_/   \_/   \_/   \_/
// \ /    _          __    __           __    _
//  X    / \   /|     _)   __)   |_|   |_    |_
// / \   \_/    |    /__   __)     |   __)   |_)
//           ___
//          | 1 |
//          |___|
procedimento exibirtabela
var
   x,y: inteiro
   control: inteiro
inicio
   limpatela
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|                        __       __                 __       _        __       _        _           _                        |")
   escreval("|               /|        _)      __)      |_|      |_       |_         /      (_)      (_|      /| / \                       |")
   escreval("|  COLUNAS ->    |       /__      __)        |      __)      |_)       /       (_)       _|       | \_/                       |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___                          |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[1,y]," |    | ")
      fimpara
      y <- 10
      escreval(tabela_real[1,y]," |  /|                     |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|   |                     |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___   __                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[2,y]," |    | ")
      fimpara
      y <- 10
      escreval(tabela_real[2,y]," |   _)                    |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  /__                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___   __                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[3,y]," |    | ")
      fimpara
      y <- 10
      escreval(tabela_real[3,y]," |  __)                    |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  __)                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___                          |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[4,y]," |    | ")
      fimpara
      y <- 10
      escreval(tabela_real[4,y]," |  |_|                    |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___    __                    |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[5,y]," |    | ")
      fimpara
      y <- 10
      escreval(tabela_real[5,y]," |  |_                     |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  __)                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___    _                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[6,y]," |    | ")
      fimpara
      y <- 10
      escreval(tabela_real[6,y]," |  |_                     |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  |_)                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___   __                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[7,y]," |    | ")
      fimpara
      y <- 10
      escreval(tabela_real[7,y]," |   /                     |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  /                      |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___    _                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[8,y]," |    | ")
      fimpara
      y <- 10
      escreval(tabela_real[8,y]," |  (_)                    |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  (_)                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___    _                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[9,y]," |    | ")
      fimpara
      y <- 10
      escreval(tabela_real[9,y]," |  (_|                    |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|   _|                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___       _                  |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[10,y]," |    | ")
      fimpara
      y <- 10
      escreval(tabela_real[10,y]," |  /| / \                 |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|   | \_/  <- LINHAS      |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval
   pergunta
fimprocedimento
// ######################################################################
//                     PERGUNTAR QUAL LINHA E COLUNA
procedimento pergunta
var
   linha, coluna: inteiro
inicio
   repita
      escreval("Escolha uma coluna: ")
      escreva("> ")
      leia(coluna)
   ate (coluna >= 1) e (coluna <= 10)
   repita
      escreval("Escolha uma linha: ")
      escreva("> ")
      leia(linha)
   ate (linha >= 1) e (linha <= 10)
   tabela_real[linha,coluna] <- numpcarac(tabela[linha,coluna])
   limpatela
   se (tabela[linha,coluna] = 99) entao
      tabela_real[linha,coluna] <- carac(157)
      explosao
   senao
      tabela_ganhador[linha,coluna] <- 1
      ganhou_game
   fimse
fimprocedimento
// ######################################################################
//                      VERIFICAR SE GANHOU O GAME
procedimento ganhou_game
var
   x, y: inteiro
   control: inteiro
   campos_validos: inteiro
inicio
   control <- 0
   para x de 1 ate 10 faca
      para y de 1 ate 10 faca
         se (tabela_ganhador[x,y] <> 99) entao
            se tabela_ganhador[x,y] = 1 entao
               control <- control + 1
            fimse
         fimse
      fimpara
   fimpara
   campos_validos <- 100 - qtdMinas
   se control = campos_validos entao
      ganhou_o_game
   senao
      exibirtabela
   fimse
fimprocedimento
// ######################################################################
//                          GANHOU O JOGO
procedimento ganhou_o_game
var
   voltar: inteiro
inicio
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______   __       __  _______    ______         __       __  ______  __    __   ______   _______    ______     |")
   escreval("|   /      \  /      \ |  \     /  \|       \  /      \       |  \     /  \|      \|  \  |  \ /      \ |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\|  $$$$$$\      | $$\   /  $$ \$$$$$$| $$\ | $$|  $$$$$$\| $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$| $$$\ /  $$$| $$__/ $$| $$  | $$      | $$$\ /  $$$  | $$  | $$$\| $$| $$__| $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$| $$$$\  $$$$| $$    $$| $$  | $$      | $$$$\  $$$$  | $$  | $$$$\ $$| $$    $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$| $$\$$ $$ $$| $$$$$$$ | $$  | $$      | $$\$$ $$ $$  | $$  | $$\$$ $$| $$$$$$$$| $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$| $$ \$$$| $$| $$      | $$__/ $$      | $$ \$$$| $$ _| $$_ | $$ \$$$$| $$  | $$| $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$| $$  \$ | $$| $$       \$$    $$      | $$  \$ | $$|   $$ \| $$  \$$$| $$  | $$| $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$ \$$      \$$ \$$        \$$$$$$        \$$      \$$ \$$$$$$ \$$   \$$ \$$   \$$ \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   timer 300
   escreval("|                                                                                                                             |")
   escreval("|                              _   _                  _____             _                   _ _ _                             |")
   escreval("|                             | | | |                |  __ \           | |                 | | | |                            |")
   escreval("|                             | | | | ___   ___ ___  | |  \/ __ _ _ __ | |__   ___  _   _  | | | |                            |")
   escreval("|                             | | | |/ _ \ / __/ _ \ | | __ / _` | '_ \| '_ \ / _ \| | | | | | | |                            |")
   escreval("|                             \ \_/ / (_) | (_|  __/ | |_\ \ (_| | | | | | | | (_) | |_| | |_|_|_|                            |")
   escreval("|                              \___/ \___/ \___\___|  \____/\__,_|_| |_|_| |_|\___/ \__,_| (_|_|_)                            |")
   escreval("|                                                                                                                             |")
   timer 0
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval
   repita
      escreval("Deseja voltar ao menu -> 1=SIM | 2=NÃO")
      escreva("> ")
      leia(voltar)
   ate (voltar >= 1) e (voltar <= 2)
   se voltar = 1 entao
      escreval
      escreva(" (Resetando as tebelas, aguarde...)")
      reset
   senao
      finalizarjogo
   fimse
fimprocedimento
// ######################################################################
//                              FINALIZAR JOGO
procedimento finalizarjogo
var
inicio
   limpatela
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______   __       __  _______    ______         __       __  ______  __    __   ______   _______    ______     |")
   escreval("|   /      \  /      \ |  \     /  \|       \  /      \       |  \     /  \|      \|  \  |  \ /      \ |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\|  $$$$$$\      | $$\   /  $$ \$$$$$$| $$\ | $$|  $$$$$$\| $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$| $$$\ /  $$$| $$__/ $$| $$  | $$      | $$$\ /  $$$  | $$  | $$$\| $$| $$__| $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$| $$$$\  $$$$| $$    $$| $$  | $$      | $$$$\  $$$$  | $$  | $$$$\ $$| $$    $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$| $$\$$ $$ $$| $$$$$$$ | $$  | $$      | $$\$$ $$ $$  | $$  | $$\$$ $$| $$$$$$$$| $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$| $$ \$$$| $$| $$      | $$__/ $$      | $$ \$$$| $$ _| $$_ | $$ \$$$$| $$  | $$| $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$| $$  \$ | $$| $$       \$$    $$      | $$  \$ | $$|   $$ \| $$  \$$$| $$  | $$| $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$ \$$      \$$ \$$        \$$$$$$        \$$      \$$ \$$$$$$ \$$   \$$ \$$   \$$ \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                           ___  _         _                                                                  |")
   escreval("|                                          / _ \| |       | |                                                                 |")
   escreval("|                                         / /_\ \ |_ ___  | | ___   __ _  ___                                                 |")
   escreval("|                                         |  _  | __/ _ \ | |/ _ \ / _` |/ _ \                                                |")
   escreval("|                                         | | | | ||  __/ | | (_) | (_| | (_) |                                               |")
   escreval("|                                         \_| |_/\__\___| |_|\___/ \__, |\___/                                                |")
   escreval("|                                                                   __/ |                                                     |")
   escreval("|                                                                  |___/                                                      |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
fimprocedimento
// ######################################################################
//                            ANIMAÇÃO DA MINA
procedimento explosao
var
   voltar: inteiro
inicio
   limpatela
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______   __       __  _______    ______         __       __  ______  __    __   ______   _______    ______     |")
   escreval("|   /      \  /      \ |  \     /  \|       \  /      \       |  \     /  \|      \|  \  |  \ /      \ |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\|  $$$$$$\      | $$\   /  $$ \$$$$$$| $$\ | $$|  $$$$$$\| $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$| $$$\ /  $$$| $$__/ $$| $$  | $$      | $$$\ /  $$$  | $$  | $$$\| $$| $$__| $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$| $$$$\  $$$$| $$    $$| $$  | $$      | $$$$\  $$$$  | $$  | $$$$\ $$| $$    $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$| $$\$$ $$ $$| $$$$$$$ | $$  | $$      | $$\$$ $$ $$  | $$  | $$\$$ $$| $$$$$$$$| $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$| $$ \$$$| $$| $$      | $$__/ $$      | $$ \$$$| $$ _| $$_ | $$ \$$$$| $$  | $$| $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$| $$  \$ | $$| $$       \$$    $$      | $$  \$ | $$|   $$ \| $$  \$$$| $$  | $$| $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$ \$$      \$$ \$$        \$$$$$$        \$$      \$$ \$$$$$$ \$$   \$$ \$$   \$$ \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   timer 300
   escreval("|                                                             . . .                                                           |")
   escreval("|                                                              \|/                                                            |")
   escreval("|                                                            `--+--'                                                          |")
   escreval("|                                                              /|\                                                            |")
   escreval("|                                                             ' | '                                                           |")
   escreval("|                                                               |                                                             |")
   escreval("|                                                               |                                                             |")
   escreval("|                                                           ,--'#`--.                                                         |")
   escreval("|                                                           |#######|                                                         |")
   escreval("|                                                        _.-'#######`-._                                                      |")
   escreval("|                                                     ,-'###############`-.                                                   |")
   escreval("|                                                   ,'#####################`,                                                 |")
   escreval("|                                                  /#########################\                                                |")
   escreval("|                                                 |###########################|                                               |")
   escreval("|                                                |#############################|                                              |")
   escreval("|                                                |#############################|                                              |")
   escreval("|                                                |#############################|                                              |")
   escreval("|                                                |#############################|                                              |")
   escreval("|                                                 |###########################|                                               |")
   escreval("|                                                  \#########################/                                                |")
   escreval("|                                                   `.#####################,'                                                 |")
   escreval("|                                                     `._###############_,'                                                   |")
   escreval("|                                                        `--..#####..--'                                                      |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   timer 0
   escreval
   repita
      escreval("Deseja voltar ao menu -> 1=SIM | 2=NÃO")
      escreva("> ")
      leia(voltar)
   ate (voltar >= 1) e (voltar <= 2)
   se voltar = 1 entao
      escreval
      escreva(" (Resetando as tebelas, aguarde...)")
      reset
   senao
      finalizarjogo
   fimse
fimprocedimento
// ######################################################################
//                   ESCOLHA DA DIFICULDADE DO GAME
procedimento escolha_dificuldade
var
   dificuldade: inteiro
inicio
   timer 150
   limpatela
   timer 0
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______   __       __  _______    ______         __       __  ______  __    __   ______   _______    ______     |")
   escreval("|   /      \  /      \ |  \     /  \|       \  /      \       |  \     /  \|      \|  \  |  \ /      \ |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\|  $$$$$$\      | $$\   /  $$ \$$$$$$| $$\ | $$|  $$$$$$\| $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$| $$$\ /  $$$| $$__/ $$| $$  | $$      | $$$\ /  $$$  | $$  | $$$\| $$| $$__| $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$| $$$$\  $$$$| $$    $$| $$  | $$      | $$$$\  $$$$  | $$  | $$$$\ $$| $$    $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$| $$\$$ $$ $$| $$$$$$$ | $$  | $$      | $$\$$ $$ $$  | $$  | $$\$$ $$| $$$$$$$$| $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$| $$ \$$$| $$| $$      | $$__/ $$      | $$ \$$$| $$ _| $$_ | $$ \$$$$| $$  | $$| $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$| $$  \$ | $$| $$       \$$    $$      | $$  \$ | $$|   $$ \| $$  \$$$| $$  | $$| $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$ \$$      \$$ \$$        \$$$$$$        \$$      \$$ \$$$$$$ \$$   \$$ \$$   \$$ \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                 1- FÁCIL.....(10 Minas)                                                     |")
   escreval("|                                                 2- MÉDIO.....(15 Minas)                                                     |")
   escreval("|                                                 3- DIFÍCIL...(20 Minas)                                                     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval
   escreva("> ")
   repita
      leia(dificuldade)
   ate (dificuldade >= 1) e (dificuldade <= 3)
   escolha dificuldade
   caso 1
      escreval
      escreva(" (Sorteando minas, aguarde...)")
      qtdMinas <- 10
      sorteio_minas(qtdMinas)
   caso 2
      escreval
      escreva(" (Sorteando minas, aguarde...)")
      qtdMinas <- 15
      sorteio_minas(qtdMinas)
   caso 3
      escreval
      escreva(" (Sorteando minas, aguarde...)")
      qtdMinas <- 20
      sorteio_minas(qtdMinas)
   fimescolha

fimprocedimento
// ######################################################################
//                  MENU PRINCIPAL DO GAME - OPCOES
procedimento menu_game
var
   escolha_do_menu: inteiro
inicio
   timer 150
   limpatela
   timer 0
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______   __       __  _______    ______         __       __  ______  __    __   ______   _______    ______     |")
   escreval("|   /      \  /      \ |  \     /  \|       \  /      \       |  \     /  \|      \|  \  |  \ /      \ |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\|  $$$$$$\      | $$\   /  $$ \$$$$$$| $$\ | $$|  $$$$$$\| $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$| $$$\ /  $$$| $$__/ $$| $$  | $$      | $$$\ /  $$$  | $$  | $$$\| $$| $$__| $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$| $$$$\  $$$$| $$    $$| $$  | $$      | $$$$\  $$$$  | $$  | $$$$\ $$| $$    $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$| $$\$$ $$ $$| $$$$$$$ | $$  | $$      | $$\$$ $$ $$  | $$  | $$\$$ $$| $$$$$$$$| $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$| $$ \$$$| $$| $$      | $$__/ $$      | $$ \$$$| $$ _| $$_ | $$ \$$$$| $$  | $$| $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$| $$  \$ | $$| $$       \$$    $$      | $$  \$ | $$|   $$ \| $$  \$$$| $$  | $$| $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$ \$$      \$$ \$$        \$$$$$$        \$$      \$$ \$$$$$$ \$$   \$$ \$$   \$$ \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                 1- INICIAR JOGO                                                             |")
   escreval("|                                                 2- CRÉDITOS (AUTOR)                                                         |")
   escreval("|                                                 3- SAIR DO JOGO                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval
   escreva("> ")
   repita
      leia(escolha_do_menu)
   ate (escolha_do_menu >= 1) e (escolha_do_menu <= 3)
   escolha escolha_do_menu
   caso 1
      escolha_dificuldade
   caso 2
      creditos
   caso 3
      finalizarjogo
   fimescolha

fimprocedimento
// ######################################################################
//                             CREDITOS DO GAME
procedimento creditos
var
   voltar: inteiro
inicio
   limpatela
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______   __       __  _______    ______         __       __  ______  __    __   ______   _______    ______     |")
   escreval("|   /      \  /      \ |  \     /  \|       \  /      \       |  \     /  \|      \|  \  |  \ /      \ |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\|  $$$$$$\      | $$\   /  $$ \$$$$$$| $$\ | $$|  $$$$$$\| $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$| $$$\ /  $$$| $$__/ $$| $$  | $$      | $$$\ /  $$$  | $$  | $$$\| $$| $$__| $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$| $$$$\  $$$$| $$    $$| $$  | $$      | $$$$\  $$$$  | $$  | $$$$\ $$| $$    $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$| $$\$$ $$ $$| $$$$$$$ | $$  | $$      | $$\$$ $$ $$  | $$  | $$\$$ $$| $$$$$$$$| $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$| $$ \$$$| $$| $$      | $$__/ $$      | $$ \$$$| $$ _| $$_ | $$ \$$$$| $$  | $$| $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$| $$  \$ | $$| $$       \$$    $$      | $$  \$ | $$|   $$ \| $$  \$$$| $$  | $$| $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$ \$$      \$$ \$$        \$$$$$$        \$$      \$$ \$$$$$$ \$$   \$$ \$$   \$$ \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                 ___        _                                                                |")
   escreval("|                                                / _ \      | |                                                               |")
   escreval("|                                               / /_\ \_   _| |_ ___  _ __                                                    |")
   escreval("|                                               |  _  | | | | __/ _ \| '__|                                                   |")
   escreval("|                                               | | | | |_| | || (_) | |                                                      |")
   escreval("|                                               \_| |_/\__,_|\__\___/|_|                                                      |")
   escreval("|                                                                                                                             |")
   escreval("|                                                  ALISON LUIZ DA SILVA                                                       |")
   escreval("|                                             Estudante de Eng. de Software                                                   |")
   escreval("|                                                        02/2022                                                              |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreva
   repita
      escreval("Deseja voltar ao menu -> 1=SIM | 2=NÃO (SAIR)")
      escreva("> ")
      leia(voltar)
   ate (voltar >= 1) e (voltar <= 2)
   se voltar = 1 entao
      menu_game
   senao
      finalizarjogo
   fimse
fimprocedimento
// ######################################################################
//                       INICIO DO GAME - INSTRUÇOES
procedimento start_game_maximizar_tela
var
   enter: caracter
inicio

   repita
      limpatela
      escreval("|---------------------------------------------------|")
      escreval("|                                                   |")
      escreval("|                                                   |")
      escreval("|            POR FAVOR, MAXIMIZAR A TELA            |")
      escreval("|        DO VISUALG, PARA MELHOR EXPERIENCIA        |")
      escreval("|                                                   |")
      escreval("|            (TECLE ENTER PARA CONTINUAR)           |")
      escreval("|                                                   |")
      escreval("|---------------------------------------------------|")
      timer 50
      timer 0
      leia(enter)
   ate enter = ""
   start_game
fimprocedimento
// ######################################################################
//                        ANIMAÇÃO INICIAL DO GAME
procedimento start_game
var
   enter: caracter
inicio
   timer 1000
   limpatela
   timer 0
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______                                                                                                        ______     |")
   escreval("|   /      \                                                                                                      /      \    |")
   escreval("|  |  $$$$$$\                                                                                                    |  $$$$$$\   |")
   escreval("|  | $$   \$$                                                                                                    | $$  | $$   |")
   escreval("|  | $$                                                                                                          | $$  | $$   |")
   escreval("|  | $$   __                                                                                                     | $$  | $$   |")
   escreval("|  | $$__/  \                                                                                                    | $$__/ $$   |")
   escreval("|   \$$    $$                                                                                                     \$$    $$   |")
   escreval("|    \$$$$$$                                                                                                       \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   timer 100
   limpatela
   timer 0
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______                                                                                   _______    ______     |")
   escreval("|   /      \  /      \                                                                                 |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\                                                                                | $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$                                                                                | $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$                                                                                | $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$                                                                                | $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$                                                                                | $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$                                                                                | $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$                                                                                 \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   timer 100
   limpatela
   timer 0
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______   __       __                                                            ______   _______    ______     |")
   escreval("|   /      \  /      \ |  \     /  \                                                          /      \ |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\| $$\   /  $$                                                         |  $$$$$$\| $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$| $$$\ /  $$$                                                         | $$__| $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$| $$$$\  $$$$                                                         | $$    $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$| $$\$$ $$ $$                                                         | $$$$$$$$| $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$| $$ \$$$| $$                                                         | $$  | $$| $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$| $$  \$ | $$                                                         | $$  | $$| $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$ \$$      \$$                                                          \$$   \$$ \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   timer 100
   limpatela
   timer 0
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______   __       __  _______                                        __    __   ______   _______    ______     |")
   escreval("|   /      \  /      \ |  \     /  \|       \                                      |  \  |  \ /      \ |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\                                     | $$\ | $$|  $$$$$$\| $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$| $$$\ /  $$$| $$__/ $$                                     | $$$\| $$| $$__| $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$| $$$$\  $$$$| $$    $$                                     | $$$$\ $$| $$    $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$| $$\$$ $$ $$| $$$$$$$                                      | $$\$$ $$| $$$$$$$$| $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$| $$ \$$$| $$| $$                                           | $$ \$$$$| $$  | $$| $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$| $$  \$ | $$| $$                                           | $$  \$$$| $$  | $$| $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$ \$$      \$$ \$$                                            \$$   \$$ \$$   \$$ \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   timer 100
   limpatela
   timer 0
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______   __       __  _______    ______                      ______  __    __   ______   _______    ______     |")
   escreval("|   /      \  /      \ |  \     /  \|       \  /      \                    |      \|  \  |  \ /      \ |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\|  $$$$$$\                    \$$$$$$| $$\ | $$|  $$$$$$\| $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$| $$$\ /  $$$| $$__/ $$| $$  | $$                     | $$  | $$$\| $$| $$__| $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$| $$$$\  $$$$| $$    $$| $$  | $$                     | $$  | $$$$\ $$| $$    $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$| $$\$$ $$ $$| $$$$$$$ | $$  | $$                     | $$  | $$\$$ $$| $$$$$$$$| $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$| $$ \$$$| $$| $$      | $$__/ $$                    _| $$_ | $$ \$$$$| $$  | $$| $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$| $$  \$ | $$| $$       \$$    $$                   |   $$ \| $$  \$$$| $$  | $$| $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$ \$$      \$$ \$$        \$$$$$$                     \$$$$$$ \$$   \$$ \$$   \$$ \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   timer 100
   limpatela
   timer 0
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______   __       __  _______    ______         __       __  ______  __    __   ______   _______    ______     |")
   escreval("|   /      \  /      \ |  \     /  \|       \  /      \       |  \     /  \|      \|  \  |  \ /      \ |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\|  $$$$$$\      | $$\   /  $$ \$$$$$$| $$\ | $$|  $$$$$$\| $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$| $$$\ /  $$$| $$__/ $$| $$  | $$      | $$$\ /  $$$  | $$  | $$$\| $$| $$__| $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$| $$$$\  $$$$| $$    $$| $$  | $$      | $$$$\  $$$$  | $$  | $$$$\ $$| $$    $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$| $$\$$ $$ $$| $$$$$$$ | $$  | $$      | $$\$$ $$ $$  | $$  | $$\$$ $$| $$$$$$$$| $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$| $$ \$$$| $$| $$      | $$__/ $$      | $$ \$$$| $$ _| $$_ | $$ \$$$$| $$  | $$| $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$| $$  \$ | $$| $$       \$$    $$      | $$  \$ | $$|   $$ \| $$  \$$$| $$  | $$| $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$ \$$      \$$ \$$        \$$$$$$        \$$      \$$ \$$$$$$ \$$   \$$ \$$   \$$ \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   timer 300
   limpatela
   timer 0
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval("|    ______    ______   __       __  _______    ______         __       __  ______  __    __   ______   _______    ______     |")
   escreval("|   /      \  /      \ |  \     /  \|       \  /      \       |  \     /  \|      \|  \  |  \ /      \ |       \  /      \    |")
   escreval("|  |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\|  $$$$$$\      | $$\   /  $$ \$$$$$$| $$\ | $$|  $$$$$$\| $$$$$$$\|  $$$$$$\   |")
   escreval("|  | $$   \$$| $$__| $$| $$$\ /  $$$| $$__/ $$| $$  | $$      | $$$\ /  $$$  | $$  | $$$\| $$| $$__| $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$      | $$    $$| $$$$\  $$$$| $$    $$| $$  | $$      | $$$$\  $$$$  | $$  | $$$$\ $$| $$    $$| $$  | $$| $$  | $$   |")
   escreval("|  | $$   __ | $$$$$$$$| $$\$$ $$ $$| $$$$$$$ | $$  | $$      | $$\$$ $$ $$  | $$  | $$\$$ $$| $$$$$$$$| $$  | $$| $$  | $$   |")
   escreval("|  | $$__/  \| $$  | $$| $$ \$$$| $$| $$      | $$__/ $$      | $$ \$$$| $$ _| $$_ | $$ \$$$$| $$  | $$| $$__/ $$| $$__/ $$   |")
   escreval("|   \$$    $$| $$  | $$| $$  \$ | $$| $$       \$$    $$      | $$  \$ | $$|   $$ \| $$  \$$$| $$  | $$| $$    $$ \$$    $$   |")
   escreval("|    \$$$$$$  \$$   \$$ \$$      \$$ \$$        \$$$$$$        \$$      \$$ \$$$$$$ \$$   \$$ \$$   \$$ \$$$$$$$   \$$$$$$    |")
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                          _                                                  |")
   escreval("|                                                                         | |                                                 |")
   escreval("|                                     _ __  _ __ ___  ___ ___    ___ _ __ | |_ ___ _ __                                       |")
   escreval("|                                    | '_ \| '__/ _ \/ __/ __|  / _ \ '_ \| __/ _ \ '__|                                      |")
   escreval("|                                    | |_) | | |  __/\__ \__ \ |  __/ | | | ||  __/ |                                         |")
   escreval("|                                    | .__/|_|  \___||___/___/  \___|_| |_|\__\___|_|                                         |")
   escreval("|                                    | |                                                                                      |")
   escreval("|                                    |_|                                                                                      |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")

   repita
      leia(enter)
   ate enter = ""
   menu_game
fimprocedimento
// ######################################################################
Inicio
   start_game_maximizar_tela
Fimalgoritmo
