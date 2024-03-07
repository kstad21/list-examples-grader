CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

#recursively delete stuff from last submission
rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

#detect whether ListExamples.java is there
#what if there is a directory inside student submission?
if [[ -f "student-submission/ListExamples.java" ]]
then 
    echo "File found"
else 
    echo "File ListExamples.java not found!"
    exit 1
fi

#move stuff into grading area
cp student-submission/ListExamples.java grading-area/
cp TestListExamples.java grading-area/
cp -r lib grading-area/

cd grading-area
javac -cp $CPATH *.java

if [[ $? -ne 0 ]]
then
    echo "Compilation error!"
    exit 1
else
    echo "Compiled successfully"
fi

#actually run the tests
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > junit-output.txt
cat junit-output.txt


TESTS=$(tail -3 junit-output.txt)
echo "Tests failed out of 2: (if it's empty you get 100!!!!)"
echo $TESTS | cut -d' ' -f6


#parts=$(echo "$my_string" | cut -d',' -f1,2,3)

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
