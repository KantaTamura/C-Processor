onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testprocessor/clock
add wave -noupdate /testprocessor/reset
add wave -noupdate -radix hexadecimal /testprocessor/datain
add wave -noupdate -radix hexadecimal /testprocessor/dataout
add wave -noupdate -radix hexadecimal /testprocessor/address
add wave -noupdate /testprocessor/read
add wave -noupdate /testprocessor/write
add wave -noupdate -radix hexadecimal /testprocessor/Processor/path/RegA/q
add wave -noupdate -radix hexadecimal /testprocessor/Processor/path/RegB/q
add wave -noupdate -radix hexadecimal /testprocessor/Processor/path/RegC/q
add wave -noupdate /testprocessor/Processor/path/FC/q
add wave -noupdate /testprocessor/Processor/path/FZ/q
add wave -noupdate -divider {Internal c}
add wave -noupdate /testprocessor/Processor/ctrl/cJCintB
add wave -noupdate /testprocessor/Processor/ctrl/cJCintC
add wave -noupdate /testprocessor/Processor/ctrl/cJCintD
add wave -noupdate /testprocessor/Processor/ctrl/cJCintE
add wave -noupdate /testprocessor/Processor/ctrl/cJCintF
add wave -noupdate -divider {Internal q}
add wave -noupdate /testprocessor/Processor/ctrl/qJCintA
add wave -noupdate /testprocessor/Processor/ctrl/qJCintB
add wave -noupdate /testprocessor/Processor/ctrl/qJCintC
add wave -noupdate /testprocessor/Processor/ctrl/qJCintD
add wave -noupdate /testprocessor/Processor/ctrl/qJCintE
add wave -noupdate /testprocessor/Processor/ctrl/qJCintF
add wave -noupdate -divider {External q}
add wave -noupdate /testprocessor/Processor/ctrl/qJCextA
add wave -noupdate /testprocessor/Processor/ctrl/qJCextB
add wave -noupdate /testprocessor/Processor/ctrl/qJCextC
add wave -noupdate /testprocessor/Processor/ctrl/qJCextD
add wave -noupdate /testprocessor/Processor/ctrl/qJCextE
add wave -noupdate -divider {External c}
add wave -noupdate /testprocessor/Processor/ctrl/cJCextA
add wave -noupdate /testprocessor/Processor/ctrl/cJCextB
add wave -noupdate /testprocessor/Processor/ctrl/cJCextC
add wave -noupdate /testprocessor/Processor/ctrl/cJCextD
add wave -noupdate /testprocessor/Processor/ctrl/cJCextE
add wave -noupdate /testprocessor/Processor/ctrl/cs1
add wave -noupdate /testprocessor/Processor/ctrl/cs2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1366421 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 254
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1265572 ps} {1717571 ps}
