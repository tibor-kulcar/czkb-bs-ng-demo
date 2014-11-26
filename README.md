INSTALLATION
============

1. install nodejs and npm (http://nodejs.org/download/)
1. run `npm install`

Optional (for developers):
--------------------------

1. run `sudo npm install bower -g`
1. run `sudo npm install grunt-cli -g`


RUN
===
`npm start` to start local server on port 8000
See [local api server](http://localhost:8000/api) or [local FE](http://localhost:8000/) to see the frontend.

`npm run-script dev` to watch FE sources for changes and recompile if necessary


POPIS PROSTŘEDÍ
===============

node/npm - kromě backendu využit jako hlavní package manager pro správu
závislostí projektu

backend
-------

Slouží pouze jako interface k databázi a pro naservírování statických souborů.
Veškerá logika aplikace je řešena na straně frontendu.

- /app/index.html a static files (obrázky, css, ...)
- /api - jednoduché REST API pro účely vývoje



Technologie / nástroje

- [nodejs](http://nodejs.org)
    - server-side javascript
- [coffee-script](http://coffeescript.org/)
    - jazyk, který lze kompilovat do javascriptu

frontend
--------

Frontendem se zde myslí část projektu, která je spuštěna pouze v browseru na
klientském počítači.

Struktura souborů
- /app - hlavní adresář FE
- /app/templates - šablony použité v angularjs


Technologie / nástroje

- [Bower](http://bower.io) - package manager pro javascript / css / ... projekty (jako např. bootstrap,
  angularjs, jquery, ...) Umožňuje snadno vytvořit a spravovat knihovny na
  straně browseru.
- [Grunt](http://gruntjs.com) - task runner, pro automatizaci (a vlastně i dokumentaci) rutinních
  úkolů během vývoje (trochu obdoba `make`).
- [Less](http://lesscss.org) - CSS preprocessor rozšiřující standardní CSS jazyk např. o proměnné, dědičnost a pod.
- [CoffeeScript](http://coffeescript.org) - Viz backend
- [angularjs](http://angularjs.org) - A supersonic javaScript MVW Framework
