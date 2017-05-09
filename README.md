## Blue Green Deployment support scripts

### Function

Read Fowler about Blue Green Deployment
https://martinfowler.com/bliki/BlueGreenDeployment.html

### WorkFlow

#### 1. Initialize structure

By default folder structure of all BGD complex is like that:

    |- /opt/
    |  |- blue-gree-deployment/          <- current project folder
    |  |- projects/                      <- projects folder (docker-compose instances for projects)
    |  |  |- project-name/               <- current project folder
    |  |  |  |- logs/                    <- logs folder
    |  |  |  |- {test,stage,production}/ <- stage folder
    |  |  |  |  |- {green,blue}/         <- instance folder. Here docker-compose folder is cloned
    |
    |- /etc/nginx/
    |  |- site-available/
    |  |  |- project-name/                <- current project folder
    |  |  |  |- {test,stage,production}/  <- stage folder
    |  |  |  |  |- {green,blue}           <- proxy configs
    |  |- site-enabled/
    |  |  |- project-name/                <- current project folder
    |  |  |  |- {test,stage,production}/  <- stage folder
    |  |  |  |  |- {green,blue}           <- symlink to config file (blue or green) in available folder

Running `init.sh` script will deploy this structure. Options to pass to `init.sh`:
* `-p projectName` - name for project folders in BGD structure
* `-h baseHostName` - base host name for project that will work like *.example.com, where * will be project stage
* `-r git@path-to-docker-compose-repo.git` - git path to docker-compose project. It will be cloned into every instance 
folder

After initialization your should configure every instance of docker-compose for all stages for the project.

Init script will create two files for your server:
* `.env` - main paths to BGD and projects
* `.used-ports` - here will be stored used by BGD ports for nginx proxy

If you want to customize variables in this files, you can make them from examples.

#### 2. Instance switching

    /opt/blue-gree-deployment/swith.sh -p projectName -i stage

#### 3. Database migrations

    /opt/blue-gree-deployment/migrate.sh -p projectName -i stage

#### 4. Fallback without update

    /opt/blue-gree-deployment/fallback.sh -p projectName -i stage