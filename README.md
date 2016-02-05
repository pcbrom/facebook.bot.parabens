# Facebook.Bot.Parabens
Robô de envio de mensagens (parabéns) no Facebook.
Foi utulizado esta versão do RSelenium: http://ropensci.github.io/RSelenium/

O script está comentado e detalhado.

Para deixar rodando de modo automático utilize o arquivo "face.bot.parabens.bat", se Windows ou o "face.bot.parabens.sh", se Linux.


### Linux =D: Use "face.bot.parabens.sh"

01) Abra o terminal e digite:
crontab -e

02) Escolha o editor e insira a seguinte linha:
00 12 * * * root LOCAL_DO_ARQUIVO/face.bot.parabens.sh

Está pronto.

Vamos só interpretar o passo 02 para ficar mais claro o que foi realizado:

i) 00 12 -> Diariamente, às 12:00h será executado
ii) * * * root -> Pelo usuário root
iii) LOCAL_DO_ARQUIVO/face.bot.parabens.sh -> O script face.bot.parabens.sh


### Windows: Use "face.bot.parabens.bat"

Utilize o Agendador de tarefas, encontrado no Painel de controle.

![Agendador de Tarefas](https://cloud.githubusercontent.com/assets/10408245/12852609/f61d665c-cc16-11e5-9c8c-fb2d9fd54137.jpg)

Na aba Ações clique em Criar uma Tarefa Básica.

![Tarefa Básica](https://cloud.githubusercontent.com/assets/10408245/12852608/f61d20ca-cc16-11e5-80b1-ff8019675abf.jpg)

Adicione o nome que será usado. Clique em avançar.

![Adicione o nome](https://cloud.githubusercontent.com/assets/10408245/12852610/f61da4aa-cc16-11e5-915d-b6de0590b859.jpg)

No Disparador você definirá o quão constante ocorrerá a execução do programa. Nesse caso foi escolhido Diariamente.

![Rotina de disparo](https://cloud.githubusercontent.com/assets/10408245/12852613/f62750e0-cc16-11e5-9a3d-e3c01ff5fe5e.jpg)

Na próxima tela foi definido que a ação será repetida a cada 01 dia. Clique em avançar.

![Frequência de disparo](https://cloud.githubusercontent.com/assets/10408245/12852611/f62149e8-cc16-11e5-962b-0f49008d794c.jpg)

A ação será iniciar um programa, deixe a opção marcada e clique em avançar.

![Iniciar um programa](https://cloud.githubusercontent.com/assets/10408245/12852612/f623fecc-cc16-11e5-986b-9fc1f29871a3.jpg)

Agora o programa / script usado é o face.bot.parabens.bat. Clique em avançar.

![Nome do programa](https://cloud.githubusercontent.com/assets/10408245/12852614/f635c68e-cc16-11e5-8a39-199cb2c3ee68.jpg)

Verifique se está tudo certo e clique em concluir.

![Concluir](https://cloud.githubusercontent.com/assets/10408245/12852615/f63c84c4-cc16-11e5-9eb3-4683388ec85d.jpg)
