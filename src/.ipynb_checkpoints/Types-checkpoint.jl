abstract type AbstractWolframSimulationAlgorithm end
abstract type AbstractRuleModel end

"""
    mutable struct MyOneDimensionalElementaryWolframRuleModel <: AbstractRuleModel

The `MyOneDimensionalElementarWolframRuleModel` mutable struct represents a one-dimensional elementary Wolfram rule model.

### Fields
- `index::Int` - The index of the rule
- `radius::Int` - The radius, i.e, the number of cells that influence the next state for this rule
- `rule::Dict{Int,Int}` - A dictionary that holds the rule where the `key` is the binary representation of the neighborhood and the `value` is the next state
"""
mutable struct MyOneDimensionalElementaryWolframRuleModel <: AbstractRuleModel
    
    # data
    index::Int
    radius::Int
    number_of_colors::Int
    rule::Dict{Int, Int}

    # constructor -
    MyOneDimensionalElementaryWolframRuleModel() = new();
end

struct WolframDeterministicSimulation <: AbstractWolframSimulationAlgorithm end
struct WolframStochasticSimulation <: AbstractWolframSimulationAlgorithm end