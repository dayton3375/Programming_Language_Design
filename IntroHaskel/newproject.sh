read -p 'Enter the Directory Path: ' projectvar
mkdir $projectvar

if [[ $? -eq 0 ]]
then
    cd $projectvar
    cabal init -n --is-executable
    touch execute
    echo "cabal v2-run" > ./execute
    chmod 777 ./execute
else
    echo "mkdir failed.. possibly invalid input"
fi
