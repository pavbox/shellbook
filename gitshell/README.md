# gitshell


env.sh:

```

  Utility adds all RSA keys to Agent (ssh) on console startup for this user session (mac).
  But on Windows Agent session lives into one console process (window)
  and resets if you close console window.

  Утилита добавляет все RSA ключи в ssh агент во время запуска консоли.
  Ключи работают для текущей сессии пользователя ОС (на маке).
  А на Windows у меня приходилось каждый раз добавлять ключи.
  Для каждой сессии консоли, причем ключи работали только в том окне где они были добавлены.

```

На Windows вам нужно добавить этот скрипт в файл .bashrc (я использую git bash поставляемый с [git](https://git-scm.com/downloads)).

На Mac/Linux можно создать файл env.sh и указать к нему ссылку из .bashrc.

```shell

# Add env.sh
  source ~/Projects/_config/scripts/shells/env.sh

```
