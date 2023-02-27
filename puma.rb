# frozen_string_literal: true

workers 4
threads 4, 16
preload_app!
port ENV.fetch('PORT', 3000)
