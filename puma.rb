# frozen_string_literal: true

workers 2
threads_count = 5
threads threads_count, threads_count

port ENV['PORT'] || 3000
