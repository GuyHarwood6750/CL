<#      Extract credit card transactions from spreadsheet.
        Modify the $StartR (startrow) and $endR (endrow).
                This can only be done by eyeball as spreadsheet has historical data.
#>
$inspreadsheet = 'C:\userdata\circe launches\_All Suppliers\Supplier invoices cash vouchers 2021.xlsm'
$outfile2 = 'C:\userdata\circe launches\_All Suppliers\BC_1.csv'
$custsheet = 'Business Card'                                #Month worksheet
$startR = 2                                             #Start row - do not change
$endR = 29                                              #End Row - change if necessary depending on number of purchases
$csvfile = 'SHEET1.csv'
$pathout = 'C:\userdata\circe launches\_All Suppliers\'
$startCol = 1                                                                   #Start Col (don't change)
$endCol = 11                                                                     #End Col (don't change)
$filter = "P"
$outfile1 = 'C:\Userdata\circe launches\_all suppliers\BCTEMP.txt'              #Temp file
$outfileF = 'C:\Userdata\circe launches\_all suppliers\BCpurpastel.txt'             #File to be imported into Pastel             
$Outfile = $pathout + $csvfile

Import-Excel -Path $inspreadsheet -WorksheetName $custsheet -StartRow $startR -StartColumn $startCol -EndRow $endR -EndColumn $endCol -NoHeader -DataOnly| Where-Object -Filterscript { $_.P1 -eq $filter -and $_.P11 -ne 'done'} | Export-Csv -Path $Outfile -NoTypeInformation

ExcelFormatDate -file $Outfile -sheet 'sheet1' -column 'E:E'

Get-Content -Path $outfile | Select-Object -skip 1 | Set-Content -path $outfile2
Remove-Item -Path $outfile

#Remove last file imported to Pastel
$checkfile = Test-Path $outfileF
if ($checkfile) { Remove-Item $outfilef }                   

#Import latest csv from Client spreadsheet
$data = Import-Csv -path $outfile2 -header type, GL, Expacc, ST, date, ref, desc, amt1, amt, vat     

foreach ($aObj in $data) {
    #Return Pastel accounting period based on the transaction date.
    $pastelper = PastelPeriods -transactiondate $aObj.date
    
    Switch ($aObj.Expacc) {
        ADVERTISING { $expacc = '3050000' }            #Cleaning
        BC { $expacc = '3200000' }            #Bank charges
        Cleaning { $expacc = '3210000' }            #Cleaning
        COMP { $expacc = '3300000' }            #Computer expenses
        FUEL { $expacc = '4150000' }         #Motor vehicles
        GIFT { $expacc = '3551000' }            #Trade Gifts
        GOOGLE { $expacc = '4600000' }            #Google account
        KWE { $expacc = '5600472' }            #Ken Evans Loan Account
        MED { $expacc = '4500000' }            #Medical expenses, Staff welfare
        MVE { $expacc = '4150000' }         #Motor vehicles
        PC { $expacc = '4550000' }            #Protective clothing
        POBOX { $expacc = '3400000' }            #Post Office box
        RENT { $expacc = '4300000' }            #Rent
        RFA { $expacc = 'RFA' }            #Ropes for Africa
        RWE { $expacc = '5600473' }            #Richard Evans Loan Account
        RM { $expacc = '4350000' }            #Repairs and Maintenance
        REF { $expacc = '4500000' }            #Staff refreshments
        RWE { $expacc = '5600473' }            #Richard Evans Loan Account
        SS { $expacc = '3750000' }            #Ship stores & provisions
        STATIONERY { $expacc = '4200000' }    #Stationery
        TEL { $expacc = '4600000' }            #Telephone
        TETA { $expacc = '4451000' }            #TETA Training
        Default { $expacc = '9992000' }       #Unallocated Expense account      
    }

    Switch ($aObj.vat) {
        Y { $VATind = '15' }
        N { $VATind = '0' }
        Default {$VATind = '15'}
    }
    #Format Pastel batch   
    $props1 = [ordered] @{
        Period  = $pastelper
        Date    = $aObj.date
        GL      = $aObj.GL
        contra  = $expacc                       #Expense account to be debited (DR)
        ref     = $aObj.ref
        comment = $aObj.desc
        amount  = $aObj.amt
        fil1    = $VATind
        fil2    = '0'
        fil3    = ' '
        fil4    = '     '
        fil5    = '8401000'                     #Business card contra account number
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