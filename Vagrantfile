Vagrant.configure("2") do |config|
 	config.vm.box = "ubuntu-14"
        config.vm.define "node" do |node|
        node.vm.network "private_network", ip: "192.168.2.6"
        node.vm.hostname = "node.in"
        node.vm.provider "virtualbox" do |vb|
#        vb.gui = true
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "100",
          "--memory", "1024",
	]
	end
#	node.vm.provision "shell", path: "./ansible_install.sh"
        end
end
