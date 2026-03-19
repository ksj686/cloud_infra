# Introduction to Ansible

## What is Ansible?
Ansible is an open-source automation tool used for IT tasks such as configuration management, application deployment, and intra-service orchestration.

### Key Features
- **Agentless**: No need to install software on target servers (uses SSH).
- **Idempotent**: Runs the same task multiple times with the same result (won't re-apply changes if not needed).
- **YAML-based Playbooks**: Simple, human-readable instructions.

## Basic Components
1. **Control Node**: The machine where you run Ansible.
2. **Managed Nodes**: The servers you manage.
3. **Inventory**: A list of managed nodes.
4. **Playbooks**: Scripts that define the tasks to perform.
5. **Modules**: The "tools" Ansible uses to execute tasks (e.g., `apt`, `copy`, `service`).

## Common Commands
- **Ping all hosts in inventory**: `ansible all -m ping -i inventory.ini`
- **Run a playbook**: `ansible-playbook -i inventory.ini site.yml`
- **Ad-hoc command**: `ansible all -m apt -a "name=nginx state=present" -b`
