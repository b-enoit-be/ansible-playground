
### Basic usage

Given that you have a playbook in your current directory named `play.yml`, then the easiest way to run it with Ansible would be:

```shell
make
```

### Other useful commands / options

* Run it with a custom playbook name

  ```shell
  make cmd="'ansible-playbook custom.yml'"
  ```

* Run it with managed nodes, e.g. three nodes

  ```shell
  make nodes=3
  ```

* Run it with your own inventory

  ```shell
  make cmd="'ansible-playbook custom.yml --inventory inventory.yml'"
  ```

* In order to jump into the container

  ```shell
  make attach
  ```

* To list all hosts in the inventory:
  ```shell
  make inventory
  ```

* To rebuild it:
  ```shell
  make rebuild
  ```

* To clean it:
  ```shell
  make clean
  ```

### TODO:
1. be able to have multiple container of a distribution (node-alpine-1, node-alpine-2, etc)
2. pass all nodes_* variables from make to the container
3. keep on investigating docker compose watch
4. add distributions (one that uses pacman, arch?, one that uses yum, one that uses dnf)