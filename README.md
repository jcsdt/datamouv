# Datamouv

`docker-compose up` will start all the containers for the project:

* A scrapper container, it will retrieve the data.gouv.fr pages and download the resources
* A server container, accessible at [http://localhost:4000](http://localhost:4000), to serve the API endpoints
* A Postgres database, shared between the scrapper and the server
* A nginx server which serves the web client at [http://localhost:80](http://localhost:80)
