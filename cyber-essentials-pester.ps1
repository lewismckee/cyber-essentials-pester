#CyberEssentialsPesterTest


#1. Firewall and gateway
# Firewall Windows Activated
Describe "Windows Firewall State"{

    Context "Check which firewall profiles are enabled"{
        $TestCases = @()
    }
    it "Domain Profile Status" -TestCases $TestCases {
        $fw = netsh advfirewall show domainprofile state
        $fw -like '*State*' | should be 'State                                 ON'
    }
    it "Private Profile Status" -TestCases $TestCases {
        $fw = netsh advfirewall show privateprofile state
        $fw -like '*State*' | should be 'State                                 ON'
    }
    it "Public Profile Status" -TestCases $TestCases {
        $fw = netsh advfirewall show publicprofile state
        $fw -like '*State*' | should be 'State                                 ON'
    }
}

#Test for Categories of blocked sites
Describe "DNS Filter Test"{
    context "Check which DNS filters are applied"{
        $TestCases = @()
    }


foreach ($line in $unallowedsites){

    it "check Gambling $line"-TestCases $TestCases{
        $qry = nslookup.exe $line
        $qry = $qry | select -Last 2
        $qry -like '*Address:*' | should be "Address:  $DNSFILTERADDRESS"
    }
}
    }


#Get Disk Encryption Status
Describe " This is a test"{
    Context "Scoping my tests" {
        $Drives = (Get-PSDrive -PSProvider FileSystem | Where-Object {$_.Name.Length -eq 1}).Name
        $TestCases = @()
        $Drives.ForEach{
        $TestCases += @{'DriveLetter' = "$($_):"}
    }

        It "Checking if bitlocker is fully encrypted on Drive <DriveLetter>" -TestCases $Testcases {
            Param($DriveLetter)
            $a = manage-bde -status $DriveLetter
            $a -like '*Fully Encrypted*' | Should Be '    Conversion Status:    Fully Encrypted'
        }
        it "Checking if bitlocker o Drive <DriveLetter> is 100% complete encrypting" -TestCases $Testcases{
            Param($DriveLetter)
            $a = manage-bde -status $DriveLetter
            $a -like "*100.0%*" | Should be "    Percentage Encrypted: 100.0%"
            
        }
    }
}
