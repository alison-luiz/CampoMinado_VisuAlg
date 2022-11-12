Algoritmo "Campo_Minado"
// Autor(a)    : ALISON LUIZ DA SILVA
// ###################################################################################################################################
//       ______    ______   __       __  _______    ______         __       __  ______  __    __   ______   _______    ______
//      /      \  /      \ |  \     /  \|       \  /      \       |  \     /  \|      \|  \  |  \ /      \ |       \  /      \
//     |  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\|  $$$$$$\      | $$\   /  $$ \$$$$$$| $$\ | $$|  $$$$$$\| $$$$$$$\|  $$$$$$\
//     | $$   \$$| $$__| $$| $$$\ /  $$$| $$__/ $$| $$  | $$      | $$$\ /  $$$  | $$  | $$$\| $$| $$__| $$| $$  | $$| $$  | $$
//     | $$      | $$    $$| $$$$\  $$$$| $$    $$| $$  | $$      | $$$$\  $$$$  | $$  | $$$$\ $$| $$    $$| $$  | $$| $$  | $$
//     | $$   __ | $$$$$$$$| $$\$$ $$ $$| $$$$$$$ | $$  | $$      | $$\$$ $$ $$  | $$  | $$\$$ $$| $$$$$$$$| $$  | $$| $$  | $$
//     | $$__/  \| $$  | $$| $$ \$$$| $$| $$      | $$__/ $$      | $$ \$$$| $$ _| $$_ | $$ \$$$$| $$  | $$| $$__/ $$| $$__/ $$
//      \$$    $$| $$  | $$| $$  \$ | $$| $$       \$$    $$      | $$  \$ | $$|   $$ \| $$  \$$$| $$  | $$| $$    $$ \$$    $$
//       \$$$$$$  \$$   \$$ \$$      \$$ \$$        \$$$$$$        \$$      \$$ \$$$$$$ \$$   \$$ \$$   \$$ \$$$$$$$   \$$$$$$
// ###################################################################################################################################
Var
   tabela: vetor [1..10,1..10] de inteiro // TABELA QUE VAI SALVAR OS VALORES DAS MINAS EM VOLTA DA MATRIZ 3X3
   tabela_real: vetor [1..10,1..10] de caracter // TABELA QUE SERA EXIBIDA AO JOGADOR
   tabela_ganhador: vetor [1..10,1..10] de inteiro // TABELA DE CONTROLE PARA VALIDAR SE GANHOU O GAME
   qtdMinas: inteiro  // QUANTIDADE DE MINAS PARA SORTEAR ALEATORIAMENTE E VALIDAR O GANHADOR
   descobrir: logico // DEFINIR SE O JOGO TERA DESCOBETA AUTOMATICA/ALEATÓRIA DA TEBELA
   nove_nove: logico // VALOR LOGICO PARA OPÇÃO COLUNA/LINHA: 99 - REVELAR TODAS AS MINAS NA TABELA
   score_on: logico // VALOR LOGICO PARA ATIVAR/DESATIVAR ACUMULAR PONTOS/SCORE
   nome_user: caracter // NOME DO JOGADOR ATIVO NA SESSÃO
   score: inteiro // SALDO DE SCORE DO JOGADOR ATIVO NA SESSÃO
   user: vetor [1..10] de caracter // LISTA DE UARIOS ENQUANTO O GAME ESTIVER ABERTO
   user_score: vetor [1..10] de inteiro // LISTA DE SCORE DOS USUARIOS ENQUANTO O GAME ESTIVER ABERTO
   user_ativo: inteiro // INDEX DO USUARIO ATIVO NO MOMENTO
   contador_user: inteiro // SALVAR QUANTIDADE DE USUARIOS REGISTRADOS (MAXIMO DE 10 JOGADORES)
   nivel_dificuldade: inteiro // SALVAR VALOR REF. A DIFICULDADE ATUAL DO JOGO
   // ###################################################################################################################################
   // RESETANDO AS TEBELAS (NOVO GAME)
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
   nove_nove <- falso
   menu_game
fimprocedimento
// ###################################################################################################################################
// FAZENDO O SORTEIO ALEATORIO DAS MINAS NO VETOR 1..10,1..10
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
// ###################################################################################################################################
// DEFINIR A QUANTIDADE DE MINAS A VOLTA DO VETOR... (SÃO AO TODO 8 POSSIBILIDADES)
procedimento minas_parte_um
var
   x, y: inteiro
inicio
   para x de 1 ate 10 faca
      para y de 1 ate 10 faca
         tabela_real[x,y] <- " "
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
// ###################################################################################################################################
// PERGUNTAR AO JOGADOR
// 1-) QUAL COLUNA E QUAL LINHA <1 ATE 10>
// 2-) CONFIRMAR ESCOLHA <ENTER>
// 3-) MARCAR/DESMARCAR FLAG/BOMB <B>
// 4-) SAIR DO GAME <S>
procedimento pergunta
var
   linha, coluna: inteiro
   confirma: caracter
inicio
   repita
      escreva("    Escolha uma COLUNA: ")
      leia(coluna)
   ate ((coluna >= 1) e (coluna <= 10)) ou (coluna = 99)
   repita
      escreva("    Escolha uma LINHA: ")
      leia(linha)
   ate ((linha >= 1) e (linha <= 10)) ou (linha = 99)
   repita
      escreva("    (ENTER) para confirmar: (",numpcarac(coluna),",",numpcarac(linha),") | (B) para marcar/desmarcar FLAG | (S) para voltar ao menu: ")
      leia(confirma)
   ate (confirma = "") ou (confirma = "B") ou (confirma = "b") ou (confirma = "S") ou (confirma = "s")
   se (coluna = 99) e (linha = 99) entao
      se nove_nove = falso entao
         cheat_descobrir_bombas
      senao
         cheat_ocultar_bombas
      fimse
   senao
      se confirma = "" entao
         se (tabela_ganhador[linha,coluna] = 0) ou (tabela_ganhador[linha,coluna] = 99) entao
            validar_escolha(linha,coluna)
         senao
            escreval("    COLUNA/LINHA JÁ FOI DESCOBERTA, ESCOLHA OUTRA!!!")
            timer 1500
            timer 0
            exibirtabela
         fimse
      senao
         se (confirma = "B") ou (confirma = "b") entao
            se (tabela_ganhador[linha,coluna] = 0) ou (tabela_ganhador[linha,coluna] = 99) entao
               se (tabela_real[linha,coluna] = "B") entao
                  tabela_real[linha,coluna] <- " "
                  exibirtabela
               senao
                  tabela_real[linha,coluna] <- "B"
                  exibirtabela
               fimse
            senao
               escreval("    COLUNA/LINHA JÁ FOI DESCOBERTA, ESCOLHA OUTRA!!!")
               timer 1500
               timer 0
               exibirtabela
            fimse
         fimse
         se (confirma = "S") ou (confirma = "s") entao
            escreval
            escreva(" (Resetando as tebelas, aguarde...)")
            reset
         fimse
      fimse
   fimse
fimprocedimento
// ###################################################################################################################################
// CHEAT - DESCOBRIR/OCULTAR TODAS AS MINAS TA TABELA - DIGITAR 99 PARA COLUNA/LINHA
procedimento cheat_descobrir_bombas
var
   x, y: inteiro
inicio
   para x de 1 ate 10 faca
      para y de 1 ate 10 faca
         se (tabela[x,y] = 99) entao
            tabela_real[x,y] <- carac(157)
         fimse
      fimpara
   fimpara
   nove_nove <- verdadeiro
   exibirtabela
fimprocedimento
procedimento cheat_ocultar_bombas
var
   x, y: inteiro
inicio
   para x de 1 ate 10 faca
      para y de 1 ate 10 faca
         se (tabela[x,y] = 99) entao
            tabela_real[x,y] <- " "
         fimse
      fimpara
   fimpara
   nove_nove <- falso
   exibirtabela
fimprocedimento
// ###################################################################################################################################
// VALIDAR ESCOLHA DO JOGADOR DA COLUNA/LINHA (CASO 2-) CONFIRME ESCOLHA <ENTER> SEJA VERDADEIRO)
procedimento validar_escolha(linha,coluna: inteiro)
var
inicio
   limpatela
   se (tabela[linha,coluna] = 99) entao
      tabela_real[linha,coluna] <- carac(157)
      explosao
   senao
      se descobrir = verdadeiro entao
         sortear_descoberto(linha,coluna)
      senao
         tabela_real[linha,coluna] <- numpcarac(tabela[linha,coluna])
         tabela_ganhador[linha,coluna] <- 1
         ganhou_game
      fimse
   fimse
fimprocedimento
// ###################################################################################################################################
// DESCOBRIR CAMPOS AUTOMATICAMENTE/ALEATORIAMENTE - CASO VALIDAR ESCOLHA (DESCOBRIR) SEJA VERDADEIRO
procedimento sortear_descoberto(x,y: inteiro)
var
   x1,x2,y1,y2: inteiro
   control: inteiro
   qtd_auto: inteiro
   qtd_auto_control: inteiro
inicio
   tabela_real[x,y] <- numpcarac(tabela[x,y])
   tabela_ganhador[x,y] <- 1
   x1 <- x - 1
   y1 <- y - 1
   x2 <- x + 1
   y2 <- y + 1
   qtd_auto <- randi(8)+1
   qtd_auto_control <- 0
   enquanto x1 <= x2 faca
      enquanto y1 <= y2 faca
         se (x1 >= 1) e (x1 <= 10) e (y1 >= 1) e (y1 <= 10) entao
            se qtd_auto_control <> qtd_auto entao
               qtd_auto_control <- qtd_auto_control + 1
               se (tabela_ganhador[x1,y1] = 0) entao
                  tabela_ganhador[x1,y1] <- 1
                  tabela_real[x1,y1] <- numpcarac(tabela[x1,y1])
               fimse
            fimse
         fimse
         y1 <- y1 + 1
      fimenquanto
      y1 <- y - 1
      x1 <- x1 + 1
   fimenquanto
   ganhou_game
fimprocedimento
// ###################################################################################################################################
// VERIFICAR SE GANHOU O GAME - A CADA JOGADA A COMPARAÇÃO DE VITÓRIA É FEITA
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
      score <- score + 10
      se score_on = verdadeiro entao
         score <- score + 10
         user_score[user_ativo] <- score
      fimse
   senao
      se score_on = verdadeiro entao
         score <- score + 10
         user_score[user_ativo] <- score
      fimse
      exibirtabela
   fimse
fimprocedimento
// ###################################################################################################################################
// ESCREVER TABELA NA TELA DO USUARIO
// DESENHOS PADRAO
//    ___
//   | 1 |
//   |___|
procedimento exibirtabela
var
   x,y: inteiro
   control: inteiro
inicio
   limpatela
   se nivel_dificuldade = 1 entao
      escreval("|------------------------------------------------------------FÁCIL------------------------------------------------------------|")
   senao
      se nivel_dificuldade = 2 entao
         escreval("|------------------------------------------------------------MÉDIO------------------------------------------------------------|")
      senao
         se nivel_dificuldade = 3 entao
            escreval("|-----------------------------------------------------------DIFÍCIL-----------------------------------------------------------|")
         fimse
      fimse
   fimse
   escreval("|                        __       __                 __       _        __       _        _           _                        |")
   escreval("|               /|        _)      __)      |_|      |_       |_         /      (_)      (_|      /| / \                       |")
   escreval("|  COLUNAS ->    |       /__      __)        |      __)      |_)       /       (_)       _|       | \_/                       |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___                          |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[1,y]," |    | ")
      fimpara
      escreval(tabela_real[1,10]," |  /|                     |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|   |                     |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___   __                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[2,y]," |    | ")
      fimpara
      escreval(tabela_real[2,10]," |   _)                    |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  /__                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___   __                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[3,y]," |    | ")
      fimpara
      escreval(tabela_real[3,10]," |  __)                    |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  __)                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___                          |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[4,y]," |    | ")
      fimpara
      escreval(tabela_real[4,10]," |  |_|                    |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___    __                    |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[5,y]," |    | ")
      fimpara
      escreval(tabela_real[5,10]," |  |_                     |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  __)                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___    _                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[6,y]," |    | ")
      fimpara
      escreval(tabela_real[6,10]," |  |_                     |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  |_)                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___   __                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[7,y]," |    | ")
      fimpara
      escreval(tabela_real[7,10]," |   /                     |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  /                      |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___    _                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[8,y]," |    | ")
      fimpara
      escreval(tabela_real[8,10]," |  (_)                    |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|  (_)                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___    _                     |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[9,y]," |    | ")
      fimpara
      escreval(tabela_real[9,10]," |  (_|                    |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|   _|                    |")
   escreval("|               ___      ___      ___      ___      ___      ___      ___      ___      ___      ___       _                  |")
   para x de 1 ate 1 faca
      escreva("|              | ")
      para y de 1 ate 9 faca
         escreva(tabela_real[10,y]," |    | ")
      fimpara
      escreval(tabela_real[10,10]," |  /| / \                 |")
   fimpara
   escreval("|              |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|    |___|   | \_/  <- LINHAS      |")
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
   escreval
   pergunta
fimprocedimento
// ###################################################################################################################################
// EXIBIR NA TELA CASO: GANHOU O JOGO
procedimento ganhou_o_game
var
   enter: caracter
inicio
   repita
      limpatela
      cabecalho
      escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      timer 150
      escreval("|                                                                                                                             |")
      escreval("|                                _   _                  _____             _                   _ _ _                           |")
      escreval("|                               | | | |                |  __ \           | |                 | | | |                          |")
      escreval("|                               | | | | ___   ___ ___  | |  \/ __ _ _ __ | |__   ___  _   _  | | | |                          |")
      escreval("|                               | | | |/ _ \ / __/ _ \ | | __ / _` | '_ \| '_ \ / _ \| | | | | | | |                          |")
      escreval("|                               \ \_/ / (_) | (_|  __/ | |_\ \ (_| | | | | | | | (_) | |_| | |_|_|_|                          |")
      escreval("|                                \___/ \___/ \___\___|  \____/\__,_|_| |_|_| |_|\___/ \__,_| (_|_|_)                          |")
      escreval("|                                                                                                                             |")
      timer 0
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                (TECLE ENTER PARA VOLTAR)                                                    |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      se score_on = verdadeiro entao
         exibir_jogador
         exibir_score
      senao
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
      fimse
      escreval("|                                                                                                                             |")
      escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
      leia(enter)
   ate enter = ""
   escreval
   escreva(" (Resetando as tebelas, aguarde...)")
   reset
fimprocedimento
// ###################################################################################################################################
// EXIBIR NA TELA CASO: FINALIZE JOGO
procedimento finalizarjogo
var
inicio
   limpatela
   cabecalho
   escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                             ___  _     __   _                                                               |")
   escreval("|                                            / _ \| |   / /  | |                                                              |")
   escreval("|                                           / /_\ \ |_ ___   | | ___   __ _  ___                                              |")
   escreval("|                                           |  _  | __/ _ \  | |/ _ \ / _` |/ _ \                                             |")
   escreval("|                                           | | | | ||  __/  | | (_) | (_| | (_) |                                            |")
   escreval("|                                           \_| |_/\__\___|  |_|\___/ \__, |\___/                                             |")
   escreval("|                                                                     __/ |                                                   |")
   escreval("|                                                                    |___/                                                    |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   escreval("|                                                                                                                             |")
   se score_on = verdadeiro entao
      exibir_jogador
      exibir_score
   senao
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
   fimse
   escreval("|                                                                                                                             |")
   escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
fimprocedimento
// ###################################################################################################################################
// EXIBIR NA TELA CASO: EXPLODA A MINA
procedimento explosao
var
   enter: caracter
inicio
   repita
      limpatela
      cabecalho
      escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
      timer 150
      escreval("|                                                            \|/                                                              |")
      escreval("|                                                          `--+--'                                                            |")
      escreval("|                                                            /|\                                                              |")
      escreval("|                                                           ' | '                                                             |")
      escreval("|                                                             |                                                               |")
      escreval("|                                                             |                                                               |")
      escreval("|                                                         ,--'#`--.                                                           |")
      escreval("|                                                         |#######|                                                           |")
      escreval("|                                                      _.-'#######`-._                                                        |")
      escreval("|                                                   ,-'###############`-.                                                     |")
      escreval("|                                                 ,'#####################`,                                                   |")
      escreval("|                                                /#########################\                                                  |")
      escreval("|                                               |###########################|                                                 |")
      escreval("|                                              |#############################|                                                |")
      escreval("|                                              |#############################|                                                |")
      escreval("|                                              |#############################|                                                |")
      escreval("|                                              |#############################|                                                |")
      escreval("|                                               |###########################|                                                 |")
      escreval("|                                                \#########################/                                                  |")
      escreval("|                                                 `.#####################,'                                                   |")
      escreval("|                                                   `._###############_,'                                                     |")
      escreval("|                                                      `--..#####..--'                                                        |")
      escreval("|                                                                                                                             |")
      escreval("|                                                (TECLE ENTER PARA VOLTAR)                                                    |")
      escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
      timer 0
      escreval
      leia(enter)
   ate enter = ""
   escreval
   escreva(" (Resetando as tebelas, aguarde...)")
   reset
fimprocedimento
// ###################################################################################################################################
// ESCOLHA DA DIFICULDADE DO GAME
procedimento escolha_dificuldade
var
   dificuldade: inteiro
inicio
   repita
      timer 150
      limpatela
      timer 0
      cabecalho
      escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                  1- FÁCIL.....(15 Minas)                                                    |")
      escreval("|                                                  2- MÉDIO.....(20 Minas)                                                    |")
      escreval("|                                                  3- DIFÍCIL...(30 Minas)                                                    |")
      escreval("|                                                                                                                             |")
      escreval("|                                                  9- VOLTAR AO MENU                                                          |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      se score_on = verdadeiro entao
         exibir_jogador
         exibir_score
      senao
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
      fimse
      escreval("|                                                                                                                             |")
      escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
      escreval
      escreva("> ")
      leia(dificuldade)
   ate ((dificuldade >= 1) e (dificuldade <= 3)) ou (dificuldade = 9)
   escolha dificuldade
   caso 1
      qtdMinas <- 15
      nivel_dificuldade <- 1
      escolha_descobrir_auto
   caso 2
      qtdMinas <- 20
      nivel_dificuldade <- 2
      escolha_descobrir_auto
   caso 3
      qtdMinas <- 30
      nivel_dificuldade <- 3
      escolha_descobrir_auto
   caso 9
      menu_game
   fimescolha
fimprocedimento
// ###################################################################################################################################
// ESCOLHER DESCOBRIR AUTOMARICO
procedimento escolha_descobrir_auto
var
   auto: inteiro
inicio
   repita
      timer 150
      limpatela
      timer 0
      cabecalho
      escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                  DESEJA QUE OS CAMPOS SEJAM DESCOBERTOS AUTOMATICAMENTE ?                                   |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                        1- SIM                                                               |")
      escreval("|                                                        2- NÃO                                                               |")
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
      se score_on = verdadeiro entao
         exibir_jogador
         exibir_score
      senao
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
      fimse
      escreval("|                                                                                                                             |")
      escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
      escreval
      escreva("> ")
      leia(auto)
   ate (auto >= 1) e (auto <= 2)
   escolha auto
   caso 1
      descobrir <- verdadeiro
      escreval
      escreva(" (Sorteando minas COM descoberta automatica, aguarde...)")
      sorteio_minas(qtdMinas)
   caso 2
      descobrir <- falso
      escreval
      escreva(" (Sorteando minas SEM descoberta automatica, aguarde...)")
      sorteio_minas(qtdMinas)
   fimescolha
fimprocedimento
// ###################################################################################################################################
// EXIBIR JOGADOR NA TELA
procedimento exibir_jogador
var
   cont, fim_carac_user: inteiro
   escrever_na_tela: caracter
inicio
   fim_carac_user <- (112 - compr(nome_user))
   escrever_na_tela <- ""
   escreva("|    Jogador: ")
   escreva(nome_user)
   para cont de 1 ate fim_carac_user faca
      escrever_na_tela <- escrever_na_tela + " "
   fimpara
   escreval(escrever_na_tela,"|")
fimprocedimento
// ###################################################################################################################################
// EXIBIR SCORE NA TELA
procedimento exibir_score
var
   tam_exibir_score: inteiro
   carac_score: caracter
inicio
   carac_score <- numpcarac(score)
   tam_exibir_score <- compr(carac_score)
   escolha tam_exibir_score
   caso 1
      escreval("|      SCORE: ",carac_score,"                                                                                                               |")
   caso 2
      escreval("|      SCORE: ",carac_score,"                                                                                                              |")
   caso 3
      escreval("|      SCORE: ",carac_score,"                                                                                                             |")
   caso 4
      escreval("|      SCORE: ",carac_score,"                                                                                                            |")
   outrocaso
      escreval("|      SCORE: ",carac_score,"                                                                                                           |")
   fimescolha
fimprocedimento
// ###################################################################################################################################
// MENU PRINCIPAL DO GAME - OPCOES
procedimento menu_game
var
   escolha_do_menu: inteiro
inicio
   timer 150
   timer 0
   se score_on = falso entao
      repita
         limpatela
         cabecalho
         escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                     1- INICIAR JOGO                                                         |")
         escreval("|                                                     2- REALIZAR LOGIN (ACUMULAR SCORE)                                      |")
         escreval("|                                                     3- CRÉDITOS (AUTOR)                                                     |")
         escreval("|                                                     4- COMO JOGAR                                                           |")
         escreval("|                                                                                                                             |")
         escreval("|                                                     9- SAIR DO JOGO                                                         |")
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
         leia(escolha_do_menu)
      ate ((escolha_do_menu >= 1) e (escolha_do_menu <= 4)) ou (escolha_do_menu = 9)
      escolha escolha_do_menu
      caso 1
         escolha_dificuldade
      caso 2
         logar
      caso 3
         creditos
      caso 4
         como_jogar
      caso 9
         finalizarjogo
      fimescolha
   senao
      repita
         limpatela
         cabecalho
         escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                     1- INICIAR JOGO                                                         |")
         escreval("|                                                     2- RANKING DE SCORES                                                    |")
         escreval("|                                                     3- CRÉDITOS (AUTOR)                                                     |")
         escreval("|                                                     4- COMO JOGAR                                                           |")
         escreval("|                                                                                                                             |")
         escreval("|                                                     8- SAIR DA SUA CONTA                                                    |")
         escreval("|                                                     9- SAIR DO JOGO                                                         |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
         exibir_jogador
         exibir_score
         escreval("|                                                                                                                             |")
         escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
         escreval
         escreva("> ")
         leia(escolha_do_menu)
      ate ((escolha_do_menu >= 1) e (escolha_do_menu <= 4)) ou (escolha_do_menu = 8) ou (escolha_do_menu = 9)

      escolha escolha_do_menu
      caso 1
         escolha_dificuldade
      caso 2
         lista_de_jogadores
      caso 3
         creditos
      caso 4
         como_jogar
      caso 8
         sair_da_conta
      caso 9
         finalizarjogo
      fimescolha
   fimse
fimprocedimento
// ###################################################################################################################################
// SISTEMA DE LOGIN
procedimento logar
var
   opcao: caracter
   num_escolha: inteiro
inicio
   se contador_user = 0 entao
      contador_user <- 0
   fimse
   repita
      limpatela
      cabecalho
      escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
      escreval("|                                                                                                                             |")
      escreval("|                                                 _                 _                                                         |")
      escreval("|                                                | |               (_)                                                        |")
      escreval("|                                                | |     ___   __ _ _ _ __                                                    |")
      escreval("|                                                | |    / _ \ / _` | | '_ \                                                   |")
      escreval("|                                                | |___| (_) | (_| | | | | |                                                  |")
      escreval("|                                                \_____/\___/ \__, |_|_| |_|                                                  |")
      escreval("|                                                              __/ |                                                          |")
      escreval("|                                                             |___/                                                           |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                1- REGISTRAR UMA NOVA CONTA                                                  |")
      escreval("|                                                2- ENTRAR EM UMA CONTA EXISTENTE                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                  (TECLE ENTER PARA VOLTAR)                                                  |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
      escreval
      escreva("> ")
      leia(opcao)
      se opcao = "1" entao
         num_escolha <- caracpnum(opcao)
      senao
         se opcao = "2" entao
            num_escolha <- caracpnum(opcao)
         senao
            se opcao = "" entao
               num_escolha <- 3
            fimse
         fimse
      fimse
   ate (num_escolha >= 1) e (num_escolha <= 3)
   escolha num_escolha
   caso 1
      se contador_user < 10 entao
         contador_user <- contador_user + 1
         digitar_nome
      senao
         escreva("(Máximo de jogadores atingido nesta sessão..)")
         timer 2000
         timer 0
         logar
      fimse
   caso 2
      se contador_user = 0 entao
         escreva("(Não hà jogadores registrados nesta sessão..)")
         timer 2000
         timer 0
         logar
      senao
         escolher_jogador
      fimse
   caso 3
      menu_game
   fimescolha
fimprocedimento
// ###################################################################################################################################
// SISTEMA PARA ESCOLHER JOGADOR EXISTENTE
procedimento escolher_jogador
var
   x, tam_nome: inteiro
   escrever_espaco: caracter
   escolha_do_jogador: inteiro
   max: inteiro
inicio
   repita
      limpatela
      cabecalho
      escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
      escreval("|                                        ___                       _                                                          |")
      escreval("|                                       |_  |                     | |                                                         |")
      escreval("|                                         | | ___   __ _  __ _  __| | ___  _ __ ___  ___                                      |")
      escreval("|                                         | |/ _ \ / _` |/ _` |/ _` |/ _ \| '__/ _ \/ __|                                     |")
      escreval("|                                     /\__/ / (_) | (_| | (_| | (_| | (_) | | |  __/\__ \                                     |")
      escreval("|                                     \____/ \___/ \__, |\__,_|\__,_|\___/|_|  \___||___/                                     |")
      escreval("|                                                   __/ |                                                                     |")
      escreval("|                                                  |___/                                                                      |")
      escreval("|                                                                                                                             |")
      escreval("|                                                      ESCOLHA UM JOGADOR:                                                    |")
      escreval("|                                           ----------------------------------------                                          |")
      escreva("|                                                       ")
      se user[1] <> "" entao
         tam_nome <- (67 - compr(user[1]))
         escrever_espaco <- ""
         para x de 1 ate tam_nome faca
            escrever_espaco <- escrever_espaco + " "
         fimpara
         escrever_espaco <- escrever_espaco + "|"
         escreval("1º ",user[1],escrever_espaco)
         max <- 1
      senao
         escreval("                                                                      |")
      fimse
      escreva("|                                                       ")
      se user[2] <> "" entao
         tam_nome <- (67 - compr(user[2]))
         escrever_espaco <- ""
         para x de 1 ate tam_nome faca
            escrever_espaco <- escrever_espaco + " "
         fimpara
         escrever_espaco <- escrever_espaco + "|"
         escreval("2º ",user[2],escrever_espaco)
         max <- 2
      senao
         escreval("                                                                      |")
      fimse
      escreva("|                                                       ")
      se user[3] <> "" entao
         tam_nome <- (67 - compr(user[3]))
         escrever_espaco <- ""
         para x de 1 ate tam_nome faca
            escrever_espaco <- escrever_espaco + " "
         fimpara
         escrever_espaco <- escrever_espaco + "|"
         escreval("3º ",user[3],escrever_espaco)
         max <- 3
      senao
         escreval("                                                                      |")
      fimse
      escreva("|                                                       ")
      se user[4] <> "" entao
         tam_nome <- (67 - compr(user[4]))
         escrever_espaco <- ""
         para x de 1 ate tam_nome faca
            escrever_espaco <- escrever_espaco + " "
         fimpara
         escrever_espaco <- escrever_espaco + "|"
         escreval("4º ",user[4],escrever_espaco)
         max <- 4
      senao
         escreval("                                                                      |")
      fimse
      escreva("|                                                       ")
      se user[5] <> "" entao
         tam_nome <- (67 - compr(user[5]))
         escrever_espaco <- ""
         para x de 1 ate tam_nome faca
            escrever_espaco <- escrever_espaco + " "
         fimpara
         escrever_espaco <- escrever_espaco + "|"
         escreval("5º ",user[5],escrever_espaco)
         max <- 5
      senao
         escreval("                                                                      |")
      fimse
      escreva("|                                                       ")
      se user[6] <> "" entao
         tam_nome <- (67 - compr(user[6]))
         escrever_espaco <- ""
         para x de 1 ate tam_nome faca
            escrever_espaco <- escrever_espaco + " "
         fimpara
         escrever_espaco <- escrever_espaco + "|"
         escreval("6º ",user[6],escrever_espaco)
         max <- 6
      senao
         escreval("                                                                      |")
      fimse
      escreva("|                                                       ")
      se user[7] <> "" entao
         tam_nome <- (67 - compr(user[7]))
         escrever_espaco <- ""
         para x de 1 ate tam_nome faca
            escrever_espaco <- escrever_espaco + " "
         fimpara
         escrever_espaco <- escrever_espaco + "|"
         escreval("7º ",user[7],escrever_espaco)
         max <- 7
      senao
         escreval("                                                                      |")
      fimse
      escreva("|                                                       ")
      se user[8] <> "" entao
         tam_nome <- (67 - compr(user[8]))
         escrever_espaco <- ""
         para x de 1 ate tam_nome faca
            escrever_espaco <- escrever_espaco + " "
         fimpara
         escrever_espaco <- escrever_espaco + "|"
         escreval("8º ",user[8],escrever_espaco)
         max <- 8
      senao
         escreval("                                                                      |")
      fimse
      escreva("|                                                       ")
      se user[9] <> "" entao
         tam_nome <- (67 - compr(user[9]))
         escrever_espaco <- ""
         para x de 1 ate tam_nome faca
            escrever_espaco <- escrever_espaco + " "
         fimpara
         escrever_espaco <- escrever_espaco + "|"
         escreval("9º ",user[9],escrever_espaco)
         max <- 9
      senao
         escreval("                                                                      |")
      fimse
      escreva("|                                                      ")
      se user[10] <> "" entao
         tam_nome <- (68 - compr(user[10]))
         escrever_espaco <- ""
         para x de 1 ate tam_nome faca
            escrever_espaco <- escrever_espaco + " "
         fimpara
         escrever_espaco <- escrever_espaco + "|"
         escreval("10º ",user[10],escrever_espaco)
         max <- 10
      senao
         escreval("                                                                       |")
      fimse
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
      leia(escolha_do_jogador)
   ate (escolha_do_jogador >= 1) e (escolha_do_jogador <= max)
   x <- escolha_do_jogador
   user_ativo <- escolha_do_jogador
   score_on <- verdadeiro
   nome_user <- user[x]
   score <- user_score[x]
   menu_game
fimprocedimento
// ###################################################################################################################################
// SISTEMA PARA SAIR DA CONTA ATUAL
procedimento sair_da_conta
var
inicio
   score_on <- falso
   score <- 0
   nome_user <- ""
   menu_game
fimprocedimento
// ###################################################################################################################################
// SISTEMA PARA REGISTRAR NOME DE JOGADOR
procedimento digitar_nome
var
   x: inteiro
   vetor_sem_jogador: logico
inicio
   repita
      limpatela
      cabecalho
      escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                  ______ _____ _____ _____ _____ _____   _____ _____ _   _   _   _ ________  ___ _____                       |")
      escreval("|                  |  _  \_   _|  __ \_   _|_   _|  ___| /  ___|  ___| | | | | \ | |  _  |  \/  ||  ___|                      |")
      escreval("|                  | | | | | | | |  \/ | |   | | | |__   \ `--.| |__ | | | | |  \| | | | | .  . || |__                        |")
      escreval("|                  | | | | | | | | __  | |   | | |  __|   `--. \  __|| | | | | . ` | | | | |\/| ||  __|                       |")
      escreval("|                  | |/ / _| |_| |_\ \_| |_  | | | |___  /\__/ / |___| |_| | | |\  \ \_/ / |  | || |___                       |")
      escreval("|                  |___/  \___/ \____/\___/  \_/ \____/  \____/\____/ \___/  \_| \_/\___/\_|  |_/\____/                       |")
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
      leia(nome_user)
      nome_user <- maiusc(nome_user)
   ate (compr(nome_user) >= 3) e (compr(nome_user) <= 15)
   x <- contador_user
   user_ativo <- contador_user
   user[x] <- nome_user
   score_on <- verdadeiro
   score <- 0
   menu_game
fimprocedimento
// ###################################################################################################################################
// SISTEMA PARA EXIBIR LISTA DE JOGADORES JÁ CADASTRADOS
procedimento lista_de_jogadores
var
   enter: caracter
   x, tam_nome, tam_score: inteiro
   escrever_espaco: caracter
inicio
   repita
      limpatela
      cabecalho
      escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
      escreval("|                                             ______            _    _                                                        |")
      escreval("|                                             | ___ \          | |  (_)                                                       |")
      escreval("|                                             | |_/ /__ _ _ __ | | ___ _ __   __ _                                            |")
      escreval("|                                             |    /  _` | '_ \| |/ / | '_ \ / _` |                                           |")
      escreval("|                                             | |\ \ (_| | | | |   <| | | | | (_| |                                           |")
      escreval("|                                             \_| \_\__,_|_| |_|_|\_\_|_| |_|\__, |                                           |")
      escreval("|                                                                             __/ |                                           |")
      escreval("|                                                                            |___/                                            |")
      escreval("|                                       ------------------------------------------------                                      |")
      escreva("|                                           1º ",user[1])
      tam_nome <- (28 - compr(user[1]))
      escrever_espaco <- ""
      para x de 1 ate tam_nome faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreva(escrever_espaco,"SCORE: ",user_score[1])
      tam_score <- (43 - (compr(numpcarac(user_score[1]))))
      escrever_espaco <- ""
      para x de 1 ate tam_score faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreval(escrever_espaco,"|")
      escreva("|                                           2º ",user[2])
      tam_nome <- (28 - compr(user[2]))
      escrever_espaco <- ""
      para x de 1 ate tam_nome faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreva(escrever_espaco,"SCORE: ",user_score[2])
      tam_score <- (43 - (compr(numpcarac(user_score[2]))))
      escrever_espaco <- ""
      para x de 1 ate tam_score faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreval(escrever_espaco,"|")
      escreva("|                                           3º ",user[3])
      tam_nome <- (28 - compr(user[3]))
      escrever_espaco <- ""
      para x de 1 ate tam_nome faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreva(escrever_espaco,"SCORE: ",user_score[3])
      tam_score <- (43 - (compr(numpcarac(user_score[3]))))
      escrever_espaco <- ""
      para x de 1 ate tam_score faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreval(escrever_espaco,"|")
      escreva("|                                           4º ",user[4])
      tam_nome <- (28 - compr(user[4]))
      escrever_espaco <- ""
      para x de 1 ate tam_nome faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreva(escrever_espaco,"SCORE: ",user_score[4])
      tam_score <- (43 - (compr(numpcarac(user_score[4]))))
      escrever_espaco <- ""
      para x de 1 ate tam_score faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreval(escrever_espaco,"|")
      escreva("|                                           5º ",user[5])
      tam_nome <- (28 - compr(user[5]))
      escrever_espaco <- ""
      para x de 1 ate tam_nome faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreva(escrever_espaco,"SCORE: ",user_score[5])
      tam_score <- (43 - (compr(numpcarac(user_score[5]))))
      escrever_espaco <- ""
      para x de 1 ate tam_score faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreval(escrever_espaco,"|")
      escreva("|                                           6º ",user[6])
      tam_nome <- (28 - compr(user[6]))
      escrever_espaco <- ""
      para x de 1 ate tam_nome faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreva(escrever_espaco,"SCORE: ",user_score[6])
      tam_score <- (43 - (compr(numpcarac(user_score[6]))))
      escrever_espaco <- ""
      para x de 1 ate tam_score faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreval(escrever_espaco,"|")
      escreva("|                                           7º ",user[7])
      tam_nome <- (28 - compr(user[7]))
      escrever_espaco <- ""
      para x de 1 ate tam_nome faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreva(escrever_espaco,"SCORE: ",user_score[7])
      tam_score <- (43 - (compr(numpcarac(user_score[7]))))
      escrever_espaco <- ""
      para x de 1 ate tam_score faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreval(escrever_espaco,"|")
      escreva("|                                           8º ",user[8])
      tam_nome <- (28 - compr(user[8]))
      escrever_espaco <- ""
      para x de 1 ate tam_nome faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreva(escrever_espaco,"SCORE: ",user_score[8])
      tam_score <- (43 - (compr(numpcarac(user_score[8]))))
      escrever_espaco <- ""
      para x de 1 ate tam_score faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreval(escrever_espaco,"|")
      escreva("|                                           9º ",user[9])
      tam_nome <- (28 - compr(user[9]))
      escrever_espaco <- ""
      para x de 1 ate tam_nome faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreva(escrever_espaco,"SCORE: ",user_score[9])
      tam_score <- (43 - (compr(numpcarac(user_score[9]))))
      escrever_espaco <- ""
      para x de 1 ate tam_score faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreval(escrever_espaco,"|")
      escreva("|                                          10º ",user[10])
      tam_nome <- (28 - compr(user[10]))
      escrever_espaco <- ""
      para x de 1 ate tam_nome faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreva(escrever_espaco,"SCORE: ",user_score[10])
      tam_score <- (43 - (compr(numpcarac(user_score[10]))))
      escrever_espaco <- ""
      para x de 1 ate tam_score faca
         escrever_espaco <- escrever_espaco + " "
      fimpara
      escreval(escrever_espaco,"|")
      escreval("|                                       ------------------------------------------------                                      |")
      escreval("|                                                                                                                             |")
      escreval("|                                                  (TECLE ENTER PARA VOLTAR)                                                  |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
      leia(enter)
   ate enter = ""
   menu_game
fimprocedimento
// ###################################################################################################################################
// EXIBIR NA TELA CASO: ESCOLHA OPÇÃO COMO JOGAR
procedimento como_jogar
var
   enter: caracter
inicio
   repita
      limpatela
      cabecalho
      escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
      escreval("|                                   _____                           ___                                                       |")
      escreval("|                                  /  __ \                         |_  |                                                      |")
      escreval("|                                  | /  \/ ___  _ __ ___   ___       | | ___   __ _  __ _ _ __                                |")
      escreval("|                                  | |    / _ \| '_ ` _ \ / _ \      | |/ _ \ / _` |/ _` | '__|                               |")
      escreval("|                                  | \__/\ (_) | | | | | | (_) | /\__/ / (_) | (_| | (_| | |                                  |")
      escreval("|                                   \____/\___/|_| |_| |_|\___/  \____/ \___/ \__, |\__,_|_|                                  |")
      escreval("|                                                                              __/ |                                          |")
      escreval("|                                                                             |___/                                           |")
      escreval("|                                                                                                                             |")
      escreval("|                         1. PARA COMEÇAR A JOGAR VOCÊ DEVE ESCOLHER UM NIVEL DE DIFICULDADE.                                 |")
      escreval("|                            > CADA NIVEL REPRESENTA UMA QUANTIDADE DE MINAS ESPALHADAS PELA TABELA.                          |")
      escreval("|                         2. OPÇÃO DE DESCOBRIR AUTOMATICO - REVELA ATÉ 8 CAMPOS ALEATÓRIOS A VOLTA DA SUA ESCOLHA.           |")
      escreval("|                         3. PARA JOGAR VOCÊ DEVE SELECIONAR A COLUNA/LINHA DIGITANDO QUANDO REQUISITADO.                     |")
      escreval("|                            > CONFIRMAR A ESCOLHA - TECLE <ENTER>                                                            |")
      escreval("|                            > MARCAR OU DESMARCAR UMA FLAG - TECLE <B>                                                       |")
      escreval("|                            > SAIR DO GAME - TECLE <S>                                                                       |")
      escreval("|                         4. OBJETIVO FINAL É ESCOLHER TODOS OS CAMPOS, SEM ACERTAR UMA MINA                                  |")
      escreval("|                         5. ACUMULAR SCORE - CADA ACERTO REPRESENTA 10 PONTOS DE SCORE. (ACUMULATIVO)                        |")
      escreval("|                                                                                                                             |")
      escreval("|                                                (TECLE ENTER PARA VOLTAR)                                                    |")
      escreval("|                                                                                                                             |")
      se score_on = verdadeiro entao
         exibir_jogador
         exibir_score
      senao
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
      fimse
      escreval("|                                                                                                                             |")
      escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
      leia(enter)
   ate enter = ""
   menu_game
fimprocedimento
// ###################################################################################################################################
// EXIBIR NA TELA CASO: ESCOLHA OPÇÃO DOS CREDITOS DO GAME
procedimento creditos
var
   enter: caracter
inicio
   repita
      limpatela
      cabecalho
      escreval("|    --------------------------------------------------------------------------------------------------------------------     |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                  ___        _                                                               |")
      escreval("|                                                 / _ \      | |                                                              |")
      escreval("|                                                / /_\ \_   _| |_ ___  _ __                                                   |")
      escreval("|                                                |  _  | | | | __/ _ \| '__|                                                  |")
      escreval("|                                                | | | | |_| | || (_) | |                                                     |")
      escreval("|                                                \_| |_/\__,_|\__\___/|_|                                                     |")
      escreval("|                                                                                                                             |")
      escreval("|                                                   ALISON LUIZ DA SILVA                                                      |")
      escreval("|                                               Estudante de Eng. de Software                                                 |")
      escreval("|                                                Professor: Alexandre Moreno                                                  |")
      escreval("|                                                         02/2022                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                (TECLE ENTER PARA VOLTAR)                                                    |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      escreval("|                                                                                                                             |")
      se score_on = verdadeiro entao
         exibir_jogador
         exibir_score
      senao
         escreval("|                                                                                                                             |")
         escreval("|                                                                                                                             |")
      fimse
      escreval("|                                                                                                                             |")
      escreval("|-----------------------------------------------------------------------------------------------------------------------------|")
      leia(enter)
   ate enter = ""
   menu_game
fimprocedimento
// ###################################################################################################################################
// CABEÇALHO DO GAME (CAMPO MINADO)
procedimento cabecalho
var
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
fimprocedimento
// ###################################################################################################################################
// INICIO DO GAME - INSTRUÇOES
procedimento start_game_maximizar_tela
var
   enter: caracter
inicio
   repita
      limpatela
      escreval("|---------------------------------------------------|")
      escreval("|                                                   |")
      escreval("|                                                   |")
      escreval("|        POR GENTILEZA, USAR A TELA INTEIRA         |")
      escreval("|        DO MS-DOS PARA MELHOR EXPERIENCIA.         |")
      escreval("|          (RECOMENDADO USAR VERSÃO 3.0.7)          |")
      escreval("|                                                   |")
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
// ###################################################################################################################################
// ANIMAÇÃO INICIAL DO GAME
procedimento start_game
var
   enter: caracter
inicio
   timer 500
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
   start_game_um
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
   start_game_um
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
   start_game_um
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
   start_game_um
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
   start_game_um
   timer 100
   limpatela
   timer 0
   cabecalho
   start_game_um
   timer 300
   limpatela
   timer 0
   repita
      limpatela
      cabecalho
      start_game_dois
      leia(enter)
   ate enter = ""
   menu_game
fimprocedimento
procedimento start_game_um
var
inicio
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
fimprocedimento
procedimento start_game_dois
var
inicio
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
fimprocedimento
// ###################################################################################################################################
Inicio
   start_game_maximizar_tela
Fimalgoritmo
//
// Hackzin
// Digitar 99 na Coluna/Linha - descobre todas as minas da tabela