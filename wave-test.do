onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testprocessor/clock
add wave -noupdate /testprocessor/reset
add wave -noupdate -radix hexadecimal /testprocessor/address
add wave -noupdate -radix hexadecimal /testprocessor/datain
add wave -noupdate -radix hexadecimal /testprocessor/dataout
add wave -noupdate -divider Flag
add wave -noupdate /testprocessor/Processor/ZeroF
add wave -noupdate /testprocessor/Processor/CarryF
add wave -noupdate -divider Reg
add wave -noupdate -radix hexadecimal /testprocessor/Processor/path/RegA/q
add wave -noupdate -radix hexadecimal /testprocessor/Processor/path/RegB/q
add wave -noupdate -radix hexadecimal /testprocessor/Processor/path/RegC/q
add wave -noupdate -divider {IX or MB}
add wave -noupdate -radix hexadecimal /testprocessor/Processor/path/IX/q
add wave -noupdate -radix hexadecimal /testprocessor/Processor/path/MB/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {28406488 ps} 0}
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
WaveRestoreZoom {28376851 ps} {29201659 ps}
