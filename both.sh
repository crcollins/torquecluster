#!/bin/bash
mkdir -p /usr/local/bin/
mkdir -p /etc/gaussian/
cp /vagrant/A_TON_A_A_TD.{log,fchk} /etc/gaussian/
chmod +rrr /etc/gaussian/A_TON_A_A_TD.{log,fchk}

cat > /usr/local/bin/g09 <<EOF
#!/bin/bash

cat /etc/gaussian/A_TON_A_A_TD.log
EOF
chmod +x /usr/local/bin/g09

cat > /usr/local/bin/formchk <<EOF
#!/bin/bash

cat /etc/gaussian/A_TON_A_A_TD.fchk > \$2
EOF
chmod +x /usr/local/bin/formchk

cat > /usr/local/bin/module <<EOF
#!/bin/bash
EOF
chmod +x /usr/local/bin/module