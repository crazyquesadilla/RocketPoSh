function New-RocketMessageAttachment{
param(
[string]$title,
[string]$text,
[switch]$collapsed,
[string]$color,
[object[]]$fields
)

if(($color) -and ($color -notmatch "^[A-Fa-f0-9]{6}$")){
    throw "-Color parameter is not a hex value."
}

$attachment = @{}
$attachment.title = $title
$attachment.text = $text
$attachment.collapsed = $collapsed
$attachment.color = $color
$attachment.fields = $fields
return $attachment
}