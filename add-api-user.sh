#!/bin/bash

mgmt_cli -r true add administrator name "api_user" password "#vpn123#ok" must-change-password false \
    authentication-method "check point password" permissions-profile "read write all"  --domain 'System Data' --format json
mgmt_cli -r true install-database targets.1 chkp-standalone