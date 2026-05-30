#!/bin/bash

JMETER_HOME=$1
REPORT_NAME=$2

THREADS_SAMPLE_ITF=10
RAMPUP_ITF=1
TESTDURATION_ITF=300

# Result Folder
RESULT_DIR="results-history/results_${REPORT_NAME}"

# Create folder
mkdir -p "$RESULT_DIR"

# Files
JTL_FILE="$RESULT_DIR/results.jtl"
LOG_FILE="$RESULT_DIR/jmeter.log"
HTML_REPORT="$RESULT_DIR/html-report"

echo "======================================="
echo "Starting JMeter Load Test"
echo "Threads_ITF        : $THREADS_SAMPLE_ITF"
echo "Rampup_ITF         : $RAMPUP_ITF"
echo "Duration_ITF       : $TESTDURATION_ITF"
echo "Report Name    : $REPORT_NAME"
echo "Result Folder  : $RESULT_DIR"
echo "======================================="

"$JMETER_HOME/bin/jmeter.bat" -n \
  -t ITF_Validtion_SampleScript.jmx \
  -l "$JTL_FILE" \
  -j "$LOG_FILE" \
  -e \
  -o "$HTML_REPORT" \
  -Jthreads_sample_itf=$THREADS_SAMPLE_ITF \
  -Jrampup_itf=$RAMPUP_ITF \
  -Jtestduration_itf=$TESTDURATION_ITF \
  -Gthreads_sample_itf=$THREADS_SAMPLE_ITF \
  -Grampup_itf=$RAMPUP_ITF \
  -Gtestduration_itf=$TESTDURATION_ITF

EXIT_CODE=$?

echo "======================================="
echo "JMeter Exit Code = $EXIT_CODE"
echo "======================================="

if [ $EXIT_CODE -ne 0 ]; then
    echo "JMeter Test Failed"
    exit $EXIT_CODE
fi

echo "Results stored in : $RESULT_DIR"
echo "HTML Report       : $HTML_REPORT/index.html"
echo "======================================="

echo "Test Execution Completed"