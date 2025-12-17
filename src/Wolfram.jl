# -- PRIVATE API BELOW HERE ------------------------------------------------------------------------ #
function _simulate(algorithm::WolframDeterministicSimulation, rulemodel::MyOneDimensionalElementaryWolframRuleModel, initial::Array{Int64,1}; 
    steps::Int64 = 240, maxnumberofmoves::Union{Int64, Nothing} = nothing, 
    parameters::Union{Nothing, Dict{Int, Float64}} = nothing,
    cooldownlength::Int64 = 0)::Dict{Int64, Array{Int64,2}}
    
    # get stuff from model -
    radius = rulemodel.radius; # how many cells am I looking at?
    number_of_colors = rulemodel.number_of_colors; # how many colors (states) can each cell have?
    width = length(initial); # how many cells are there?

    # initialize -
    frames = Dict{Int64, Array{Int64,2}}();
    frame = Array{Int64,2}(undef, steps, width) |> X -> fill!(X, 0);

    # set the initial state -
    foreach(i -> frame[1,i] = initial[i], 1:width);    
    frames[1] = frame; # set the initial frame -
    
 # step through time
    for t in 2:steps
        # copy previous timestep
        frame = copy(frames[t-1])
        neighbor_states = Array{Int64,1}(undef, radius) |> a -> fill!(a, 0)
        
        # update each cell
        for cell in 1:width
            # handle wrapping at boundaries
            left_cell = (cell == 1) ? width : cell - 1
            right_cell = (cell == width) ? 1 : cell + 1
            
            neighbor_states[1] = frame[t-1, left_cell]
            neighbor_states[2] = frame[t-1, cell]
            neighbor_states[3] = frame[t-1, right_cell]
            
            # look up what state this neighborhood maps to
            rule_index = parse(Int, join(neighbor_states), base = number_of_colors)
            frame[t, cell] = rulemodel.rule[rule_index]
        end
        
        frames[t] = frame
    end
    
    return frames
end


function _simulate(algorithm::WolframStochasticSimulation, rulemodel::MyOneDimensionalElementaryWolframRuleModel, initial::Array{Int64,1}; 
    steps::Int64 = 240, maxnumberofmoves::Union{Int64, Nothing} = nothing, 
    parameters::Union{Nothing, Dict{Int, Float64}} = nothing,
    cooldownlength::Int64 = 0)::Dict{Int64, Array{Int64,2}}

    # get stuff from model
    radius = rulemodel.radius; # how many cells am I looking at?
    number_of_colors = rulemodel.number_of_colors; # how many colors (states) can each cell have?
    width = length(initial); # how many cells are there?
    q = Queue{Int64}(); # which cells will update?

    # initialize -
    frames = Dict{Int64, Array{Int64,2}}();
    frame = Array{Int64,2}(undef, steps, width) |> X -> fill!(X, 0);

    # cooldown -
    cooldown = Dict{Int64, Int64}(); # cooldown for each cell
    foreach(i -> cooldown[i] = 0, 1:width); # initialize cooldown for each cell

    # set the initial state -
    foreach(i -> frame[1,i] = initial[i], 1:width);    
    frames[1] = frame; # set the initial frame

    # TODO: implement the simulation run loop for the stochastic simulation here
    # TODO: Make sure to comment out the throw statement below once you implement this functionality
    throw(ErrorException("The simulation run loop for the stochastic simulation has not been implemented yet."));
    
    # return
    return frames;
end
# -- PRIVATE API ABOVE HERE ------------------------------------------------------------------------ #


# -- PUBLIC API BELOW HERE ------------------------------------------------------------------------ #
"""
    function simulate(rulemodel::MyOneDimensionalElementaryWolframRuleModel, initial::Array{Int64,1};
        steps::Int64 = 24, maxnumberofmoves::Union{Int64, Nothing} = nothing, 
        algorithm::AbstractWolframSimulationAlgorithm)) -> Dict{Int64, Array{Int64,2}}

The simulate function runs a Wolfram simulation based on the provided rule model and initial state.

### Arguments
- `rulemodel::MyOneDimensionalElementaryWolframRuleModel`: The rule model to use for the simulation.
- `initial::Array{Int64,1}`: The initial state of the simulation.
- `steps::Int64`: The number of steps to simulate.
- `maxnumberofmoves::Union{Int64, Nothing}`: The maximum number of moves to simulate.
- `algorithm::AbstractWolframSimulationAlgorithm`: The algorithm to use for the simulation.

### Returns
- A dictionary mapping step numbers to the state of the simulation at that step.
"""
function simulate(rulemodel::MyOneDimensionalElementaryWolframRuleModel, initial::Array{Int64,1}; 
    steps::Int64 = 24, maxnumberofmoves::Union{Int64, Nothing} = nothing, 
    cooldownlength::Int64 = 0, parameters::Union{Nothing, Dict{Int, Float64}} = nothing,
    algorithm::AbstractWolframSimulationAlgorithm)::Dict{Int64, Array{Int64,2}}

    return _simulate(algorithm, rulemodel, initial; steps=steps, 
        maxnumberofmoves=maxnumberofmoves, cooldownlength=cooldownlength, parameters=parameters);
end
# -- PUBLIC API ABOVE HERE ------------------------------------------------------------------------ #