# gitshell


Problems:
- [Automatic addition RSA keys into current console session](/gitshell#gitshell)



## Automatic addition RSA keys into current console session

### what is this thing

Automatic append RSA keys into ssh-agent session.

env.sh:

```

  Utility adds all RSA keys to Agent (ssh) on console startup for this user session (mac).
  But on Windows Agent session lives into one console process (window)
  and resets if you close console window.

```

On Windows you need add this script into .bashrc (I using git bash from [git](https://git-scm.com/downloads)).
On Mac or Linux you can create env.sh file and set path to his from .bashrc.

```shell

# Add env.sh
  source ~/Projects/_config/scripts/shells/env.sh

```


### краткое описание

Автоматическое добавление RSA ключей в сессию ssh агента.

```

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



gitssh.sh:

```

    Похожая утилита на env.sh. Но ее нужно запускать руками.
    Преимуществ перед env.sh нет. Просто еще одна попытка написать решение
    для автоматического добавления RSA ключей в ssh агент.

```
