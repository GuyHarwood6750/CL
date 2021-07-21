<#      Extract from Customer spreadsheet the range for new invoices to be generated.
        Modify the $StartR (startrow) and $endR (endrow).
        This can only be done by eyeball as spreadsheet has historical data.
#>

$inspreadsheet = 'C:\userdata\circe launches\_all suppliers\Supplier invoices cash vouchers 2021.xlsm'
$csvfile = 'suppliers cash payment.csv'
$pathout = 'C:\userdata\circe launches\_all suppliers\'
$custsheet = 'JULY 2021'                          #Customer worksheet
$outfile2 = 'C:\userdata\circe launches\_aLL suppliers\suppliers paid cash JULY 2021.csv'
$startR = 2                                    #Start row
$endR = 18                                   #End Row
$startCol = 1                                    #Start Col (don't change)
$endCol = 10                                      #End Col (don't change)
$filter = "CSH"

$Outfile = $pathout + $csvfile

Import-Excel -Path $inspreadsheet -WorksheetName $custsheet -StartRow $startR -StartColumn $startCol -EndRow $endR -EndColumn $endCol -NoHeader -DataOnly | Where-Object -FilterScript {$_.P1 -ne $filter -and $_.P9 -ne 'Card' -and $_.P9 -ne 'CN' -and $_.P9 -eq 'Cash' -and $_.P10 -ne 'Done'} | Export-Csv -Path $Outfile -NoTypeInformation

# Format date column correctly
ExcelFormatDate -file $Outfile -sheet 'suppliers cash payment' -column 'C:C'

Get-Content -Path $outfile | Select-Object -skip 1 | Set-Content -path $outfile2
Remove-Item -Path $outfile
<#  Get list of Cash payments to suppliers
    Output to text file to be imported as a Pastel Cashbook batch.
#>
 #Input from Supplier spreadsheet
#$csvclient = 'C:\Userdata\circe launches\_all suppliers\suppliers paid cash.csv'                 
$outfile1 = 'C:\Userdata\circe launches\_all suppliers\cashpur1.txt'                  #Temp file
#File to be imported into Pastel
$outfileF = 'C:\Userdata\circe launches\_all suppliers\cashsuppliers.txt'             
#Remove last file imported to Pastel
$checkfile = Test-Path $outfileF
if ($checkfile) { Remove-Item $outfilef }                   

#Import latest csv from Supplier spreadsheet
$data = Import-Csv -path $outfile2 -header suppacc, alloc, date, ref, invnum, desc, amt    

foreach ($aObj in $data) {
    #Return Pastel accounting period based on the transaction date.
    $pastelper = PastelPeriods -transactiondate $aObj.date
    
       #Format Pastel batch
    
    $props1 = [ordered] @{
        Period  = $pastelper
        Date    = $aObj.date
        GL      = 'C'
        contra  = $aobj.suppacc                       #Expense account to be debited (DR)
        ref     = $aObj.ref
        comment = $aObj.desc
        amount  = $aObj.amt
        fil1    = '0'
        fil2    = '0'
        fil3    = ' '
        fil4    = ' '
        fil5    = '8410000'                     #Cash voucher contra account number
        fil6    = '1'
        fil7    = '1'
        fil8    = '0'
        fil9    = '0'
        fil10   = '0'
        amt2    = $aObj.amt
    }
      
        $objlist = New-Object -TypeName psobject -Property $props1
        $objlist | Select-Object * | Export-Csv -path $outfile1 -NoTypeInformation -Append
    
    }  
    #Remove header information so file can be imported into Pastel Accounting.
    
    Get-Content -Path $outfile1 | Select-Object -skip 1 | Set-Content -path $outfilef
    Remove-Item -Path $outfile1