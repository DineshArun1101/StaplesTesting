#!/bin/bash

JMETER_HOME=$1
REPORT_NAME=$2

THREADS_SAMPLE_ITF=10
RAMPUP_ITF=60
TESTDURATION_ITF=300

RAMPUP_ITF_MIN=$((RAMPUP_ITF / 60))
TESTDURATION_ITF_MIN=$((TESTDURATION_ITF / 60))

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
echo "Rampup_ITF_SEC         : $RAMPUP_ITF"
echo "Duration_ITF_SEC       : $TESTDURATION_ITF"

echo "Rampup_ITF_MIN         : $RAMPUP_ITF_MIN"
echo "Duration_ITF_MIN       : $TESTDURATION_ITF_MIN"
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
  -Gtestduration_itf=$TESTDURATION_ITF \
  -Jrampup_itf_min=$RAMPUP_ITF_MIN \
  -Jtestduration_itf_min=$TESTDURATION_ITF_MIN \
  -Grampup_itf_min=$RAMPUP_ITF_MIN \
  -Gtestduration_itf_min=$TESTDURATION_ITF_MIN

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