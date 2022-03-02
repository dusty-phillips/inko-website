# frozen_string_literal: true

module Rouge
  module Lexers
    class Inko < RegexLexer
      title 'Inko'
      desc 'The Inko programming language'
      tag 'inko'
      filenames '*.inko'
      mimetypes 'text/x-inko'

      KEYWORDS = %w[
        as do fn if or and for let not ref try mut else impl loop next self when
        move true once case class async break match throw trait while false
        import return static builtin
      ].freeze

      state :root do
        rule(/\s+/m, Text::Whitespace)
        rule(/#.*$/, Comment::Single)
        rule(/"[^"]+"/, Str::Double)
        rule(/'[^']+'/, Str::Single)
        rule(/-?(?:0|[1-9]\d*)\.\d+(?:e[+-]?\d+)?/i, Num::Float)
        rule(/-?(?:0|[1-9]\d*)(?:e[+-]?\d+)?/i, Num::Integer)

        rule(/(\.)(\w+)/) do
          groups Punctuation, Name::Function
        end

        rule(/(\w+)(\()/) do
          groups Name::Function, Punctuation
        end

        rule(/(\w+)(::)/) do
          groups Name::Namespace, Punctuation
        end

        rule(/(\w+)(:)/) do
          groups Str::Symbol, Punctuation
        end

        rule(/(fn)(\s+)([^\(|^ ]+)/) do
          groups Keyword, Text, Name::Function
        end

        rule(/(class|trait)(\s+)(\w+)/) do
          groups Keyword, Text, Name::Class
        end

        rule(/@[a-z_]\w*/i, Name::Variable::Instance)
        rule(/[A-Z][a-zA-Z0-9_]*/, Name::Constant)
        rule(/->|!!|=>/, Keyword)
        rule(/(#{KEYWORDS.join('|')})\b/, Keyword)

        rule(/((<|>|\+|-|\/|\*)=?|==)/, Name::Function)

        rule(/(!|\?|\}|\{|\[|\]|\.|,|:|\(|\)|=)/, Punctuation)
        rule(/(\w+)\b/, Text)
      end
    end
  end
end
