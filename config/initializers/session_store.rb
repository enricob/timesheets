# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_timesheets_session',
  :secret      => 'fbf078186420ca0d96b64c1b9e644f9d4997f365307a9a0d9d9be7604d8d4f777a06d6d238aeb4cf5526f022a81401533a202d57cd5203322fb4df56048c61e9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
