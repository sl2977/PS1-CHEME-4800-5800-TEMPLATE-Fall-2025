# setup paths -
const _ROOT = @__DIR__;
const _PATH_TO_DATA = joinpath(_ROOT, "data");
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# did this include file get called?
const _INCLUDE_STUDENT_JL_CALLED = true;


# if we are missing any packages, install them -
using Pkg;
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
        #originally having trouble with installing and using this package
    #need to go through the include.jl and opening up julia from terminal 
    #to access the package
    Pkg.add(path="https://github.com/varnerlab/VLDataScienceMachineLearningPackage.jl.git")
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end




# load external packages -
using PrettyTables
using DataFrames
using Test
using Random
using Statistics
using LinearAlgebra
using Plots
using Colors
using DataStructures
using Distributions
using Images
using ImageInTerminal
using ImageShow

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Factory.jl"));
include(joinpath(_PATH_TO_SRC, "Wolfram.jl"));