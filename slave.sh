#!/bin/bash
apt-get install -y torque-client torque-mom

cat > /var/spool/torque/mom_priv/config <<EOF
\$pbsserver      slave$1
\$logevent       255
EOF