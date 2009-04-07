class UsersDataset < Dataset::Base
  def load
    create_user :login => "ben", :password => "benrocks"
    create_user :login => "zack", :password => "zackrocks"
  end

  helpers do
    def create_user(attributes={})
      salt = Authlogic::Random.hex_token
      create_record :user, attributes[:login].to_sym,
        :login => attributes[:login],
        :password_salt => Authlogic::Random.hex_token,
        :crypted_password => Authlogic::CryptoProviders::Sha512.encrypt(attributes[:password] + salt),
        :persistence_token => Authlogic::Random.hex_token
    end
  end
end