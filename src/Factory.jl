"""
    function build(modeltype::Type{MyOneDimensionalElementaryWolframRuleModel}, data::NamedTuple) -> MyOneDimensionalElementarWolframRuleModel

This `build` method constructs an instance of the [`MyOneDimensionalElementaryWolframRuleModel`](@ref) type using the data in a [NamedTuple](https://docs.julialang.org/en/v1/base/base/#Core.NamedTuple).

### Arguments
i'm confused about the syntax?
- `modeltype::Type{MyOneDimensionalElementaryWolframRuleModel}`: The type of model to build, in this case, the [`MyOneDimensionalElementaryWolframRuleModel`](@ref) type.
- `data::NamedTuple`: The data to use to build the model.

The `data::NamedTuple` must contain the following `keys`:
- `index::Int64`: The index of the Wolfram rule
- `colors::Int64`: The number of colors in the rule
- `radius::Int64`: The radius, i.e., the number of cells to consider in the rule

### Return
This function returns a populated instance of the [`MyOneDimensionalElementaryWolframRuleModel`](@ref) type.
"""
function build(modeltype::Type{MyOneDimensionalElementaryWolframRuleModel}, 
    data::NamedTuple)::MyOneDimensionalElementaryWolframRuleModel

    # check: do we have the required keys in the data NamedTuple?
    required_fields = (:index, :colors, :radius);
    for field ∈ required_fields
        if haskey(data, field) == false
            @error "Ooops! Missing required field: $field. Cannot build the model, returning nothing."
            return nothing; # Early return we cannot build the model, so return nothing
        end
    end

    # Checks: we have the required keys in the data NamedTuple, we should check that they are of the correct type
    # ...

    # initialize -
    index = data.index;
    colors = data.colors;
    radius = data.radius;

    # create an empty model instance -
    model = modeltype();
    rule = Dict{Int,Int}(); # key: neighborhood state, value: resulting state

        # figure out how many possible neighborhood configurations exist
    total_configs = num_colors^cell_radius;
    
    # convert rule index to base-n representation
    rule_bits = digits(rule_index, base=num_colors, pad=total_configs);
    
    # map each neighborhood pattern to its output state
    for pattern_id ∈ 0:total_configs-1
        lookup_table[pattern_id] = rule_bits[pattern_id+1];
    end

    # set the data on the object
    model.index = index;
    model.rule = rule;
    model.radius = radius;
    model.number_of_colors = colors;

    # return
    return model;
end