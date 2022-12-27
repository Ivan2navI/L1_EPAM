deploy_apache
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

```yaml
nano roles/deploy_apache/vars/main.yml

---
# vars file for deploy_apache
source_dir: ./roles/deploy_apache/files
destin_dir: /var/www/html
```

``` console
ansible$ tree roles
roles
└── deploy_apache
    ├── README.md
    ├── defaults
    │   └── main.yml
    ├── files
    │   ├── Ansible_Roles.png
    │   └── index.html
    ├── handlers
    │   └── main.yml
    ├── meta
    │   └── main.yml
    ├── tasks
    │   └── main.yml
    ├── templates
    ├── tests
    │   ├── inventory
    │   └── test.yml
    └── vars
        └── main.yml

```


Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------
Create `playbook7.yml` and run it to check results:
```yml
nano playbook7.yml

ansible-playbook playbook7.yml

# !!! Ansible Roles.yml !!!
---
- name: Ansible Roles
  hosts: all
  become: yes               # `-b` or `-become` flag to run the module with `sudo` privilege in the managed nodes.

  roles:
    - role: deploy_apache
```

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).

```yml
# !!! Ansible Roles.yml !!!
---
- name: LOOP Playbook. Install Apache Web Server on AMI Linux. Upload web page example 
  hosts: all
  become: yes               # `-b` or `-become` flag to run the module with `sudo` privilege in the managed nodes.

  vars:
    source_dir: ./Loop_Site
    destin_dir: /var/www/html

  tasks:
  - name:  Check Linux distro
    debug: var=ansible_os_family

  - block: # For "RedHat"

    - name: Install Apache Web Server on AWS Linux / RedHat
      yum:  name=httpd state=latest

    - name: Start Apache and enable it during boot
      service: name=httpd state=started enabled=yes

    when: ansible_os_family == "RedHat"

  - block: # For "Debian"

    - name: Install Apache Web Server on Ubuntu / Debian
      apt:  update_cache=yes name=apache2 state=latest

    - name: Start Apache and enable it during boot
      service: name=apache2 state=started enabled=yes

    when: ansible_os_family == "Debian"


  - name: Copy index.html to target server Ubuntu / Debian
    copy: src={{ source_dir }}/{{ item }} dest={{ destin_dir }} mode=0555
    loop:
      - "index.html"
      - "Ansible_Roles.png"
    notify:
        - Restart Apache Debian
        - Restart Apache RedHat

  - name: Add OS info
    shell: |
      OS_VERSION=$(cat /etc/os-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//' | sed 's/\"//g')
      echo "<h3 style="color:Orange" align="center">$OS_VERSION</h3>" >> index.html
      
      IP_ADR=$(hostname -I)
      echo "<h4 style="color:Orange" align="center">$IP_ADR</h4>" >> index.html
    args:
      chdir: "/var/www/html/"

  handlers:
  - name: Restart Apache RedHat
    service: name=httpd state=restarted
    when: ansible_os_family == "RedHat"

  - name: Restart Apache Debian
    service: name=apache2 state=restarted
    when: ansible_os_family == "Debian"
```
