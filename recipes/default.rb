#
# Cookbook Name:: gitosis
# Recipe:: default
#
# Copyright 2012, Jacques Marneweck.
#
# All rights reserved - Do Not Redistribute
#

%w{
  py27-gitosis
  scmgit-base
}.each do |p|
  package "#{p}" do
    action :install
  end
end

group "git" do
  gid node['gitosis']['gid']
end

user "git" do
  uid node['gitosis']['uid']
  gid node['gitosis']['gid']
  comment "Gitosis User"
  home "/home/git"
  shell "/bin/bash"
  supports :manage_home=>true
  action :create
  notifies :run, "execute[set-no-password-for-git-user]", :immediately
end

template "/tmp/id_rsa.pub" do
  source "id_rsa.pub.erb"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -d /home/git/repositories/gitosis-admin.git"
end

execute "set-no-password-for-git-user" do
  command "passwd -N git"
  action :nothing
end

execute "init-gitosis" do
  command "sudo -H -u git gitosis-init < /tmp/id_rsa.pub"
  not_if "test -d /home/git/repositories/gitosis-admin.git"
end

file "/tmp/id_rsa.pub" do
  action :delete
end
