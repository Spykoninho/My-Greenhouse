# My-Greenhouse
Mobile application which displays all the information about your greenhouse (temperature, humidity), and which sends you all other important information (weather, etc.). Works with a raspberry pi

## Summary
- [How To Install the Project](#how-to-install-the-project)
- [Languages and Technologies](#languages-and-technologies)
   - [Web application](#Web-application)
   - [Mobile application](#Mobile-application)
   - [Database](#database)
   - [Docker](#docker)
- [Run](#run)
- [License](#license)
- [Authors](#authors)

## How To Install the Project

Firstly, it all depends on whether you intend to use the various components via Docker containers.

See below for your preferred option. 

Before any install, you need to clone the project

```bash
git clone https://github.com/Spykoninho/My-Greenhouse.git
or via SSH
git clone git@github.com:Spykoninho/My-Greenhouse.git
```

### Docker Container

A docker-compose file is present at the root of the directory, containing 3 services: the api, the front end and the database. For the API, a Dockerfile is also present to provide the image for building the api.

To start containers you can run : 

```bash
docker compose up --build
```
The --build option is used to build the api service with its Dockerfile, you can remove it if you don't need it

Check that containers have been successfully booted

```bash
docker ps
```

The website should normally be accessible at `http://localhost:3000` and the api at `http://localhost:3001`
(Or the port you specified)

### On your machine (without docker)

First, you need to install the dependencies, then you can use the "start" script with npm at the root of the directory<br>
Of course, don't forget to replace the .env file in /api with the configuration information for your database.

```bash
npm install
Each part need dependencies
npm run install_libs
npm start
```

You can also manually launch the api and the front end separately by executing the following command in each folder `/api` and `/front`

```bash
npm start
```

#### Build the React Frontend App

In `/front`

```bash
npm run build
```

You will have a `build` folder which is the static site built by React. This static build therefore doesn't need to have the node server running.

The node server for the React application enables the development application to be launched, and it is this application that receives hot updates from React. (See https://webpack.js.org/guides/hot-module-replacement/)

## Languages and Technologies

### Web application
#### - Front-End
![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB)

#### - Back-End
![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white)
![Express.js](https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=%2361DAFB)

### Mobile application
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

### Database 
![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)

### Containerization
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

## Run
### Required 
- Docker installation with docker compose
### Commands for developping
** Run for the first time ** ```docker compose up```

## License

<img src="https://img.shields.io/github/license/Ileriayo/markdown-badges?style=for-the-badge">

This project is under MIT License with an additional clause to prevent commercial use.

See [the license](./.github/LICENSE)

## Authors

- <a href="https://github.com/Spykoninho">@SpyKo</a>

## For contributors
See [the contributors guide](./.github/CONTRIBUTING.md)

## Changelog
See [the changelog](./.github/CHANGELOG.md)
