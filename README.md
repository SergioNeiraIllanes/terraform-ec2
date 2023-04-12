# Terraform EC2 and modules

En este proyecto se utiliza terraform para una infraestructura en AWS. Junto con eso se hace uso de Terraform Cloud para el despliegue seguro de los recursos y evitar que sea de forma local. Además, se agregan los metaargumentos para evitar repetir código al crear más de un servidor EC2. 

Para la correcta ejecución debe descargar el proyecto y en el directorio raíz debe ejecutar `terraform init`. Se debe considerar que las variables `workspace` y `organization` deben cambiar de valor. Deben ser valores de su cuenta Terraform Cloud. Recuerde que, también, debe logearse con `terraform login`. Luego de ejecutar estos pasos, podrá desplegar la infraestructura sin problemas.
