function ConvertFrom-ItemToCustomObject {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)][object]$Node
    )

    process{
        $customObject = $Node | ForEach-Object {
            [PSCustomObject]@{
                Number = $_.content.number
                Status = (Get-ItemFieldValue -Node $_ -FieldName "Status")
                Mytype = (Get-ItemFieldValue -Node $_ -FieldName "MyType")
                NCC = (Get-ItemFieldValue -Node $_ -FieldName "NCC")
                Title =  $_.content.title
                Comment = (Get-ItemFieldValue -Node $_ -FieldName "Comment")
                url = $_.content.url
            }
        }
        return $customObject
    }
}