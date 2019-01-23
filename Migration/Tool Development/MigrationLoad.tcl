#**********************************************************************************************************
#
# @File:        MigrationLoad.tcl
#
# @Description: This script is used to migrate the XMLs created from the SAP PDM extract
#		
# @Owner:       WIPRO
#
# @Input:		input - txt file
#
#
#**********************************************************************************************************
# @History
#
# @ Created by Inderajith Murugadasan, Wipro Technoligies, 3-Jan-2019
#
# @ Delivery        | Version | Date         | Modified By               | Description
#
# @ Enovia PLM      | 1.0     | 3-Jan-2019   | Inderajith M, Wipro       | Script creation
#
# @HistoryEnd
#**********************************************************************************************************

tcl;
eval {
			set sScriptPath [pwd]
			cd "$sScriptPath"
			set sLogDir "${sScriptPath}/Logs"
			if {[file isdirectory "$sLogDir"] == 0} {
				file mkdir "$sLogDir"
			}
			set sStartTime [clock format [clock seconds] -format {%h_%d_%Y_at_%H_%M_%S}]
			set sErrorLogFile [open "${sLogDir}/MigrationLoad_Error_${sStartTime}.log" "w"]
			set sSuccessLogFile [open "${sLogDir}/MigrationLoad_Success_${sStartTime}.log" "w"]
			
			puts $sErrorLogFile "start [clock format [clock seconds]]"
			puts $sSuccessLogFile "start [clock format [clock seconds]]"
			
			set xmlfiles [glob *.xml]
			puts "Name - date of last modification"
			foreach f $xmlfiles {
				puts "$f - [clock format [file mtime $f] -format %x]"
				if {file exists $f != 0} {
					set import [catch {mql import bus command} sReturn1]
					if {$import} {
						puts $sErrorLogFile "$f is not imported | $sReturn1"
					} else {
						puts $sSuccessLogFile "$f is imported successfully | $sReturn1"
					}
				}
			}
			
			puts $sErrorLogFile "end [clock format [clock seconds]]"
			puts $sSuccessLogFile "end [clock format [clock seconds]]"
			close $sErrorLogFile
			close $sSuccessLogFile
}