#
###
git init 
git add .
git commit -m "First commit"
git remote add origin https://github.com/fabiop35/myproject.git
git remote set-url origin git@github.com:fabiop35/myproject.git
git push -u origin master

> eval "$(ssh-agent -s)"
> ssh-keygen -t rsa -b 4096 -c "fabiop35@gmail.com"
> ssh-add ~/.ssh/id_rsa
> cat ~/.ssh//id_rsa.pub #create new ssh-key in github.com
> ssh -T git@github.com

###

GIT_SSH=C:\IC\putty\PLINK.EXE

git ini
git config --global user.name "hectorfabio.parra"
git config --global user.name "hectorfabio.parra@.com"

git config --get remote.origin.url

git clone ssh://git@globaldevtools.va.com:7999/hectorfabio.parra/czic_paymentloans.git 
git clone ssh://git@globaldevtools.va.com:7999/bcon/kqco.git
git clone ssh://git@globaldevtools.va.com:7999/bcon/kqco.git

https://globaldevtools.va.com/bitbucket/users/hectorfabio.parra/repos/czic_paymentloans/browse
https://globaldevtools.va.com/bitbucket/scm/~hectorfabio.parra/czic_paymentloans.git

git clone ssh://git@globaldevtools.va.com:7999/bitbucket/scm/~hectorfabio.parra/czic_paymentloans.git
git@globaldevtools.va.com
git clone ssh://git@globaldevtools.va.com:7999/~hectorfabio.parra/czic_paymentloans.git
   https://globaldevtools.va.com/bitbucket/scm/~hectorfabio.parra/czic_paymentloans.git

git add .
git add generacionFacade.xml generacionSN.xml src transactions
git commit -a -m "initial commit"
git push

ssh://git@globaldevtools.va.com:7999/vacals/czic_paymentloans.git

###B
git branch -a

###B

##############EKIP
https://globaldevtools.va.com/bitbucket/scm/ekip/ekip_ci.git

git config --global user.name "hectorfabio.parra"
git config --global user.email "hectorfabio.parra@va.com"

git clone ssh://git@globaldevtools.va.com:7999/ekip/ekip_ci.git
git init
git add --all
git commit -m "Ekip CI - Initial Commit"
git remote add origin ssh://git@globaldevtools.va.com:7999/ekip/ekip_ci.git
git push -u origin master

--
git fetch
git pull

git fetch --all
git reset --hard origin/master


git commit -m "Ekip CI - Reporteria, Nivelación" ./PersistenciaBatch/src/main/java/com/va/ekip/arq/jpa/batch/apo/impl/ConsultaContratoImpl.java ./EKIPMediadorControlM/src/main/java/com/va/ekip/arq/batch/logica/impl/OpCambioDiaFacturacionImpl.java ./PersistenciaBatch/src/main/java/com/va/ekip/arq/jpa/batch/apo/impl/DatosCambioDiaFacturacionImpl.java

#remove
cd APIInyeccionDoc
git rm -r target/
git commit -m "remove target"
git push origin master


git add EKIPBackCI-POM/OperacionesBack/src/main/java/com/va/ekip/arq/oper/back/impl/OpResetPasswordImpl.java
git commit -a -m "remove logs"
git push


---
#Branch - branch early, and branch often
#branch essentially says "I want to include the work of this commit and all parent commits".
git branch <name>
git commit
git checkout <name> #branch
git commit
git checkout newImage; git commit #Our changes were recorded on the new branch
git checkout -b [yourbranchname] #if you want to create a new branch AND check it out at the same time
#quiz branch
git branch bugFix
git checkout bugFix

#Branches and Merging
git merge #creates a special commit that has two unique parents
git merge bugFix
git checkout bugFix; git merge master
*Quiz
git branch bugFix
git checkout bugFix
git commit
git checkout master
git commit
git merge bugFix

#Git Rebase (combine)
git rebase master
git rebase bugFix
*Q
git branch bugFix
git checkout bugFix
git commit
git checkout master
git commit
git checkout bugFix
git rebase master

#Moving around in Git
HEAD #is the symbolic name for the currently checked out commit -- it's essentially what commit you're working on top of
     #HEAD always points to the most recent commit which is reflected in the working tree.
git checkout c1
git checkout master
git commit
git checkout c1

#Detaching HEAD: means attaching it to a commit instead of a branch.
git checkout c1

---Remote	 
#clone: to create local copies of remote repositories (from github for example).
git clone
<remote name>/<branch name> #o/master, the branch name is master and the name of the remote is o.
git checkout o/master; git commit
*Q
git checkout master
git commit
git checkout o/master
git commit

#Git Fetchin
 #downloads the commits that the remote has but are missing from our local repository
 #updates where our remote branches point (for instance, o/master)
 #essentially brings our local representation of the remote repository into synchronization with what the actual remote repository looks like (right now).
git fetch

#Git Pullin
  #fetching remote changes and then merging them is so common that git actually provides a command that does both at once! That command is git pull.
git fetch
git merge o/master
git pull

#Faking Teamwork
git fakeTeamwork foo 3

####################
###### BONITA ######
####################
 *** https://gist.github.com/domingogallardo/5bd3c185f3162d7a0c49
     https://stackoverflow.com/questions/15637507/fatal-origin-does-not-appear-to-be-a-git-repository
	 https://es.stackoverflow.com/questions/245/cu%C3%A1l-es-la-diferencia-entre-pull-y-fetch-en-git
	 https://www.atlassian.com/git/tutorials/syncing/git-fetch
	 
cd /C/Users/C341403/Documents/Repo_BitbuckerBonita
git config --global user.name "hectorfabio.parra"
git config --global user.email "hectorfabio.parra@va.com"
git init
git clone ssh://git@globaldevtools.va.com:7999/vacb/servicios.git
git add servicios/report-svc/src/main/resources/config/config.properties servicios/report-svc/src/main/resources/config/springconfig-data.xml
git commit -a -m "Se actualizan ficheros con la configuración para producción"
git remote add origin ssh://git@globaldevtools.va.com:7999/vacb/servicios.git
git remote -v
 origin  ssh://git@globaldevtools.va.com:7999/vacb/servicios.git (fetch)
 origin  ssh://git@globaldevtools.va.com:7999/vacb/servicios.git (push)
git branch
* master
git push origin master
git fetch origin
git merge origin/master


git remote add va ssh://git@globaldevtools.va.com:7999/vacb/servicios.git
git push --set-upstream va ## ERr:  ! [rejected]        master -> master (fetch first)

git branch
 * master
git branch -r 

git init

---
* [new branch]      feature/service-performance -> origin/feature/service-performance

git checkout develop
git merge feature/service-performance #merge: feature/service-performance - not something we can merge
Create pull request


approve a pull request

https://gist.github.com/domingogallardo/5bd3c185f3162d7a0c49
https://stackoverflow.com/questions/15637507/fatal-origin-does-not-appear-to-be-a-git-repository
https://es.stackoverflow.com/questions/245/cu%C3%A1l-es-la-diferencia-entre-pull-y-fetch-en-git

---
git remote -v
va    ssh://git@globaldevtools.va.com:7999/vacb/servicios.git (fetch)
va    ssh://git@globaldevtools.va.com:7999/vacb/servicios.git (push)
git remote add origin ssh://git@globaldevtools.va.com:7999/vacb/servicios.git
va    ssh://git@globaldevtools.va.com:7999/vacb/servicios.git (fetch)
va    ssh://git@globaldevtools.va.com:7999/vacb/servicios.git (push)
origin  ssh://git@globaldevtools.va.com:7999/vacb/servicios.git (fetch)
origin  ssh://git@globaldevtools.va.com:7999/vacb/servicios.git (push)
git fetch origin
 * [new branch]      develop             -> origin/develop
 * [new branch]      feature/Deploy_Test -> origin/feature/Deploy_Test
 * [new branch]      feature/NetApp      -> origin/feature/NetApp
 * [new branch]      feature/fixUnitTest -> origin/feature/fixUnitTest
 * [new branch]      feature/service-performance -> origin/feature/service-performance
 * [new branch]      feature/version-inicial-asignador -> origin/feature/version-inicial-asignador
 * [new branch]      master              -> origin/master

git pull origin master


###BONITA PROXY
1. Crear Repositorio (Edison)
2. git config --global user.name "hectorfabio.parra"
3. git config --global user.email "hectorfabio.parra@va.com"
4. git clone ssh://git@globaldevtools.va.com:7999/vacb/bonita-services-proxy.git
5. cd existing-project
6. git init
7. git add --all
8. git commit -m "Initial Commit"
9. git remote add origin ssh://git@globaldevtools.va.com:7999/vacb/bonita-services-proxy.git
10. git push -u origin master
11. crear rama develop

#Bonita Jasper
ssh://git@globaldevtools.va.com:7999/vacb/jaspetl-reports.git

git clone -b master ssh://git@globaldevtools.va.com:7999/vacb/jaspetl-reports.git
git describe --all
git add ...

git add Java/jasperetl_reports/pom.xml Java/jasperetl_reports/src/main/java/com/va/jasperetl/scheduled/DeleteFileJob.java Java/jasperetl_reports/src/main/java/com/va/util/DeleteFile.java Java/jasperetl_reports/src/main/java/com/trycore/jasperetl/controller/ReportController.java Java/jasperetl_reports/src/main/resources/application.properties Java/jasperetl_reports/src/main/resources/timeable.properties

git commit -a -m "Se actualizan ficheros con la configuración para producción"
git push


#Bonita casesClener
cd /c/Users/C341403/Documents/Repo_BitbuckerBonita/
git clone ssh://git@globaldevtools.va.com:7999/vacb/casescleanerbonita.git
cd casescleanerbonita
git init
git add --all
git commit -m "Initial Commit"
git remote add origin ssh://git@globaldevtools.va.com:7999/vacb/casescleanerbonita.git #Err
git push -u origin master

git branch develop
git checkout develop
git clone ssh://git@globaldevtools.va.com:7999/vacb/casescleanerbonita.git
git add --all
git push --set-upstream origin develop

#Bonita report-svc
git config --global user.name "hectorfabio.parra"
git config --global user.email "hectorfabio.parra@va.com"
cd D:\Documents\Bonita\Repo
git clone ssh://git@globaldevtools.va.com:7999/vacb/report-svc.git
cd report-svc
git init


git add --all
git commit -m "Add ProcessId"
git push

git remote add origin ssh://git@globaldevtools.va.com:7999/vacb/report-svc.git #Err

git push -u origin master

git branch develop
git checkout develop
git add --all
git push --set-upstream origin develop

#################
###GIT HUB ######
#################
echo "# UtilsB7: Utilities to B7" >> README.md
git init
git add README.md
git commit -m "first commit NBProject"
git remote add origin https://github.com/fabiop35/UtilsB7.git
git push -u origin master


echo "# angular-reddit: fist version with MVC" >> README.md
git init
git add README.md
git commit -m "first commit with MVC page 89 (60)"
git branch -M master
git remote add origin https://github.com/fabiop35/angular-reddit.git
git push -u origin master

#Add changes
git add README.md
git commit -m "first commit with MVC page 89 (60)"
git push -u origin master

#################
###GIT HUB ######
#################


---
###Configure Git for the first time
git config --global user.name "hectorfabio.parra"
git config --global user.email "hectorfabio.parra@va.com"
git clone ssh://git@globaldevtools.va.com:7999/vacb/avaluos-report-svc.git

#My code is ready to be pushed
cd existing-project
git init
git add --all
git commit -m "Initial Commit"
git remote add origin ssh://git@globaldevtools.va.com:7999/vacb/avaluos-report-svc.git
git push -u origin master

#My code is already tracked by Git
cd existing-project
git remote set-url origin ssh://git@globaldevtools.va.com:7999/vacb/avaluos-report-svc.git
git push -u origin --all
git push origin --tags


 [master f2ad032] Version: Oct-2019
 7 files changed, 456 insertions(+), 207 deletions(-)
 rewrite Java/jasperetl_reports/pom.xml (97%)
 create mode 100644 Java/jasperetl_reports/src/main/java/com/va/jasperetl/scheduled/DeleteFileJob.java
 create mode 100644 Java/jasperetl_reports/src/main/java/com/va/util/DeleteFile.java
 rewrite Java/jasperetl_reports/src/main/java/com/trycore/jasperetl/controller/ReportController.java (63%)
 rewrite Java/jasperetl_reports/src/main/resources/application.properties (72%)
 rewrite Java/jasperetl_reports/src/main/resources/timeable.properties (96%)


[master c7a4632] Optimización servicios por migración a VMW
 7 files changed, 808 insertions(+), 761 deletions(-)
 rewrite pom.xml (95%)
 rewrite src/main/java/com/trycore/va/dbaccess/dao/BusinessDataDao.java (79%)
 rewrite src/main/java/com/trycore/va/dbaccess/rest/MERDataController.java (62%)
 rewrite src/main/java/com/trycore/va/dbaccess/service/BusinessDataService.java (91%)
 rewrite src/main/resources/config/springconfig-data.xml (84%)
 create mode 100644 src/main/resources/ehcache.xml

#Undo last commit
git reset --soft HEAD~1

-Git Hub
git add --all
git commit -m "update Blob"
git remote add origin https://github.com/fabiop35/UtilsB7.git
git push -u origin master




---
git config --global user.name "hectorfabio.parra"
git config --global user.email "hectorfabio.parra@va.com"
echo "Cancels the process instance and all of its active flow nodes." >> README.md
git init
git add README.md
git commit -m "first commit"

curl -u 'hectorfabio.parra' ssh://git@globaldevtools.va.com:7999/vacb -d '{"name":"CancelProcessInstancesBonita","description":"Cancels the process instance and all of its active flow nodes."}'
git remote add origin git@github.com:nyeates/projectname.git


curl -u 'hectorfabio.parra' ssh://git@globaldevtools.va.com:7999/vacb -d '{"name":"CancelProcessInstancesBonita"}'
git remote add origin git@github.com:USER/REPO.git
git remote add origin ssh://git@globaldevtools.va.com:7999/vacb/CancelProcessInstancesBonita.git

git push -u origin master



git remote remove origin



















 


