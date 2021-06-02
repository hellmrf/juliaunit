"""
Bundles the two sides in a single file .sty that can be used with LaTeX.
"""

cd(@__DIR__);
function main()
    template = Vector{String}()
    open("./src/juliaunit_template.sty", "r") do io 
        template = readlines(io)
    end;
    
    filter!(x -> !startswith(x, '%') && !isempty(x), template)
    
    template_str = join(template, "\n")
    
    
    julia_side = ""
    open("./src/juliaunit.jl", "r") do io 
        julia_side = read(io, String)
    end;

    sty = replace(template_str, "###JULIA_CODE_GOES_HERE###" => julia_side);

    open("./juliaunit.sty", "w") do io 
        write(io, sty)
    end;
    @info "Generated ./src/juliaunit.sty"
end
main();