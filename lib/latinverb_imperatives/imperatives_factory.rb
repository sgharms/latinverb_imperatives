module Linguistics
  module Latin
    module Verb
      class LatinVerb
        class ImperativesFactory
          extend Forwardable
          def_delegators :@verb, :irregular?, :deponent?, :semideponent?, :original_string

          def initialize(verb)
            @verb = verb
          end

          def imperatives
            return irregular if irregular?
            if deponent? || semideponent?
              deponent
            else
              standard
            end
          end

          private

            def irregular
              Linguistics::Latin::Verb::LatinVerb::IrregularImperativesRetriever.new(@verb.original_string).retrieve
            end

            def deponent
              DeponentImperativesHandler.new(@verb)
            end

            def standard
              ImperativesHandler.new(@verb)
            end
        end
      end
    end
  end
end
