# sistemafacturacion

Un nuevo proyecto de Flutter.

## Empezando

Este proyecto es un punto de partida para una aplicación Flutter.

## Descripción

El principal objetivo de nuestra aplicación radica en proporcionar un sistema de facturación integral, que abarque desde el control de inventario hasta la generación de facturas. Con un enfoque centrado en la eficiencia y la facilidad de uso, nuestra plataforma permite a los usuarios realizar diversas acciones clave, tales como búsqueda, agregado, modificación y eliminación de productos específicos dentro del inventario.
Una de las funcionalidades fundamentales que distingue a nuestro sistema de facturación es su capacidad para generar facturas detalladas de manera intuitiva y precisa. Esto implica el ingreso meticuloso de cada producto, especificando la cantidad deseada y, en caso necesario, aplicando descuentos correspondientes a promociones u otros incentivos. Cada transacción queda registrada en una tabla dinámica que refleja el total individual de cada producto, proporcionando así una visión clara y detallada de los artículos seleccionados. Al concluir el proceso de facturación, se genera un total final que suma el valor de todos los productos adquiridos, brindando una visión global del costo total de la compra.

## Especificaciones

La pantalla principal presenta una barra inferior que facilita la navegación hacia las ventanas de Facturas y de Productos, además de mostrar un título principal en la parte superior.
La ventana de Facturas ofrece campos para la visualización de cada producto a ingresar, junto con una tabla dinámica donde se irán agregando los productos seleccionados. Tres botones específicos permiten realizar acciones clave:
[Buscar]: Permite encontrar un artículo en la base de datos utilizando su código, y muestra todos los detalles relacionados.
[Añadir]: Permite agregar el producto buscado a la tabla si está disponible en el inventario.
[Facturar]: Facilita la simulación de la facturación y el ingreso de los datos a la base de datos.
Además, se incluye un campo de texto que refleja el total de la suma de todos los precios de los productos añadidos a la lista.
La ventana de Productos presenta una lista completa de todos los productos disponibles en el sistema, acompañada de un subtítulo que indica claramente su función.
Cada producto de la lista puede ser modificado o eliminado según sea necesario. Al hacer clic en cualquier producto, se abre una ventana emergente que permite modificar cada uno de sus atributos:
- Código
- Nombre
- Cantidad en Existencia
- Precio de Costo
- Precio de Venta
En la parte inferior de la ventana se encuentra un botón para añadir un nuevo producto, el cual redirecciona a una nueva ventana donde se pueden ingresar todos los datos necesarios.

## Instrucciones de uso
Ventana de Factura: Facturación de Productos
    1. [Añadir_Producto:]
    - Buscar Producto:
        Para agregar un producto, primero se debe buscarlo utilizando su código correspondiente. Esto se logra al especificar el código en el campo designado y presionar el botón ["Buscar"]. Si el producto existe, se cargarán automáticamente los demás valores en los campos correspondientes, excepto la cantidad a comprar y el posible descuento, los cuales deben ser ingresados manualmente. Si el producto no existe, se mostrará un mensaje informando que no se ha encontrado.
    - Agregar a la Factura:
        Una vez que se haya preparado el producto con todos los campos completos, se puede añadir a la tabla de facturas mediante el botón ["Añadir"]. Es importante destacar que se realiza una validación para asegurar que todos los campos necesarios estén llenos. En caso contrario, se mostrará un mensaje indicando que se deben llenar los campos faltantes.
    2. [Generar_Factura:]
    Para simular el ingreso de la factura, simplemente se debe presionar el botón ["Facturar"]. Esto desencadenará un mensaje de confirmación que indica que la factura ha sido ingresada correctamente, además de limpiar los datos de la tabla para iniciar una nueva factura.

Ventana de Productos: Inventario de Productos
    [Mostrar_Productos:]
    Al presionar el botón ["Productos"] en la barra inferior, se abrirá una nueva ventana que muestra automáticamente todos los productos almacenados en la base de datos.
    [Añadir_Nuevo_Producto:]
    Para agregar un nuevo producto, se utiliza el botón ubicado en la parte inferior de la ventana. Al hacer clic en él, se abrirá una nueva ventana que contiene los campos necesarios para ingresar los datos de un nuevo producto. Estos campos deben completarse manualmente y luego se guarda la información mediante el botón ["Guardar"].
    [Modificar_Producto:]
    Para modificar un producto existente, simplemente se selecciona el artículo deseado, lo que abrirá una ventana con los mismos campos que el ingreso de productos, pero prellenados con los datos del producto seleccionado. Aquí, se puede modificar solo el valor deseado y luego se actualizan los datos mediante el botón ["Actualizar"].
    [EliminarProducto:]
    La eliminación de un producto se realiza deslizando el dedo hacia la izquierda sobre el producto deseado. Esto desplegará un mensaje de confirmación que solicita confirmar la eliminación del artículo. Se proporcionan opciones para cancelar o confirmar la eliminación del producto.



Algunos recursos para ayudar en el uso y entendimiento de la aplicación:

- [Informe de documentación de la aplicación](https://docs.google.com/document/d/14wecojoD51Si1Zt7XBFaBpMP5TRfL7WeJh-nYisEjRs/edit?usp=sharing)
- [Aplicación app-debug.apk para probar en dispositivos android](https://drive.google.com/file/d/1RVx7l7PVKGZZwq3VNALKEMgr5vqbyXJF/view?usp=drive_link)
- [Video de la utilizacion y funcionamiento de la aplicación](https://youtu.be/Lgr4N10MzQI)