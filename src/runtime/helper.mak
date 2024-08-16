
.PHONY: printenv

printenv:
    @$(foreach V, $(sort $(.VARIABLES)), $(if $(filter environment,$(origin $V)), $(info $V=$($V))))
