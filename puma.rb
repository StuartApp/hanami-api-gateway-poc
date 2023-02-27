# frozen_string_literal: true

workers 4
threads_count = 10
threads threads_count, threads_count

port ENV['PORT'] || 3000
