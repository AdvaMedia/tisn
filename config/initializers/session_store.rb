# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_a2m_cms_session',
  :secret      => '1ff9c45731824fe9da33ed4e83f7e578616b94c505e2783c1e0e90a4b17f85afed64c66cfbecd289cf61daffec718ea2b48c4df85d9e7df3f3cae53599e4b786'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
