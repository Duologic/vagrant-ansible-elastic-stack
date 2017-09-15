# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
   config.vm.box = "centos/7"

   ansible_groups = {
       "logstash-master" => ["logstash"],
       "kibana-client" => ["kibana"],
       "filebeat-client" => ["filebeat", "kibana", "logstash"],
       "elasticsearch-masterdata" => ["elastic[0:1]"],
   }
   ansible_extra_vars = {
       "elastic_unicast" => "192.168.33.11:9300,192.168.33.12:9300",
       "filebeat_endpoint" => "192.168.33.8:5044",
   }


    # Logstash client
    config.vm.define "logstash" do |logstash|
        logstash.vm.network "private_network", ip: "192.168.33.8"
        logstash.vm.provision :ansible do |ansible|
            ansible.groups = ansible_groups
            ansible.limit = "all"
            ansible.playbook = "logstash.yml"
            ansible.extra_vars = ansible_extra_vars
        end
    end

    # Kibana client
    config.vm.define "kibana" do |kibana|
        kibana.vm.network "forwarded_port", guest: 9200, host: 9200, guest_ip: "192.168.33.9"
        kibana.vm.network "forwarded_port", guest: 5601, host: 5601
        kibana.vm.network "private_network", ip: "192.168.33.9"
        kibana.vm.provision :ansible do |ansible|
            ansible.groups = ansible_groups
            ansible.limit = "all"
            ansible.playbook = "kibana.yml"
            ansible.extra_vars = ansible_extra_vars
        end
    end

    # Elastic Search nodes
    (0..1).each do |machine_id|
        config.vm.define "elastic#{machine_id}" do |elastic|
            elastic.vm.network "private_network", ip: "192.168.33.1#{machine_id}"
            if machine_id == 1
                elastic.vm.provision :ansible do |ansible|
                    ansible.groups = ansible_groups
                    ansible.limit = "all"
                    ansible.playbook = "elasticsearch.yml"
                    ansible.extra_vars = ansible_extra_vars
                end
            end
        end
    end

    # Filebeat client
    config.vm.define "filebeat" do |filebeat|
        filebeat.vm.network "private_network", ip: "192.168.33.7"
        filebeat.vm.provision :ansible do |ansible|
            ansible.groups = ansible_groups
            ansible.limit = "all"
            ansible.playbook = "filebeat.yml"
            ansible.extra_vars = ansible_extra_vars
        end
    end

    config.vm.provision "shell", inline: <<-SHELL
        yum install -y epel-release
        yum install -y htop vim telnet curl
    SHELL
end
