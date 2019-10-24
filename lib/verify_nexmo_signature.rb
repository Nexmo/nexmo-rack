# frozen_string_literal: true

require 'digest/md5'
require 'jwt'
require 'nexmo'
require 'rack'
require_relative './verify_nexmo_signature/middleware'
