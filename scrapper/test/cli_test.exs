defmodule CliTest do
  use ExUnit.Case
  doctest Scrapper

  import Scrapper.CLI, only: [parse_argv: 1]

  test ":help returned with -h or --help" do
    assert parse_argv(["-h", "something"]) == :help
    assert parse_argv(["--help", "something"]) == :help
  end

  test ":help returned on faulty inputs" do
    assert parse_argv(["something"]) == :help
    assert parse_argv(["3000", "./data"]) == :help
    assert parse_argv(["aaa", "bbb", "ccc"]) == :help
  end

  test ":help returned on number of pages <= 0" do
    assert parse_argv(["3000", "-2", "./data"]) == :help
  end

  test ":help returned on start pages <= 0" do
    assert parse_argv(["-1", "2", "./data"]) == :help
  end

  test "arguments are returned when in right format" do
    assert parse_argv(["2", "12", "./data"]) == [2, 12, "./data"]
  end

  test "default arguments are returned when nothing" do
    assert parse_argv([]) == [3000, 5, "./data"]
  end
end
