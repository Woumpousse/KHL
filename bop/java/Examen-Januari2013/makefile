all: @assignment @solution

@assignment: @doc
	7z a assignment.zip doc\opgave.zip src tests

@solution: @doc
	7z a solution.zip doc\opgave.zip src tests solution

@doc:
	pushd doc & nmake all

clean:
	del /s /q bin
	rmdir bin
	pushd doc & nmake clean

