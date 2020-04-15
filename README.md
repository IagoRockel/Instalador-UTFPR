# Instalador UTFPR

Este é um projeto para instalar diversos softwares de terceiros automaticamente, nas máquinas da UTFPR configuradas pelo DEINFRA, sem a necessidade de intervenção do usuário.

## Softwares
A lista dos softwares inclusos no instalador podem ser encontradas clicando [aqui](../master/Software%20de%20terceiros.md). Neste documento também estão inclusos os links para as páginas de download dos arquivos utilizados.

## Instalador
O código do instalador desevolvido pode ser encontrado neste [link](../master/instalador.nsi). Para compilar o script deve-se utilizar o [NSIS](https://nsis.sourceforge.io/Main_Page), atentando-se ao fato de que os arquivos baixados devem estar nomeados de acordo com o código, ou o código pode ser adaptado de acordo com o nome dos arquivos.

Existe também uma estrutura do diretório do instalador, que deve conter as seguintes pastas:

* **x64:** contém os arquivos para máquinas de arquitetura 64-bits 

* **x86:** contém os arquivos para máquinas de arquitetura 32-bits, desde que possuam uma contraparte em 64-bits

* **common:** contém os arquivos 32-bits que não possuem uma contraparte de 64-bits, ou os instaladores que são utilizados para ambas as arquiteturas.
