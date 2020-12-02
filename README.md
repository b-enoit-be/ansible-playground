    
Given that you have a playbook in your current directory named `play.yml`, then the easiest way to run it with Ansible would be:

```
docker run --rm -ti -v $PWD:/usr/local/ansible benoitbe/ansible-playground
```

Other usefull commands

* Run it with a custom playbook name

```
docker run --rm -ti -v $PWD:/usr/local/ansible benoitbe/ansible-playground custom.yml
```

* Run it with your own inventory

```
docker run --rm -ti -v $PWD:/usr/local/ansible benoitbe/ansible-playground --inventory inventory.yml play.yml
```

* In order to jump into the container

```
docker run --rm -ti --entrypoint ash benoitbe/ansible-playground
```

* In order to jump into the container, with your files mounted

```
docker run --rm -ti -v $PWD:/usr/local/ansible --entrypoint ash benoitbe/ansible-playground
```

* In order to run an ad-hoc command

```
docker run --rm -ti --entrypoint ansible benoitbe/ansible-playground --inventory inventory.yml all -a 'echo "Hello world!"'
```

* To rebuild it:
``` 
docker build . --tag benoitbe/ansible-playground
```