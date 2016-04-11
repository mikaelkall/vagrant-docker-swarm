# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$num_minion = 2

$minion_ip_base = "192.168.3."
$minion_ips = $num_minion.times.collect { |n| $minion_ip_base + "#{n+2}" }
$minion_ips_str = $minion_ips.join(",")

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "moszeed/boot2docker"
  
  $num_minion.times do |i|
      config.vm.define "minion-#{i+1}" do |minion|
	  minion_name = "minion#{i+1}"
	  minion_ip = $minion_ips[i]

          minion.vm.provision "shell", inline: "/vagrant/provision/provision-minion.sh #{minion_ip} #{minion_name}"
          minion.vm.network "private_network", ip: "#{minion_ip}"
      end
  end

  config.vm.define "master" do |master|
	addr = $minion_ips.join(",")
        master.vm.network "private_network", ip: "192.168.3.1"
        master.vm.provision "shell", inline: "/vagrant/provision/provision-master.sh #{addr}"
  end

end
