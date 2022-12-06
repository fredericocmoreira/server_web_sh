# Servidor Web Linux
Shell Script totalmente automatizado para verificação, instalar e remoção de todos os softwares necessários para executar qualquer estrutura web no Linux. Instalação do apache, MariaDB/MySQL e php, fazendo a configuração do “mysql_secure_installation”.

Além da descrição, aqui estão alguns pontos que este script executa:
- Atualização de todas as dependências necessárias do sistema.
- Instalação do Apache2.
- Instalação do Php7.4 e extensões populares.
- Instalação segura do MariaDB (mysql).


## Atenção
- Não nos responsabilizamos por qualquer perda que você possa sofrer, não recomendamos a instalação em ambientes de produção.


## Instalação completa

Este script poderá ser executado normalmente, onde o mesmo utiliza o “Dialog” para torna as coisas mais intuitivas e facies para usuários sem experiencia.</br>
No menu do script teremos três opções: 
- “Check” – onde ele verificara se os softwares necessários estarão instalados e nós retornando com o valor false(OFF) ou true(ON).
- “Instalar” – nesta opção o script ira instalar todas as dependências necessárias, junto com os softwares requisitados para o uso do servidor web e ira fazer a configuração do arquivo de seguração do MariaDB/MySQL “mysql_secure_installation”.
- “Remover” – Opção para remover os software do servidor web já instalados.


## Inspeção manual

Sempre é uma boa ideia inspecionar o script que você ainda não conhece, podendo ser feito o download e a verificação com calma etê entender o real proposito do mesmo, ai então rodá-lo:</br>
`bash instalacao_servidor_web.sh`

## Variáveis de ambiente

### Distribuição Linux
- ``METODO_LX`` Gerenciamento de pacotes, apt-get; yum; dnf; pkg…
- ``SUDO`` Privilégios root. 
- ``SENHA_ROOT`` Será a senha configurada no “mysql secure”.

### Versões
- ``APACHE_V`` Nome do pacote que será instalado e verificado “which”.
- ``MYSQL_NOME`` Nome do pacote que será verificado “which”. 
- ``MYSQL_VS`` Nome do pacote “-server” que será instalado.
- ``MYSQL_VC`` Nome do pacote “-client” que será instalado.
- ``PHP_V`` Nome do pacote que será instalado e verificado “which”.
