#!/bin/bash

mgmt_cli -r true add administrator name "api-user" password "Vpn123Vpn123#nok" must-change-password false \
    authentication-method "check point password" permissions-profile "read write all"  --domain 'System Data' --format json
mgmt_cli -r true install-database targets.1 chkp-standalone