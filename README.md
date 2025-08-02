# Menu-Suporte
Um arquivo Bat para ajudar no Suporte
Menu de Suporte Técnico (Script .bat)
Um script de lote (.bat) para Windows que fornece um menu de acesso rápido para executar tarefas comuns de solução de problemas e suporte técnico. Criado para agilizar diagnósticos e aplicar correções frequentes sem a necessidade de memorizar ou digitar múltiplos comandos no prompt.

🚀 Funcionalidades
O script apresenta um menu interativo com as seguintes opções:

1 - Reiniciar computador: Agenda uma reinicialização do sistema em 10 segundos.

2 - Otimizar (Lentidão): Realiza uma limpeza de arquivos temporários e executa o Verificador de Arquivos do Sistema (sfc /scannow) para reparar arquivos corrompidos do Windows.

3 - Flush DNS: Limpa o cache de resolução de DNS do sistema, útil para corrigir problemas de acesso a sites ou falhas de conexão.

4 - Verificar informações completas da rede: Exibe todas as configurações de rede do computador, incluindo endereço IP, MAC, servidores DNS, etc. (ipconfig /all).

5 - Ping Servidor: Permite testar a conectividade com um servidor ou site específico através de pings contínuos (ping -t), ajudando a diagnosticar problemas de latência ou perda de pacotes.

6 - Fix erro 0x0000011b (Impressora): Aplica uma correção conhecida no registro do Windows para o erro de impressão em rede 0x0000011b.

7 - Fix erro 0x00000bcb (Impressora): Limpa a fila de impressão e reinicia o serviço de spooler, resolvendo problemas de trabalhos de impressão que ficam "travados".

8 - Fix erro 0x00000709 (Impressora Padrão): Aplica uma correção no registro que resolve o erro que impede a definição de uma nova impressora como padrão.

9 - Reiniciar spooler de impressão: Uma forma rápida de parar e iniciar o serviço de impressão do Windows, solucionando diversas falhas gerais de comunicação com a impressora.

0 - Sair: Fecha a janela do script.

📋 Requisitos
Sistema Operacional Windows (7, 8, 10, 11).

Privilégios de Administrador para execução completa de todas as funções.

💡 Como Usar
Faça o download do arquivo suporte.bat (ou o nome que você salvou).

Clique com o botão direito do mouse sobre o arquivo e selecione "Executar como administrador".

O menu de suporte será exibido no prompt de comando.

Digite o número da opção desejada e pressione Enter.

Siga as instruções na tela. Após a conclusão de cada tarefa, o menu será exibido novamente.

⚠️ Aviso Legal
Este script foi criado para fins educacionais e de otimização de tarefas. Ele realiza modificações no sistema, incluindo alterações no Registro do Windows e exclusão de arquivos temporários.

Use-o por sua conta e risco. O autor não se responsabiliza por quaisquer danos, perda de dados ou problemas que possam ocorrer no seu sistema. É recomendado que você entenda o que cada comando faz antes de executá-lo e, se possível, tenha um backup de seus dados importantes.
