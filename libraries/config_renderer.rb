module ChefHelpers
  # Some Doc
  module Mcollective
    def render(opts)
      flatten(Hash.new, nil, opts).map { |k, v| [k, v].join(' = ') }.join("\n")
    end

    def flatten(hash, prefix, opts)
      opts.inject(hash) do |aggr, (k, v)|
        new_prefix = [prefix, k].compact.join('.')
        case v
        when Hash
          flatten(aggr, new_prefix, v)
        when Array
          aggr[new_prefix] = v.join(':')
        else
          aggr[new_prefix] = v
        end
        aggr
      end
    end
  end
end
