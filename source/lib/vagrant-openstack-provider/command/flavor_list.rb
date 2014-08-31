require 'vagrant-openstack-provider/command/utils'
require 'vagrant-openstack-provider/command/abstract_command'

module VagrantPlugins
  module Openstack
    module Command
      class FlavorList < AbstractCommand
        include VagrantPlugins::Openstack::Command::Utils

        def self.synopsis
          I18n.t('vagrant_openstack.command.flavor_list_synopsis')
        end
        def cmd(name, argv, env)
          fail Errors::NoArgRequiredForCommand, cmd: name unless argv.size == 1
          flavors = env[:openstack_client].nova.get_all_flavors(env)

          rows = []
          flavors.each do |f|
            rows << [f.id, f.name, f.vcpus, f.ram, f.disk]
          end
          display_table(env, ['Id', 'Name', 'vCPU', 'RAM (Mo)', 'Disk size (Go)'], rows)
        end
      end
    end
  end
end
