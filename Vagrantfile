# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.hostname = 'irox-nlp'
	config.vm.box = "ubuntu/trusty64"

	config.vm.provider "virtualbox" do |vb|
		vb.memory = "2048"
	end

	config.vm.provision "shell", inline: <<-SHELL
		apt-get update

		apt-get install -y build-essential
		apt-get install -y curl
		apt-get install -y git

		# --- Python
		apt-get install -y python-dev
		apt-get install -y python-pip

		pip install git+https://github.com/mit-nlp/MITIE.git

		if [ ! -d /opt/MITIE-models ]; then
			curl -sL https://github.com/mit-nlp/MITIE/releases/download/v0.4/MITIE-models-v0.2.tar.bz2 | tar jxv -C /opt/
		fi

		# --- Perl
		curl -sL http://cpanmin.us | perl - App::cpanminus

		cpanm Module::Build
		cpanm git://github.com/marghidanu/irox-data.git

		echo "installdeps --cpan_client='cpanm --mirror http://cpan.org'" | tee "${HOME}/.modulebuildrc"
	SHELL
end
