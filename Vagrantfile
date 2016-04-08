# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$num_minion = 2

# ip configuration
$minion_ip_base = "192.168.3."
$minion_ips = $num_minion.times.collect { |n| $minion_ip_base + "#{n+2}" }
$minion_ips_str = $minion_ips.join(",")

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "moszeed/boot2docker"
 
  config.vm.define "master" do |master|
        master.vm.network "private_network", ip: "192.168.3.1"
	master.vm.provision "shell", inline: "/vagrant/provision/provision.sh 192.168.3.1 master"
  end

  $num_minion.times do |i|
      config.vm.define "minion-#{i+1}" do |minion|
	  minion_name = "minion#{i+1}"
	  minion_ip = $minion_ips[i]
          minion.vm.provision "shell", inline: "/vagrant/provision/provision.sh #{minion_ip} #{minion_name}"
          minion.vm.network "private_network", ip: "#{minion_ip}"
      end
  end
end

# Start swarm manager
#if ARGV[0] == "up"
#    puts "Starting swarm manager."
#    system("docker run -t -p 2379:2375 -t swarm manage token://8a70b087fa3d3430471dd1672070dec4 &")
#end
