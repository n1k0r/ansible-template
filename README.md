# Ansible project template

> This "project" template has nothing to do with Ansible Tower "Projects".

## Usage

1. Copy these files to your project repository.

2. Initialize hosts with `initial.sh` script:
```sh
# using pubkey auth
./initial.sh root@1.2.3.4 all

# or using password auth
./initial.sh root@1.2.3.4 all password
```

3. Add hosts to inventory and change example variables.

4. Add `local.yml` to project root for any user from [inventory/group_vars/all/users.yml](inventory/group_vars/all/users.yml):
```yml
local:
  user: username
  password: abcdefgh
```

5. Install Ansible Galaxy dependencies if there are any:
```sh
ansible-galaxy install -r requirements.yml
```

6. Finish initialization by executing `setup.yml` playbook:
```sh
ansible-playbook setup.yml
```
