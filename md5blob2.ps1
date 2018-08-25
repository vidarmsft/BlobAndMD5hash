#This script enumerates blob names and corresponding MD5 hashes as stored in the given storage account container.
#The output is stored in a csv file, you can specify the path of the file.
$storageAccountName = Read-Host "Please enter storage account name:"
$storageAccountKey = Read-Host "Please enter storage account key:"
$containerName = Read-Host "Please enter container name where blobs are stored:"
$path = Read-Host "Please enter path for csv output of the blob name and MD5:"
$ctx = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey
$blobs = Get-AzureStorageBlob -Context $ctx -Container $containerName
foreach ($blob in $blobs)
{
$cloudBlockBlob = [Microsoft.WindowsAzure.Storage.Blob.CloudBlockBlob]$blob.ICloudBlob
$outputline = $cloudBlockBlob.Name + "," + $cloudBlockBlob.Properties.ContentMD5
Add-Content -Path $path -Value $outputline
}


