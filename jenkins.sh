---
- hosts: node
  become: yes
  remote_user: ubuntu
  become_user: root
  become_method: sudo
  tasks:
  - name: 'apt get update'
    apt:
      update_cache: true
      cache_valid_time: 3600
      force_apt_get: true
  - name: 'apt get upgrade'
    apt:
      upgrade: yes
      cache_valid_time: 3600
  - name: 'Software Properties Common'
    become: true
    apt:
      name: software-properties-common
      state: present
  - name: 'Add Jenkins Key'
    apt_key:
      url: https://pkg.jenkins.io/debian-stable/jenkins.io.key
      state: present
  - name: 'Add Jenkins Repository'
    apt_repository:
      repo: deb https://pkg.jenkins.io/debian-stable/jenkins.io.key
      update_cache: yes
  - name: "Install Jenkins"
    apt:
      name: jenkins
      state: present