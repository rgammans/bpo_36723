export PYTHON=python3
rm -f tmpfifo
(
    cat <<EOF
    Test 1a.

    This test is to demonstrate the individual unittest in path2,
    is a valid and working unittest
    It should show  exactly one passing unittest
EOF
    cd path2/namespace/
    $PYTHON -m unittest discover
)

(
    cat <<EOF
    Test 1b.

    This test is to demonstrate the individual unittest in path1,
    is a valid and working unittest
    It should show  exactly one passing unittest
EOF
    cd path1/namespace/
    $PYTHON -m unittest discover
)
(
    cat <<EOF
    Test 2.

    This tests try to run two tests from packages within
    a namespace module at two different paths, joined with the
    PYTHONPATH environemnt.

    Before the unittest discovery id tests; we ensure we can
    import both packages normally, as this is a precondition 
    for discovery.
EOF

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
(
    cd path1
    export PYTHONPATH=../path2
    
    cat << EOF
    Test 3a:
        This should find two passing unittests but  
        finding a single passing unittests, may be acceptable
        See the README for a more in-depth discussion.
EOF

    if $PYTHON -m namespace.pkg1 ; then 
        echo "PKG1 found"
    else
        echo "## HCan't traverse namesepace package correctly - test invalid"
    fi
    if $PYTHON -m namespace.pkg2 ; then 
        echo "PKG2 found"
    else
        echo "## Can't traverse namesepace package correctly - test invalid"
    fi
    (
        $PYTHON -m unittest discover 2>&1 1>&3 | tee output >&2
    ) 3>&1
    ##Set return code for failure`
    grep "Ran 2 tests" output
)
(
    cd path2
    export PYTHONPATH=../path1
    
    cat << EOF
    Test 3b:
        This should find two passing unittests but  
        finding a single passing unittests, may be acceptable
        See the README for a more in-depth discussion.
EOF
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

    (
        $PYTHON -m unittest discover 2>&1 1>&3 | tee output >&2
    ) 3>&1
    ##Set return code for failure`
    grep "Ran 2 tests" output
)
