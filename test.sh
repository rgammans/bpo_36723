export PYTHON=python3
rm -f tmpfifo
(
    cd path2/namespace/
    echo "## Should be exactly one passing unittest"
    $PYTHON -m unittest discover
)

(
    cd path1/namespace/
    echo "## Should be exactly one passing unittest"
    $PYTHON -m unittest discover
)
(
    export PYTHONPATH=path1:path2
    if $PYTHON -m namespace.pkg1 ; then 
        echo "PKG1 found"
    else
        echo "## Can't traverse namesepace package correctly - test invalid"
    fi
    if $PYTHON -m namespace.pkg2 ; then 
        echo "PKG2 found"
    else
        echo "## Can't traverse namesepace package correctly - test invalid"
    fi
    
    echo "## Should be exactly two passing unittests"
    (
        $PYTHON -m unittest discover 2>&1 1>&3 | tee output >&2
    ) 3>&1
    ##Set return code for failure`
    grep "Ran 2 tests" output
)
