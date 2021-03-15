# generate .cfg file to match container properties

echo "rcon_password \"${RCON_PASSWORD}\""
echo "hostname \"${SERVER_HOSTNAME}\""
echo "sv_password \"${SERVER_PASSWORD}\""

echo "tv_name \"${STV_NAME}\""
echo "tv_title \"${STV_TITLE}\""
echo "tv_password \"${STV_PASSWORD}\""

echo "tftrue_logs_apikey \"${LOGS_TF_APIKEY}\""
echo "tftrue_logs_prefix \"${LOGS_TF_PREFIX}\""

echo "sm_demostf_apikey \"${DEMOS_TF_APIKEY}\""
