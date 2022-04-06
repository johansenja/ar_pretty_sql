# frozen_string_literal: true

require "ostruct"
require "rouge"
require "anbt-sql-formatter/formatter"

require_relative "ar_pretty_sql/version"

module ArPrettySql
  Config = OpenStruct.new(
    # the colour theme to use for highlighting the SQL output (provided `color` is true)
    theme: Rouge::Themes::Colorful.new,
    # enable syntax highlighting for the output (also accepts `colour`)
    color: true,
    # prettify the SQL output
    format: true,
    # extra SQL functions you want to provide highlighting for
    additional_sql_functions: %w[count sum substr date],
    # keyword case (:upper, :lower, :unchanged)
    keyword_case: :upper,
  )

  def self.configure
    yield Config
  end

  module InstanceMethods
    def to_pretty_sql(**options)
      conf = ArPrettySql::Config.to_h.merge! options

      result = to_sql.dup

      if conf[:format]
        rule = AnbtSql::Rule.new

        rule.keyword = case conf[:keyword_case].to_sym
                       when :upper then AnbtSql::Rule::KEYWORD_UPPER_CASE
                       when :lower then AnbtSql::Rule::KEYWORD_LOWER_CASE
                       when :unchanged then AnbtSql::Rule::KEYWORD_NONE
                       end

        conf[:additional_sql_functions]&.each do |func_name|
          rule.function_names << func_name.upcase
        end

        formatter = AnbtSql::Formatter.new(rule)
        result = formatter.format(result)
      end

      if conf[:color] || conf[:colour]
        lexer = Rouge::Lexers::SQL.new
        formatter = Rouge::Formatters::Terminal256.new(conf[:theme])
        result = formatter.format(lexer.lex(result))
      end

      result
    end

    def pp(**options)
      puts to_pretty_sql(**options)
    end
  end
end

if Object.const_defined? "ActiveRecord::Relation"
  ActiveRecord::Relation.prepend(ArPrettySql::InstanceMethods)
end
