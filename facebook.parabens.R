##################################################################################
# APLICATIVO DE PARABENS NO FACEBOOK
# AUTOR: PEDRO CARVALHO BROM
# EMAIL: pcbrom@gmail.com
# CV LATTES: lattes.cnpq.br/0154064396756002
# GITHUB: https://github.com/pcbrom
##################################################################################


##################################################################################
# INICIALIZACAO, WEBDRIVER E CARREGAR O QUE FOR NECESSARIO
##################################################################################

# LIMPAR MEMORIA DO R
rm(list=ls(all=T))

# DEFINIR PASTA DE TRABALHO Crtl + Shift + H
setwd("SUA_PASTA_DE_TRABALHO")

# INSTALAR E INVOCAR A BIBLIOTECA
require(RSelenium)

# VERIFICAR O SERVIDOR E BAIXAR SE NECESSARIO
RSelenium::checkForServer()

# INICIAR O SERVIDOR
RSelenium::startServer()

# AJUSTAR O WEBDRIVER
remDr = remoteDriver(browserName = "firefox"); Sys.sleep(2)

# NAVEGACAO
remDr$open(silent = T); Sys.sleep(5)

# IR ATE A URL (neste ponto acesse o aplicativo no celular e habilite para web)
url = 'https://www.facebook.com/'; remDr$sendKeysToActiveElement(list(url, key = "enter")); Sys.sleep(5)

##################################################################################
# LOGIN
##################################################################################

# ENCONTRAR O ELEMENTO 'EMAIL'
email.face = "SEU_EMAIL_DO_FACE" # INSIRA O SE EMAIL
webElem = remDr$findElement(using = 'xpath', "//input[@id='email']")$sendKeysToElement(list(email.face))
Sys.sleep(1)

# ENCONTRAR O ELEMENTO 'PASS'
senha.face = "SUA_SENHA_DO_FACE" # INSIRA A SUA SENHA
webElem = remDr$findElement(using = 'xpath', "//input[@id='pass']")$sendKeysToElement(list(senha.face))
Sys.sleep(1)

# ENCONTRAR O 'LOGINBUTTON'
webElem = remDr$findElement(using = 'xpath', "//label[@id='loginbutton']")$clickElement()
Sys.sleep(3)

##################################################################################
# ANIVERSARIANTES DO DIA
##################################################################################

# IR ATE A PAGINA DE ANIVERSARIANTES
url = 'https://www.facebook.com/events/birthdays'
webElem = remDr$navigate(url)
Sys.sleep(3)

# PEGAR O CODIGO FONTE DA PAGINA
web.page.source = remDr$getPageSource()

# LIMPAR E IDENTIFICAR OS IDS DOS ANIVERSARIANTES
limpar.ids = function(data) {
  apoio = data[grep("Aniversariantes do dia", data)]
  apoio = gsub("*.*Aniversariantes do dia", "", apoio)
  apoio = gsub("Próximos aniversários*.*", "", apoio)
  apoio = unlist(strsplit(apoio, "textarea id=\""))
  apoio = apoio[-1]
  apoio = gsub("\" onkeydown=*.*", "", apoio)
  return (apoio)
}

ids.enviar = limpar.ids(web.page.source)

##################################################################################
# PREPARAR A MENSAGEM
##################################################################################

# PALAVRAS DE FELICITACOES

# AQUI PREFERI PEGAR FRASES PADRONIZADAS PELA INTERNET E ESBARREI COM ESTE LINK
# url.frases = "http://www.mensagenscomamor.com/frases/frases_curtas_aniversario.htm"

# LIMPAR FRASES
# limpar.frases = function(url) {
#   apoio = getURL(url, followlocation = TRUE, .encoding = 'UTF-8')
#   apoio = htmlParse(apoio, asText = TRUE, encoding = "UTF-8")
#   node.apoio = xmlRoot(apoio)
#   apoio = xpathSApply(node.apoio, "//p", xmlValue, encoding = "UTF-8")
#   apoio = apoio[-c(1:5,9,16,22,24:26,28:30,34:39,42:52)] # REMOVENDO ALGUMAS MENSAGENS ESTRANHAS
#   return (apoio)
# }

# VETOR DE FRASES
# frases.txt = limpar.frases(url.frases)

# FIZ ALGUMAS ALTERACOES NO TEXTO DAS FRASES PARA FICAREM DO TIPO "CORINGA"
frases.txt = c(
  "Que todos os seus sonhos sejam realizados e todos os seus desejos alcançados. É o seu aniversário, agite-se! Boa Festa e parabéns!",
  "Hoje poderia ser feriado nacional. Parabéns pelo seu aniversário !",
  "Seja este dia o mais alegre que tua alma possa desejar. Que com bênçãos, o céu te regue e venham os anjos contigo cantar. Feliz Aniversário!",
  "A vida é um milhão de novos começos movidos pelo desafio sempre novo de viver e fazer todo sonho brilhar. Feliz Aniversário.",
  "Aproveite este dia para desfrutar das coisas boas que fazem você feliz. Feliz Aniversário.",
  "Hoje é o teu dia. É uma boa oportunidade para te dizer todas as coisas especiais são para ti. Desejo um Feliz Aniversário.",
  "Que o show de sua vida dure para sempre. Feliz aniversário!",
  "Todo dia é uma nova oportunidade que a vida oferece a quem nela crê. Aproveite o seu dia. Feliz Aniversário!",
  "Um aniversário é apenas o começo de mais uma jornada de 365 dias. Desejo-te boa viagem. Parabéns!",
  "Que além dos aniversários e através do sempre você seja muito feliz. Parabéns!",
  "Parabéns. No dia do seu aniversário, tenha um dia super feliz, com tudo o que você tem direito, muita festa e um monte de emoção.",
  "Trinta minutos, trinta dias, trinta anos. O que vale é a intensidade com que se vive! Seja sempre feliz! Parabéns!",
  "Que a tua vida seja sempre uma soma de vitórias. Parabéns.",
  "No seu Aniversário tomara que chova.... presentes, alegrias, felicidades, amizades e muitas realizações. Parabéns!",
  "Que neste dia todas as alegrias do mundo sejam suas! Parabéns.",
  "É época de festa, alegrias e muita diversão!",
  "Comemore com muita alegria e muitas risadas!",
  "Desejo um ótimo aniversário e muita saúde!",
  "Celebre este dia especial com muito amor e união. Esteja com a sua família",
  "Inspire sempre a motivação na vida das pessoas!"
)

# FUNCAO PARA ESCOLHA DA FRASE
tamanho.vetor = length(frases.txt)
escolher.frase = function(num.value = round(runif(1, 0, tamanho.vetor))) {
  if (num.value == 0) {while (num.value == 0) {num.value = round(runif(1, 0, tamanho.vetor))}}
  frase = frases.txt[num.value]
  return (frase)
}

##################################################################################
# ENVIAR A MENSAGEM
##################################################################################

# ENVIANDO A FRASE PARA CADA ANIVERSARIANTE
total.envios = length(ids.enviar)

for (i in 1:total.envios) {
  frase.escolhida = escolher.frase() # ESCOLHENDO A FRASE
  obj.envio = paste0("//textarea[@id=", "'", ids.enviar[i], "'", "]")
  webElem = remDr$findElement(using = 'xpath', obj.envio)$sendKeysToElement(list(frase.escolhida, key = "enter"))
  Sys.sleep(1)
}

##################################################################################
# FECHAR O PROGRAMA
##################################################################################
remDr$close()
remDr$closeServer()
