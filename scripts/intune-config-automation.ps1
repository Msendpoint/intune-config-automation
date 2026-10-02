### FILE: index.php
<?php

// Ensure session includes the necessary Microsoft Graph access token.
if (!isset($_SESSION['ms_access_token'])) {
    die('Access token missing');
}

// Example of calling the Graph API and handling exceptions.
try {
    $deviceID = 'exampleDeviceID';
    $policyID = 'examplePolicyID';
    $response = $ms->graphCall('/deviceManagement/deviceCompliancePolicies', $_SESSION['ms_access_token'], 'POST', [
        'deviceId' => $deviceID,
        'policyId' => $policyID
    ]);

    render_premium_card(
        'Compliance Configuration',
        'Configuration applied successfully',
        null,
        'up',
        '📊',
        100
    );
} catch (Exception $e) {
    render_premium_card(
        'Compliance Configuration Error',
        'Error applying configuration: ' . $e->getMessage(),
        null,
        'down',
        '⚠️',
        0
    );
}

?>

### FILE: scripts/Automation.ps1
<#
.SYNOPSIS
Automates the Intune device compliance policy application.

.DESCRIPTION
This script connects to Microsoft Graph and applies a device compliance policy
to a specified device via Intune, providing feedback on success or failure.

.EXAMPLE
./Automation.ps1 -DeviceID "device-id" -PolicyID "policy-id"

.NOTES
    Author:      Souhaiel Morhag
    Company:     MSEndpoint.com
    Blog:        https://msendpoint.com
    Academy:     https://app.msendpoint.com/academy
    LinkedIn:    https://linkedin.com/in/souhaiel-morhag
    GitHub:      https://github.com/Msendpoint
    License:     MIT
#>

param (
    [string]$DeviceID,
    [string]$PolicyID
)

try {
    # Connect to Microsoft Graph
    Connect-MgGraph -Scopes "DeviceManagementConfiguration.ReadWrite.All"

    # Apply compliance policy
    Set-MgDeviceManagementDeviceCompliancePolicy -DeviceId $DeviceID -PolicyId $PolicyID

    # Output success message
    Write-Host "Configuration applied successfully." -ForegroundColor Green
} catch {
    # Handle errors
    Write-Host "Error applying configuration: $_" -ForegroundColor Red
}