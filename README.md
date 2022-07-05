# Servidor Web Linux
Shell Script totalmente automatizado para verificação, instalar e remoção de todo o software necessário para executar qualquer estrutura web no Linux. Instalação do apache, MariaDB/MySQL e php, fazendo a configuração do “mysql_secure_installation”.

Além da descrição, aqui estão algumas coisas que este script faz:
- Atualiza todas as dependências necessárias do sistema.
- Instalação Apache2.
- Instalação Php7.4 e extensões populares.
- Instalação segura MariaDB (mysql).


### Atenção
- Não nos responsabilizamos por qualquer perda que você possa sofrer, não recomendamos a instalação em ambientes de produção.


### Instalação completa

Este script e executado normalmente, onde o mesmo utiliza o “Dialog” para torna as coisas mais intuitivas. 
No menu teremos três opções: 
- “Check” – onde ele verificara se os software necessários estão instalados, retornando com o valor false(OFF) e true(ON).
- “Instalar” – nesta opção o script ira instalar todas as dependências necessárias e junto os softwares requisitados para o servidor web e também a configuração do arquivo de seguração do MariaDB/MySQL “ mysql_secure_installation”.
- “Remover” – Fundamenta para caso tenha alguma aplicação já instalada, está ira remover tudo relacionado ao servidor web para poder fazer uma nova instalação totalmente limpa.


#### Inspeção manual

Sempre é uma boa ideia inspecionar o script de instalação que você ainda não conhece, podendo ser feito o download e a verificação com calma etê entender o real proposito dele, ai então rodá-lo:</br>
`bash instalacao_servidor_web.sh`
