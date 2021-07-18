<#      Extract from EXPENSES spreadsheet the range for new invoices to be generated.
        Modify the $StartR (startrow) and $endR (endrow). 
#>
$inspreadsheet = 'C:\userdata\circe launches\_all suppliers\supplier invoices cash vouchers 2021.xlsm'          #Source workbook
$csvfile = 'suppliers_1.csv'                                                                                    #Temp file
$pathout = 'C:\userdata\circe launches\_all suppliers\'
$custsheet = 'JULY 2021'                                                                        #Month worksheet - changes each month
$outfile2 = 'C:\userdata\circe launches\_all suppliers\suppliers JULY 2021_1.csv'                  #Change each month
$startR = 2                                             #Start row - does not change       
$endR = 11                                              #End Row - changes each month depending on number of invoices
$startCol = 1                                           #Start Col (don't change)
$endCol = 10                                             #End Col (don't change)
#$filter= "CSH"                                          #Filter - Not CASH VOUCHERS - SER Where-Object BELOW
$Outfile = $pathout + $csvfile

Import-Excel -Path $inspreadsheet -WorksheetName $custsheet -StartRow $startR -StartColumn $startCol -EndRow $endR -EndColumn $endCol -NoHeader -DataOnly | Where-Object -Filterscript { $_.P1 -ne 'CSH' -and $_.P9 -ne 'CN' -and $_.P9 -ne 'BC'-and $_.P10 -ne 'Done' } | Export-Csv -Path $Outfile -NoTypeInformation

# Format date column correctly
ExcelFormatDate -file $Outfile -sheet 'suppliers_1' -column 'C:C'

Get-Content -Path $outfile | Select-Object -skip 1 | Set-Content -path $outfile2
Remove-Item -Path $outfile

<#  Get list of Supplier invoices from spreadsheet
    Output to text file to be imported as a Pastel Invoice batch.
#>
#Input from Supplier spreadsheet
#$csvsupplier = 'C:\userdata\circe launches\_all suppliers\suppliers JULY 2020_4.csv'
#Temp file      
$outfile1a = 'C:\userdata\circe launches\_all suppliers\supplierinv.txt'
#File to be imported into Pastel        
$outfile3 = 'C:\userdata\circe launches\_all suppliers\supplier invoices.txt'     

#Remove last file imported to Pastel
$checkfile = Test-Path $outfile3
if ($checkfile) { Remove-Item $outfile3 }                   

#Import latest csv from Supplier spreadsheet, VAT & NO-VAT
$data = Import-Csv -path $outfile2 -header acc, Expacc, date, ref, invnum, desc, amt, vat

foreach ($aObj in $data) {
        #Return Pastel accounting period based on the transaction date.
        $pastelper = PastelPeriods -transactiondate $aObj.date

        #Process transactions based on VAT=Y or VAT=N  
        switch ($aObj.vat) { 
                Y {
                        [decimal]$amount = $aObj.amt
                        $c = VATCalc -amountincvat $amount
                        $vatexamt = $c.vatexamt
                        $vatpercent = $c.vatpercent
                }
                N {
                        [decimal] $amount = $aObj.amt
                        [decimal] $vatexamt = $aObj.amt
                        $vatpercent = 0 
                }
        }   
        #Process Supplier
        Switch ($aObj.acc) {
                307LUB { $expacc = '3800000'; $description = $aObj.desc }
                ABE { $expacc = '4350000'; $description = $aObj.desc }
                ABPRO { $expacc = '3050000'; $description = $aObj.desc }
                AFROX { $expacc = '4350000'; $description = $aObj.desc }
                ANCH { $expacc = '4350000'; $description = $aObj.desc }
                ASTRO { $expacc = '4350000'; $description = $aObj.desc }
                ASPA { $expacc = '4350000'; $description = $aObj.desc }
                ASSR { $expacc = '4350000'; $description = $aObj.desc }
                BALT { $expacc = '4350000'; $description = $aObj.desc }
                BALMA { $expacc = '4350000'; $description = $aObj.desc }
                BANF { $expacc = '3050000'; $description = $aObj.desc }
                BER { $expacc = '4350000'; $description = $aObj.desc }
                BOLTF { $expacc = '4350000'; $description = $aObj.desc }
                BSAIL { $expacc = '4350000'; $description = $aObj.desc }
                CAVIC { $expacc = '4350000'; $description = $aObj.desc }
                CAPERU { $expacc = '4350000'; $description = $aObj.desc }
                CELLC { $expacc = '4600000'; $description = $aObj.desc }
                CHCOM { $expacc = '3050000'; $description = $aObj.desc }
                CHEN { $expacc = '4350000'; $description = $aObj.desc }
                DANSH { $expacc = '4000000'; $description = $aObj.desc }
                DAV { $expacc = '4600000'; $description = $aObj.desc }
                COCR { $expacc = '5600472'; $description = $aObj.desc }
                COCE { $expacc = '3650000'; $description = $aObj.desc }
                CRS { $expacc = '4350000'; $description = $aObj.desc }
                EXCFLA { $expacc = '4350000'; $description = $aObj.desc }
                EXPHB { $expacc = '3050000'; $description = $aObj.desc }
                FAS1 { $expacc = '4350000'; $description = $aObj.desc }
                FEW { $expacc = '4350000'; $description = $aObj.desc }
                FOWBR { $expacc = '4350000'; $description = $aObj.desc }
                FMG { $expacc = '3000000'; $description = $aObj.desc }
                FLWT { $expacc = '4350000'; $description = $aObj.desc }
                GARD { $expacc = '4350000'; $description = $aObj.desc }
                GRIDH { $expacc = '4600000'; $description = $aObj.desc }
                GHTM { $expacc = '4150000'; $description = $aObj.desc }
                GHTW { $expacc = '4150000'; $description = $aObj.desc }
                HARW { $expacc = '3000000'; $description = $aObj.desc }
                HBON { $expacc = '4200000'; $description = $aObj.desc }
                HBYC { $expacc = '4300000'; $description = $aObj.desc }
                HYDT { $expacc = '4350000'; $description = $aObj.desc }
                INNEW { $expacc = '3050000'; $description = $aObj.desc }
                INTAS { $expacc = '4150000'; $description = $aObj.desc }
                JSCHIP { $expacc = '4350000'; $description = $aObj.desc }
                LTD { $expacc = '4350000'; $description = $aObj.desc }
                NDE { $expacc = '4350000'; $description = $aObj.desc }
                MANEX { $expacc = '4350000'; $description = $aObj.desc }
                MACSTE { $expacc = '4350000'; $description = $aObj.desc }
                MLRF { $expacc = '4211000'; $description = $aObj.desc }
                MSTD { $expacc = '4451000'; $description = $aObj.desc }
                ORLICH { $expacc = '4350000'; $description = $aObj.desc }
                PEC { $expacc = '4451000'; $description = $aObj.desc }
                POT { $expacc = '4350000'; $description = $aObj.desc }
                PSS { $expacc = '4350000'; $description = $aObj.desc }
                RADH { $expacc = '4350000'; $description = $aObj.desc }
                RAP { $expacc = '4150000'; $description = $aObj.desc }
                REDW { $expacc = '4451000'; $description = $aObj.desc }
                RFA { $expacc = '4350000'; $description = $aObj.desc }
                RPW { $expacc = '4200000'; $description = $aObj.desc }
                RWOOD { $expacc = '4350000'; $description = $aObj.desc }
                SATSA { $expacc = '4502000'; $description = $aObj.desc }
                SAMSA { $expacc = '4350000'; $description = $aObj.desc }
                SAVA { $expacc = '4350000'; $description = $aObj.desc }
                SEAP { $expacc = '4350000'; $description = $aObj.desc }
                SONOM { $expacc = '4350000'; $description = $aObj.desc }
                SIGARA { $expacc = '3750000'; $description = $aObj.desc }
                SIGC { $expacc = '4350000'; $description = $aObj.desc }
                SUPA { $expacc = '4150000'; $description = $aObj.desc }
                TLK { $expacc = '4600000'; $description = $aObj.desc }
                TLOCK { $expacc = '4350000'; $description = $aObj.desc }
                TONM { $expacc = '4150000'; $description = $aObj.desc }
                VESC { $expacc = '4350000'; $description = $aObj.desc }
                VONMOT { $expacc = '4150000'; $description = $aObj.desc }
                VIKING { $expacc = '4350000'; $description = $aObj.desc }
                WINK { $expacc = '4050000'; $description = $aObj.desc }
                WOKD { $expacc = '4550000'; $description = $aObj.desc }
                Default {$aObj.Acc = "" }
        
        }
        #Format Pastel batch
        $props = [ordered] @{
                hd    = 'Header'
                f1    = ''
                f2    = ''
                f3    = ''
                acc   = $aObj.acc
                per   = $pastelper
                dte   = $aObj.date
                order = $aObj.invnum
                f4    = "Y"
                f5    = '0'
                f6    = ''
                f7    = ''
                f8    = ''
                f9    = ''
                f10   = ''
                f11   = ''
                f12   = ''
                f13   = ''
                f14   = ''
                f15   = '0'
                f16   = $aObj.date
                f17   = ''
                f18   = ''
                f19   = ''
                f20   = '1'
                f21   = ''
                f22   = ''
                f23   = 'N'
                f24   = ''
                f25   = 'Detail'
                f26   = $vatexamt
                f27   = '1'
                f28   = $vatexamt
                f29   = $aObj.amt
                f30   = ''
                f31   = $vatpercent
                f32   = '0'
                f33   = '0'
                f34   = $expacc
                f35   = $description
                f36   = '6'
                f37   = ''
                f38   = ''
        }
        $objlist = New-Object -TypeName psobject -Property $props 
        $objlist | Select-Object * | Export-Csv -path $outfile1a -NoTypeInformation -Append
}  
#Remove header information so file can be imported into Pastel Accounting.
Get-Content -Path $outfile1a | Select-Object -skip 1 | Set-Content -path $outfile3
#Remove Temp file.
Remove-Item -Path $outfile1a     

