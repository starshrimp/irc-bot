require "minitest/autorun"
require_relative 'irc_bot'
require_relative 'irc_bot_classes'
require_relative 'irc_bot_methods'


class BotTest < Minitest::Test
  def self.test_order
    :sorted
  end

  # This special setup method is automatically run by Minitest before every
  # test that is executed. This helps with setting up your test environment
  # and reduces code duplication.
  def setup
  end
  def test_back_to_start
    if message.include?("start")
      assert(@tree_level == 0)
      assert(@chosen_problem == :none)
      assert(@repetition_lameness == 0)
    end
  end
end
