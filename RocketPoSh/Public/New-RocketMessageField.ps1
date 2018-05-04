function New-RocketMessageField{
param(
[string]$title,
[string]$value
)
if(!$title -or !$value){
    throw "Need a title and a value for the field."
}
$field = new-object -typename PSObject
$field | Add-Member -MemberType NoteProperty -Name title -value $title
$field | Add-Member -MemberType NoteProperty -Name value -value $value
return $field
}