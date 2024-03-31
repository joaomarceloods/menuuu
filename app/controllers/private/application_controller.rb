class Private::ApplicationController < ApplicationController
  include AuthenticateUser
  # include RequireBusiness
end
