require 'machinist/active_record' # or your chosen adaptor
require File.dirname(__FILE__) + '/../support/blueprints' # or wherever your blueprints are
Before { Sham.reset } # to reset Sham'