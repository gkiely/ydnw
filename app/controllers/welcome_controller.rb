class WelcomeController < ApplicationController
  def index
    logger.debug "-----------------"
    logger.debug "-----------------"
    logger.debug "-----------------"
    logger.debug "-----------------"
    logger.debug request.subdomain
    logger.debug "-----------------"
    logger.debug "-----------------"
    logger.debug "-----------------"
    logger.debug "-----------------"
  end
end
