# README #

Se ha decididoo realizar la aplicación bajo una arquitiactura clean+MVVM. De esta forma, hemos separado el código en tres capas: 
* Domain (lógica de negocio)
* Data (repositorio de datos)
* Presentation (Capa visual bajo MVVM)

Además se han utilizado diiferentes framworks para ayudarnos a llevar a cabo el proceso: 
* Alamofire (http requests)
* RxSwift (binding entre view controllers y view models)
* SDWebImage (gestión y descarga de imagenes)



### TO DO / IMPROVEMENTS ###

* Añadir Unit Tests
* Añadir UI Tests
* Añadir Snapshot testing
* Añadir swiftlint para mejorar el estilo de codigo
* Añadir sonarqube para revision de codigo


* Implementar un buscador de personajes
* Implementar posibilidad de ordenar la lista en funcion de diferentes factores
* Añadir información de comics, eventos, series e historias de los personajes
