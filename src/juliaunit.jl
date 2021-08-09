using Unitful, Latexify, UnitfulLatexify, Measurements

struct PreprocessingOptions 
    precision::Int
    scientific::Bool
end

const OPTIONS = Dict{String,Union{Function,String}}(
    "precision" => x::Int -> "round-mode=places,round-precision=$x",
    "scientific" => "scientific-notation=true"
);


# TODO: improve naming of this function
# TODO: write docs
function fix_Measurements_output(number::Measurement, sigdigits::Int=1)::Measurement 
    io = IOBuffer();
    print(IOContext(io, :error_digits => sigdigits), number);
    str = String(take!(io));
    return measurement(str);
end

# TODO: improve naming of this function
# TODO: write docs
function filter_input(number::Quantity, sigdigits::Int=1)::Quantity
    current = number;
    if typeof(number.val) <: Measurement
        newval = fix_Measurements_output(number.val)
        current = newval * unit(current);
    end
    return float(current)
end
filter_input(number::Measurement, a=nothing)::Measurement = fix_Measurements_output(number)
filter_input(number::Number, a=nothing)::Float64 = float(number)

"""
apply_options(str::String, command::String, options::PreprocessingOptions)::String

Add options to a LaTeX command.

Examples:

julia> apply_options("\\num{2.2}", "\\num", PreprocessingOptions(4, true))
"\\num[round-mode=places,round-precision=4,scientific-notation=true]{2.2}"
"""
function apply_options(str::String, command::String, options::PreprocessingOptions)::String 
    options_list = String[]
    if options.scientific
        push!(options_list, OPTIONS["scientific"])
    end
    if options.precision > -1
        push!(options_list, OPTIONS["precision"](options.precision))
    end
    options_str = join(options_list, ",")
    return replace(str, "$command" => "$command[$options_str]", count=1);
end

function apply_options!(str::String, command::String, options::PreprocessingOptions)::Nothing
    str = apply_options(str, command, options)
end

"""
    latexify_unitful(number::T, precision::Int=-1, scientific::Bool=false)::Nothing where T <: Quantity

Converts a Unitful.Quantity to a LaTeX representation (with siunitx).
In LaTeX side, it's \\jlunit[<precision>][<scientific>]{<julia code>}.
"""
function latexify_unitful(number::T, precision::Int=-1, scientific::Bool=false)::Nothing where T <: Quantity
    options = PreprocessingOptions(precision, scientific);
    result = latexify(filter_input(number), unitformat=:siunitx) |> String;
    result = replace(result, "±" => "\\pm"); # Measurements.jl
    result = apply_options(result, "\\SI", options);
    print(result);
end

function latexify_unitful(number::Number, precision::Int=-1, scientific::Bool=false)::Nothing
    latexify_number(number, precision, scientific)
end

"""
latexify_number(number::T, precision::Int=-1, scientific::Bool=false)::Nothing where T <: Quantity

Converts a number to a LaTeX representation (with siunitx's \\num).
In LaTeX side, it's \\jlnum[<precision>][<scientific>]{<julia code>}.
"""
function latexify_number(number::Number, precision::Int=-1, scientific::Bool=false)::Nothing
    result = apply_options("\\num{$(filter_input(number))}", "\\num", PreprocessingOptions(precision, scientific));
    result = replace(result, "±" => "\\pm"); # Measurements.jl
    print(result);
end
function latexify_number(number::Quantity, precision::Int=-1, scientific::Bool=false)::Nothing
    latexify_number(number.val, precision, scientific);
end

"""
    latexify_number_and_unity(number::Number, unity::String, precision::Int=-1, scientific::Bool=false)::Nothing

Converts a number to a LaTeX representation together with an arbitrary unit (with siunitx's \\SI).
In LaTeX side, it's \\jlSI[<precision>][<scientific>]{<julia code>}{<siunitx's commands>}.
"""
function latexify_number_and_unity(number::Number, unity::String, precision::Int=-1, scientific::Bool=false)::Nothing
    result = apply_options("\\SI{$number}{$unity}", "\\SI", PreprocessingOptions(precision, scientific));
    print(result);
end

