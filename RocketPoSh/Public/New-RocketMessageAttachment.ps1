function New-RocketMessageAttachment{
param(
[string]$title,
[string]$text,
[switch]$collapsed,
[object[]]$fields
)
$attachment = @{}
$attachment.title = $title
$attachment.text = $text
$attachment.collapsed = $collapsed
$attachment.fields = $fields
return $attachment
}