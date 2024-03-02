function run_thub_docker {
docker run --rm -d -p --name thunderhub $thub_port:3000/tcp thunderhub || runfailed=true
echo "pausing to see if run command successful"
enter_continue
if [[ $runfailed == true ]] ; then 
announce "Something went wrong. Aborting."
unset runfailed ; return 1 ; fi
}