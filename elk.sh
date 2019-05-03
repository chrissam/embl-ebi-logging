#!/usr/bin/env bash

function usage () {
  echo "Illegal number of parameters"
  echo ""
  echo "Usage: "
  echo "-----"
  echo "To start the demo: ./elk.sh start"
  echo "To stop the demo: ./elk.sh stop"
  echo "To destroy the demo environment: ./elk.sh destroy"
  echo ""
}
# Get user option
if [ "$#" -ne 1 ]; then
  usage
else
  # Set project name for docker compose
  project="ebi"
  # Ignore case sensitivity
  shopt -s nocasematch

  case ${1} in

    start)
      docker-compose -p ${project} up -d
      docker exec -it ${project}_nginx_1 bash -c "service nginx start"
      docker exec -it ${project}_nginx_1 bash -c "service filebeat start"
      if [ $? == 0 ]; then
        echo "EBI ELK demo environment started and ready"
      else
        echo "There was some problmen starting EBI ELK demo environment "
      fi
      ;;

    stop)
      docker-compose -p ${project} stop
      if [ $? == 0 ]; then
        echo "Successfully stopped"
      else
        echo "There was a problem stopping the environment"
      fi
      ;;

    destroy)
      docker-compose -p ${project} down
      ;;
    
    *)
      usage
      exit 1
      ;;
  esac
fi
