# encoding: utf-8
namespace :app do
  desc "Encripta todas as senhas \
        que ainda não foram processadas \
        no banco de dados"
  task migrar_senhas: :environment do
    unless User.attribute_names.include? "password"
      puts "As senhas já foram migradas, terminando."
      next
    end

    User.find_each do |user|
      puts "Migrando usuario ##{user.id} #{user.full_name}"
      if !user.valid? || user.attributes["password"].blank?
        puts "Usuario id #{user.id} invalido, pulando."
        puts "Corrija-o manualmente e tente novamente. \n\n"
        next
      end

      unencripted_password = user.attributes["password"]

      user.password = unencripted_password
      user.password_confirmation = unencripted_password
      user.save!
    end
  end
end
