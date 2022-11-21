onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testcontrol/clock
add wave -noupdate /testcontrol/reset
add wave -noupdate -radix hexadecimal /testcontrol/IRout
add wave -noupdate /testcontrol/ZeroF
add wave -noupdate /testcontrol/CarryF
add wave -noupdate -divider External
add wave -noupdate /testcontrol/control/JCextA/q
add wave -noupdate /testcontrol/control/JCextB/q
add wave -noupdate /testcontrol/control/JCextC/q
add wave -noupdate /testcontrol/control/JCextD/q
add wave -noupdate /testcontrol/control/JCextE/q
add wave -noupdate -divider Internal
add wave -noupdate /testcontrol/control/JCintA/q
add wave -noupdate /testcontrol/control/JCintB/q
add wave -noupdate /testcontrol/control/JCintC/q
add wave -noupdate /testcontrol/control/JCintD/q
add wave -noupdate /testcontrol/control/JCintE/q
add wave -noupdate /testcontrol/control/JCintF/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 205
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
WaveRestoreZoom {0 ps} {413212 ps}
