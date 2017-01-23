#!/bin/bash

echo "Getting environment variables from /.env"
echo "Available params: "
echo "\t--dev -> development. Default (production)"
echo "\t--debug -> execute docker-compose not in daemon, so you can see logs"



dev=false
debug=false

while [[ ${1} ]]; do
    case "${1}" in
        --dev)
            dev=true #${2}
            shift
           ;;
        --debug)
            debug=true #${2}
            shift
            ;;
        *)
            echo "Unknown parameter: ${1}" >&2
            return 1
    esac

    #if ! shift; then
    #    echo 'Missing parameter argument.' >&2
    #    return 1
    #fi
done

if $dev ; then 
	echo "Executing --dev"
	if $debug ; then
		echo "Executing --debug"
		sudo docker-compose -f docker-compose.yml -f docker-compose.dev.yml up
	else
                sudo docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
		sudo service docker status
	fi
else
	echo "Executing --prod"
	sudo docker-compose up -d
	sudo service docker status
	echo "execute docker-compose down to stop all containers"
fi
