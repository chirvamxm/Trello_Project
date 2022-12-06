#Trello Requests

#Setup variables
$Url = "https://api.trello.com/"
$Endpoint = "1/cards/"
$POST_Endpoint = "1/cards"
$ApiKey = "35cae09b3a350023e39fa6b6e08c7575"
$ApiToken = "8dc4b0fcebfc0e4c620d7361506168de2fe48545c49e0cf04d2b4a696a3d641a"
$IdList = "638730ed94637d046620671a"

#Setup parameters for request
$Postparams = @{name = 'My Card'; desc = 'This is description of my card'}
$PutParams = @{name = 'My NEW card '; desc = 'This is NEW description of my card'}


# ===POST Request
$URLPostRequest = "$Url$POST_Endpoint"+"?idList=$IdList&key=$ApiKey&token=$ApiToken"
try {
$POSTRequest = Invoke-WebRequest -Method Post -Uri $URLPostRequest -Body $Postparams
    if ($POSTRequest.StatusCode -eq 200){
        Write-Host "Test is passed. Status code:"
        Write-Host $POSTRequest.StatusCode
        ConvertFrom-Json $POSTRequest | Format-list
    }  
  }
catch {
        Write-Host "Test FAILED"
}


# ===GET Request
$PostReqOnJson = $POSTRequest | ConvertFrom-Json
$GetCardID = $PostReqOnJson.id
$URLGetRequest = "$Url$Endpoint$GetCardID"+"?key=$ApiKey&token=$ApiToken"
Write-Host "Api call Uri: $URLUser"
try {
$GETRequest = Invoke-WebRequest -Uri $URLGetRequest 
    if ($GETRequest.StatusCode -eq 200){
        Write-Host "Test is passed. Status code:"
        Write-Host $GETRequest.StatusCode
        $ConvertedfromJsonGetRequest = $GETRequest.Content | ConvertFrom-Json
        $GETrequestWithAllInformation = "NAME: "+ $ConvertedfromJsonGetRequest.name + ", DESCRIPTION: " + $ConvertedfromJsonGetRequest.desc+ ", DATE OF LAST ACTIVITIES: " +$ConvertedfromJsonGetRequest.dateLastActivity
        Write-Host $GETrequestWithAllInformation
    }
  }
catch {
        Write-Host "Test FAILED"
}


# ===PUT Request
$URLPutRequest = "$Url$Endpoint"+"$GetCardID"+"?key=$ApiKey&token=$ApiToken"
try {
$PutRequest = Invoke-WebRequest -Method Put -Uri $URLPutRequest  -Body $PutParams
    if ($PutRequest.StatusCode -eq 200){
        Write-Host "Test is passed. Status code:"
        Write-Host $PutRequest.StatusCode
        ConvertFrom-Json $PutRequest | Format-list
    }
  }
catch {
        Write-Host "Test FAILED"
}


# ===DELETE Request
$URLDeleteRequest = "$Url$Endpoint"+"$GetCardID"+"?key=$ApiKey&token=$ApiToken"
try {
$DeleteRequest = Invoke-WebRequest -Method Delete -Uri $URLDeleteRequest
    if ($DeleteRequest.StatusCode -eq 200){
        Write-Host "Test is passed. Status code:"
        Write-Host $DeleteRequest.StatusCode
        ConvertFrom-Json $DeleteRequest | Format-list
    }
   }
catch {
        Write-Host "Test FAILED"
}

