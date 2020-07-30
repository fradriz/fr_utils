# Unit Test
Following this tutorial: https://realpython.com/python-testing/

* Unit test: Testing part of the code, like one function
* Integration Test: Testing the whole code

# Modules discovery

To avoid problems with the modules, make all the directory you need like packages by including '__init__.py'
After:
* Go to root directory: $ cd ../fr_utils/
* Run: $ pip3 install . 

## Running the test
Go to ../fr_utils/a_python/UnitTest/tests

Run: 
    $ python -m unittest test_sum                       # check python -V first (don't run python2 ..)
    $ python -m unittest test_sum -v                    # verbose
    $ python -m unittest discover ./tests/              # Run all the tests in directory    
    $ python -m unittest discover -s test_sum -t src    # ??
