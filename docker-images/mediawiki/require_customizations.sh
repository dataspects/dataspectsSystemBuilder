#######################################
# Include compiled mwmLocalSettings.php
$mwmls = "/var/www/config/mwmLocalSettings.php";
if(file_exists($mwmls)) {
      require_once($mwmls);
} else { 
      echo "ERROR: ../mwmLocalSettings.php include not loaded.";
}
#######################################
# Include manual mwmLocalSettings_manual.php
$mwmls = "/var/www/config/mwmLocalSettings_manual.php";
if(file_exists($mwmls)) {
      require_once($mwmls);
} else { 
      echo "ERROR: ../mwmLocalSettings_manual.php include not loaded.";
}
#######################################