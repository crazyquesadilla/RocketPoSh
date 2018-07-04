function Send-RocketMessage{
    <#
        .SYNOPSIS
            This creates and sends a message to RocketChat. 
        
        .DESCRIPTION
            This creates and sends a message to RocketChat. If needed, you can create an attachment with fields and pass it to this function.
        
        .PARAMETER Webhook
            RocketChat integration URL. You can get this by going to Administration > Integrations > *desired webhook* > Webhook URL
        
        .PARAMETER Text
            This is just text for the message. 
            This is the easiest way to send a message - if you need more information, make an attachment instead.
        
        .PARAMETER Attachment
            This is an attachment object, created by New-RocketMessageAttachment.
        
        .PARAMETER Emoji
            Emoji that you want the message to show up with. You can use one of the default RocketChat emojis.
        
        .PARAMETER Alias
            The alias you want the message to show as coming from.
        
        .EXAMPLE
            # This is an example of creating a collapsed attachment and sending it to RocketChat.
            $webhook = "Rocketchat Integration URL"
            $attachment = New-RocketMessageAttachment -title "Title" -text "Description" -collapsed
            Send-RocketMessage -webhook $webhook -attachment $attachment
    
    #>
    param(
    [string]$text,
    [string]$alias = "RocketCat",
    [string]$emoji = ":robot:",
    [string]$webhook,
    [object]$attachment
    )
    try {
        $debug = $PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent 
    }
    catch {
        Write-Warning $_
    }
    
    $body += @{}
    if((($text) -or ($attachment)) -and ($webhook)){
        $body.alias = $alias
        $body.emoji = $emoji
        if($text){$body.text = $text}
        if($attachment){
            $body += @{info = @{}}
            $body.info.title = $attachment.title
            $body.info.text = $attachment.text
            if($attachment.collapsed){$body.info.collapsed = $true}
            $body.info.color = $attachment.color
            if($attachment.fields){
                $body.info.fields = @()
                foreach($field in $attachment.fields){
                    $body.info.fields += $field
                }
            }
        }
        $uri = $webhook
    
        $json = convertto-json $body -depth 5
    
        invoke-webrequest -contenttype "application/json" -method post -uri $uri -Body $json -UseBasicParsing | out-null
    }
    elseif(!$webhook){throw "Need a webhook URL. Administration>Integrations>*desired webhook*>Webhook URL"}
    elseif(!$text -and !$attachment){throw "Need text to send"}
    
    if($debug){$json}else{"Sent!"}
}
    