function yp () find . -name $1 -delete

function ypd () find . -type d -name $1 -exec rm -fr {} +
