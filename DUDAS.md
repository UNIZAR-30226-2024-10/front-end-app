# Pequeña wiki en la que poner dudas o resolver alguna duda que tengamos #
# ---------------------------------------------------------------------- #

* Diferencia entre clases con estado y sin estado, y en que casos aplicar unos u otros?¿
    Básicamente si tu clase tiene elementos o widgets que a lo largo del tiempo van a cambiar, debes tener una clase con estado, si la
    clase es plana o simplemente de visualización, da igual.
* Identificar que clases necesitarán estado y que clases no.
    Clase Casilla de Ajedrez debe guardar estado ya que dinámicamente va a cambiar su contendio a lo largo del tiempo.


# Como lanzar el servidor back end, y como configurar PostMan para poder visualizar peticiones #
    * Para lanzar el servidor backend:
        npm run devStart
        Lo lanzará en localhost en el puerto especificado en la configuración

    * Descargar PostMan
        Body: JSON y raw al configurar el entorno

