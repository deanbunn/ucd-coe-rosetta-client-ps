

class RosettaAPIWorker
{

    [string]$BaseURL
    [string]$TokenURL
    [string]$ClientID
    [string]$ClientSecret
    [string]$OAuthToken
    [datetime]$ExpiresIn

    #Constructor
    RosettaAPIWorker([string]$baseURL, [string]$tokenURL, [string]$clientID, [string]$clientSecret)
    {
        $this.BaseURL = $baseURL
        $this.TokenURL = $tokenURL
        $this.ClientID = $clientID
        $this.ClientSecret = $clientSecret
        $this.ExpiresIn = (Get-Date).AddHours(-1)
    }

    






}