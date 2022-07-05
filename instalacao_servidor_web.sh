#!/usr/bin/env bash
#!/usr/bin/expect
#
# inst_apache.sh - Instalação do apache
#
# Autor:      Frederico Moreira
# Manutenção: Frederico Moreira
#
# ------------------------------------------------------------------------ #
#  Este script faz a instalação e a configuração inicial para um servidor
#  web, usando o "Dialog" para transformar esta instalação mais intuitiva
#  e fácil para usuários iniciantes.
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 29/06/2022, Frederico: Criação do script
#
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.4(1)-release  --  Ubuntu
# ------------------------------------------------------------------------ #
# -------------------------- VARIÁVEIS DE VERSÕES-----------------------------------#

APACHE_V="apache2" # Verificação / instalação
MYSQL_NOME="mariadb" # Verificação
MYSQL_VS="mariadb-server" # Instalação
MYSQL_VC="mariadb-client" # Instalação
PHP_V="php7.4" # Verificação / instalação

# ------------------------------- VARIÁVEIS ----------------------------------------#

METODO_LX="apt" # - Alterar de acordo com sua distribuição.
SUDO=$()     # - Altere de acordo com sua distribuição, na linha 39.

UPGRADE="${SUDO} ${METODO_LX} upgrade -y"
UPDATE="${SUDO} ${METODO_LX} update"

SENHA_ROOT="p@s$w0rd"
NEC_SOF="${SUDO} ${METODO_LX} install systemctl -y" # instalação/Atualização do systemctl.

TEMP=temp.$$

# ------------------------------- TESTES ----------------------------------------- #
[ ! `whoami` == 'root' ] && FSUDO=${SUDO:=sudo}

[ ! -x "$(which dialog)" ] && $sudo $METODO_LX install dialog 1> /dev/null 2>&1
# ------------------------------- FUNÇÕES ----------------------------------------- #
Check_app_inst () {
  echo -e "Relação dos aplicativos instalados:\n" > "$TEMP"

  ################################################
  # Verifica o Apache                            #
  if [ -x "$(which $APACHE_V)" ]; then             #
    echo -e "ON -- Apache" >> "$TEMP"            #
  else                                           #
    echo -e "Apache  -- OFF" >> "$TEMP"          #
  fi                                             #
  # Verifica o Mysql                             #
  if [ -x "$(which $MYSQL_NOME)" ]; then               #
    echo -e "ON -- Mysql" >> "$TEMP"             #
  else                                           #
    echo -e "Mysql   -- OFF" >> "$TEMP"          #
  fi                                             #
  # Verifica o Php                               #
  if [ -x "$(which $PHP_V)" ]; then                 #
    echo -e "ON -- Php" >> "$TEMP"               #
  else                                           #
    echo -e "Php     -- OFF" >> "$TEMP"          #
  fi                                             #
  ################################################

  dialog --title "Scan app install" --textbox "$TEMP" 20 40
  rm -f "$TEMP"
}

############### APACHE ###############
Inst_apache2 () {
  $SUDO $METODO_LX install $APACHE_V -y
  $SUDO /etc/init.d/$APACHE_V restart
  $SUDO systemctl enable $APACHE_V
  echo "<!DOCTYPE html>
<html>
  <style media="screen">
    h1 {
      text-align: center;
    }
  </style>
  <head>
      <title>Bem-vindo ao Server Web</title>
  </head>
  <body>
      <h1>Sucesso!  Servidor web instalado com sucesso.</h1>
  </body>
</html>" > /var/www/html/index.html
}

############### MYSQL ################
Inst_mysql () {
  $SUDO $METODO_LX install $MYSQL_VS $MYSQL_VC -y
  $SUDO /etc/init.d/$MYSQL_NOME restart
  # Configuração do Mysql Secure.
  $SUDO $METODO_LX install expect -y
  expect -c "
      set timeout 3
      spawn mysql_secure_installation

      expect \"Enter current password for root (enter for none):\"
      send -- \"$SENHA_ROOT\r\"
      expect \"Switch to unix_socket authentication\"
      send -- \"n\n\"
      expect \"Set root password?\"
      send -- \"n\n\"
      expect \"Remove anonymous users?\"
      send -- \"Y\n\"
      expect \"Disallow root login remotely?\"
      send -- \"Y\n\"
      expect \"Remove test database and access to it?\"
      send -- \"Y\n\"
      expect \"Reload privilege tables now?\"
      send -- \"Y\n\"
      expect eof
      "

}

############### PHP ##################
Inst_php () {
  $UPDATE
  $SUDO $METODO_LX install software-properties-common -y
  $SUDO add-apt-repository ppa:ondrej/php -y
  $UPDATE
  $SUDO $METODO_LX install "$PHP_V" -y
}

######## Instalação Completa #########
Inst_completa () {
  NEC_SOF
  Inst_apache2
  Inst_mysql
  Inst_php
  if [ -x "$(which $APACHE_V | which $MYSQL_NOME | which $PHP_V)" ]; then
    dialog --title "SUCESSO!" --msgbox "Server Web instalado com sucesso!" 6 40
  else
    dialog --title "ERRO!" --msgbox "Erro! Check os aplicativos instalados." 6 40
  fi

}

####### Remover Server Web #######
Rem_serv () {
  $SUDO $METODO_LX remove --purge apache* -y
  $SUDO $METODO_LX remove --purge php* -y
  $SUDO $METODO_LX remove --purge $MYSQL_NOME* -y
  $SUDO $METODO_LX autoremove -y
  $SUDO rm -rf /var/lib/mysql
  $SUDO rm -rf /etc/mysql
  $SUDO $METODO_LX autoclean
}

# ------------------------------- EXECUÇÃO ----------------------------------------- #
while :
do
  acao=$(dialog --title "Servidor Web - Shell Script" \
                --stdout \
                --menu "Instalador - v1.0" \
                0 0 0 \
                check "Scanner e verificar app instalados" \
                instalar "Instalar/Reparar 'Server Web'" \
                remover "Remover 'Server Web'" )
  [ $? -ne 0 ] && exit

  case $acao in
    check)     Check_app_inst  ;;
    instalar)  Inst_completa   ;;
    remover)   Rem_serv        ;;
  esac
done
