# hypermesh 2021
# 二次开发菜单，运行时创建部位库界面
# 根据各个按钮，调用其他代码

# 变量空间
namespace eval ::bodyGUI {
    variable filepath;
    variable label_width;
    variable button_cloumn 12; 
	variable button_width;
	variable sheet;
	variable set;
	variable type;
	variable types 0;
	variable currentModule;
}
if {[info exists ::bodyGUI::sheet]==0}				{set ::bodyGUI::sheet 0}
if {[info exists ::bodyGUI::currentModule]==0}		{set ::bodyGUI::currentModule 颈椎}
if {[info exists ::bodyGUI::set]==0}		{set ::bodyGUI::set 默认}

set panelWidth [lindex [hm_getpanelarea] 2]
set width [expr {$panelWidth / $::bodyGUI::button_cloumn / 10}]
set ::bodyGUI::button_width $width
set ::bodyGUI::side_width $width
set ::bodyGUI::filepath [file dirname [info script]]
set ::bodyGUI::label_width $::bodyGUI::button_width
set ::bodyGUI::name "部位库"

# 创建按键阵列：函数{位置，列表}
proc create_label_button {loc line} {

	set line_title [lindex $line 0]
	set line_button [lrange $line 1 end]

	label .f.top.$loc.0  -text "$line_title" -width $::bodyGUI::label_width -font {MS 9}  -compound center -height 1 -fg #A00000
	set num [llength $line_button]
	set n_cur 1
	foreach button_data $line_button {
		set name [lindex $button_data 0]
		set prefix [string index $name 0]
		if {$prefix == "_"} {
			set BTstate disabled
		} else {
			set BTstate normal
		}
		set file_command [lindex $button_data 1]
		button .f.top.$loc.$n_cur \
		-text "$name" \
		-command [format "source %s/%s" $::bodyGUI::filepath $file_command]\
		-state $BTstate\
		-background #F0F0F0 \
		-fg #000000 \
		-height 1\
		-width $::bodyGUI::button_width\
		-font {MS 8}
		if {$n_cur==$num} { break }
		set n_cur [expr $n_cur+1]
	}
	set loc [expr $loc+1]
	return $loc
}

proc pushPanel {module} {
	if {$module=="颈椎"} { set ::bodyGUI::sheet 0}
	if {$module=="胸椎"} { set ::bodyGUI::sheet 1}
	if {$module=="腰骶"} { set ::bodyGUI::sheet 2}
	if {$module=="四肢"} { set ::bodyGUI::sheet 3}
	if {$module=="头肩"} { set ::bodyGUI::sheet 4}
	if {$module=="韧带"} { set ::bodyGUI::sheet 5}
	if {$module=="肌肉"} { set ::bodyGUI::sheet 6}
	creatBodyPanel $::bodyGUI::sheet
}

proc setTypes {c} {
	set types 0
	set value [.f.type.$c cget -variable]
	puts $value
}

proc creatBodyPanel {sheet} {
	destroy  .f.top
	frame .f.top
	pack .f.top -side left -fill both
	
	# Entity矩阵
	for { set j 1 } { $j < 12 } { incr j 1 } {
		frame .f.top.$j
		pack .f.top.$j -side left -fill x -anchor nw -padx 0 -pady 0
	}
	
	# 躯干骨格系统
	if {$sheet==0} {
		set col 1
		
		set 	line "C0C1"
		lappend line "{C0-COR} {ImportBody.tcl;importBody $::bodyGUI::set $::bodyGUI::types C0-COR}"
		lappend line "{C0-CAN} {}"
		lappend line "{C0-Facet} {}"
		lappend line "{C1-COR} {}"
		lappend line "{C1-CAN} {}"
		lappend line "{C1-Facet} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "C2"
		lappend line "{C2-COR} {}"
		lappend line "{C2-CAN} {}"
		lappend line "{C2-Facet} {}"
		lappend line "{C2-EndP} {}"
		lappend line "{C2C3-NP} {}"
		lappend line "{C2C3-AF} {}"
		lappend line "{C2C3-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "C3"
		lappend line "{C3-COR} {}"
		lappend line "{C3-CAN} {}"
		lappend line "{C3-Facet} {}"
		lappend line "{C3-EndP} {}"
		lappend line "{C3C4-NP} {}"
		lappend line "{C3C4-AF} {}"
		lappend line "{C3C4-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "C4"
		lappend line "{C4-COR} {}"
		lappend line "{C4-CAN} {}"
		lappend line "{C4-Facet} {}"
		lappend line "{C4-EndP} {}"
		lappend line "{C4C5-NP} {}"
		lappend line "{C4C5-AF} {}"
		lappend line "{C4C5-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "C5"
		lappend line "{C5-COR} {}"
		lappend line "{C5-CAN} {}"
		lappend line "{C5-Facet} {}"
		lappend line "{C5-EndP} {}"
		lappend line "{C5C6-NP} {}"
		lappend line "{C5C6-AF} {}"
		lappend line "{C5C6-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "C6"
		lappend line "{C6-COR} {}"
		lappend line "{C6-CAN} {}"
		lappend line "{C6-Facet} {}"
		lappend line "{C6-EndP} {}"
		lappend line "{C6C7-NP} {}"
		lappend line "{C6C7-AF} {}"
		lappend line "{C6C7-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "C7"
		lappend line "{C7-COR} {}"
		lappend line "{C7-CAN} {}"
		lappend line "{C7-Facet} {}"
		lappend line "{C7-EndP} {}"
		lappend line "{C7T1-NP} {}"
		lappend line "{C7T1-AF} {}"
		lappend line "{C7T1-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "T1"
		lappend line "{T1-COR} {}"
		lappend line "{T1-CAN} {}"
		lappend line "{T1-Facet} {}"
		lappend line "{T1-EndP} {}"
		lappend line "{T1T2-NP} {}"
		lappend line "{T1T2-AF} {}"
		lappend line "{T1T2-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "T2"
		lappend line "{T2-COR} {}"
		lappend line "{T2-CAN} {}"
		lappend line "{T2-Facet} {}"
		lappend line "{T2-EndP} {}"
		lappend line "{T2T3-NP} {}"
		lappend line "{T2T3-AF} {}"
		lappend line "{T2T3-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "韧带"
		lappend line "{横韧带} {}"
		lappend line "{翼状韧带} {}"
		lappend line "{前纵韧带} {}"
		lappend line "{后纵韧带} {}"
		lappend line "{黄韧带} {}"
		lappend line "{棘间韧带} {}"
		lappend line "{关节囊韧带} {}"
		set col [create_label_button $col $line]
		}
	
	# 第二页：胸椎	
	if {$sheet==1} {
		set col 1
		
		set 	line "T3"
		lappend line "{T3-COR} {}"
		lappend line "{T3-CAN} {}"
		lappend line "{T3-Facet} {}"
		lappend line "{T3-EndP} {}"
		lappend line "{T3T4-NP} {}"
		lappend line "{T3T4-AF} {}"
		lappend line "{T3T4-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "T4"
		lappend line "{T4-COR} {}"
		lappend line "{T4-CAN} {}"
		lappend line "{T4-Facet} {}"
		lappend line "{T4-EndP} {}"
		lappend line "{T4T5-NP} {}"
		lappend line "{T4T5-AF} {}"
		lappend line "{T4T5-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "T5"
		lappend line "{T5-COR} {}"
		lappend line "{T5-CAN} {}"
		lappend line "{T5-Facet} {}"
		lappend line "{T5-EndP} {}"
		lappend line "{T5T6-NP} {}"
		lappend line "{T5T6-AF} {}"
		lappend line "{T5T6-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "T6"
		lappend line "{T6-COR} {}"
		lappend line "{T6-CAN} {}"
		lappend line "{T6-Facet} {}"
		lappend line "{T6-EndP} {}"
		lappend line "{T6T7-NP} {}"
		lappend line "{T6T7-AF} {}"
		lappend line "{T6T7-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "T7"
		lappend line "{T7-COR} {}"
		lappend line "{T7-CAN} {}"
		lappend line "{T7-Facet} {}"
		lappend line "{T7-EndP} {}"
		lappend line "{T7T8-NP} {}"
		lappend line "{T7T8-AF} {}"
		lappend line "{T7T8-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "T8"
		lappend line "{T8-COR} {}"
		lappend line "{T8-CAN} {}"
		lappend line "{T8-Facet} {}"
		lappend line "{T8-EndP} {}"
		lappend line "{T8T9-NP} {}"
		lappend line "{T8T9-AF} {}"
		lappend line "{T8T9-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "T9"
		lappend line "{T9-COR} {}"
		lappend line "{T9-CAN} {}"
		lappend line "{T9-Facet} {}"
		lappend line "{T9-EndP} {}"
		lappend line "{T9T10-NP} {}"
		lappend line "{T9T10-AF} {}"
		lappend line "{T9T10-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "T11"
		lappend line "{T10-COR} {}"
		lappend line "{T10-CAN} {}"
		lappend line "{T10-Facet} {}"
		lappend line "{T10-EndP} {}"
		lappend line "{T10T11-NP} {}"
		lappend line "{T10T11-AF} {}"
		lappend line "{T10T11-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "T11"
		lappend line "{T11-COR} {}"
		lappend line "{T11-CAN} {}"
		lappend line "{T11-Facet} {}"
		lappend line "{T11-EndP} {}"
		lappend line "{T11T12-NP} {}"
		lappend line "{T11T12-AF} {}"
		lappend line "{T11T12-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "韧带"
		lappend line "{前纵韧带} {}"
		lappend line "{后纵韧带} {}"
		lappend line "{黄韧带} {}"
		lappend line "{棘间韧带} {}"
		lappend line "{棘上韧带} {}"
		lappend line "{关节囊韧带} {}"
		lappend line "{横间突韧带} {}"
		set col [create_label_button $col $line]
		}
		
	# 第二页：腰骶
	if {$sheet==2} {
		set col 1
		
		set 	line "T12"
		lappend line "{T12-COR} {}"
		lappend line "{T12-CAN} {}"
		lappend line "{T12-Facet} {}"
		lappend line "{T12-EndP} {}"
		lappend line "{T12L1-NP} {}"
		lappend line "{T12L1-AF} {}"
		lappend line "{T12L1-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "L1"
		lappend line "{L1-COR} {}"
		lappend line "{L1-CAN} {}"
		lappend line "{L1-Facet} {}"
		lappend line "{L1-EndP} {}"
		lappend line "{L1L2-NP} {}"
		lappend line "{L1L2-AF} {}"
		lappend line "{L1L2-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "L2"
		lappend line "{L2-COR} {}"
		lappend line "{L2-CAN} {}"
		lappend line "{L2-Facet} {}"
		lappend line "{L2-EndP} {}"
		lappend line "{L2L3-NP} {}"
		lappend line "{L2L3-AF} {}"
		lappend line "{L2L3-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "L3"
		lappend line "{L3-COR} {}"
		lappend line "{L3-CAN} {}"
		lappend line "{L3-Facet} {}"
		lappend line "{L3-EndP} {}"
		lappend line "{L3L4-NP} {}"
		lappend line "{L3L4-AF} {}"
		lappend line "{L3L4-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "L4"
		lappend line "{L4-COR} {}"
		lappend line "{L4-CAN} {}"
		lappend line "{L4-Facet} {}"
		lappend line "{L4-EndP} {}"
		lappend line "{L4L5-NP} {}"
		lappend line "{L4L5-AF} {}"
		lappend line "{L4L5-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "L5"
		lappend line "{L5-COR} {}"
		lappend line "{L5-CAN} {}"
		lappend line "{L5-Facet} {}"
		lappend line "{L5-EndP} {}"
		lappend line "{L5S1-NP} {}"
		lappend line "{L5S1-AF} {}"
		lappend line "{L5S1-Fabers} {}"
		lappend line "{以上全部} {}"
		set col [create_label_button $col $line]
		
		set 	line "韧带"
		lappend line "{前纵韧带} {}"
		lappend line "{后纵韧带} {}"
		lappend line "{黄韧带} {}"
		lappend line "{棘间韧带} {}"
		lappend line "{棘上韧带} {}"
		lappend line "{关节囊韧带} {}"
		lappend line "{横间突韧带} {}"
		set col [create_label_button $col $line]
		
		set		line "骶骨"
		lappend	line "{S-COR} {}"
		lappend	line "{S-CAN} {}"
		lappend	line "{S-EndP} {}"
		set col [create_label_button $col $line]
		
		set 	line "骨盆"
		lappend line "{Pevlis-Cor} {}"
		lappend line "{Pevlis-Can} {}"
		lappend line "{Pevlis-Car} {}"
		lappend line "{Sym-pelvis} {}"
		set col [create_label_button $col $line]
		
		set 	line "骨盆韧带"
		lappend line "{骶棘韧带} {}"
		lappend line "{骶结节韧带} {}"
		lappend line "{耻骨前韧带} {}"
		lappend line "{骶髂韧带} {}"
		lappend line "{髂腹股沟韧带} {}"
		set col [create_label_button $col $line]
	}
		
	# 第三页：四肢	
	if {$sheet==3} {
		set col 1
		set 	line "上肢"
		set col [create_label_button $col $line]
		
		set 	line "手腕"
		set col [create_label_button $col $line]
		
		set 	line "手部"
		set col [create_label_button $col $line]
		
		set		line "上肢韧带"
		set col [create_label_button $col $line]
		
		set 	line "下肢"
		set col [create_label_button $col $line]
		
		set 	line "坏关节"
		set col [create_label_button $col $line]
		
		set 	line "下肢韧带"
		set col [create_label_button $col $line]
		
		set 	line "足部"
		set col [create_label_button $col $line]

		set 	line "足部韧带"
		set col [create_label_button $col $line]
		}
		
	# 第四页：头与口腔	
	if {$sheet==4} {
		set 	line "头部"
		create_label_button 1 $line
		
		set 	line "口腔"
		create_label_button 2 $line
		
		set 	line "颈椎"
		create_label_button 3 $line
		
		set 	line "胸椎"
		create_label_button 4 $line
		
		set 	line "腰椎"
		create_label_button 5 $line
		
		set 	line "骨盆"
		create_label_button 6 $line
		
		set 	line "四肢"
		create_label_button 7 $line
		
		set 	line "手"
		create_label_button 8 $line
		
		set 	line "足"
		create_label_button 9 $line
		}
		
	# pack小部件设置
	for { set hloc 0 } { $hloc < 10 } { incr hloc 1 } {
		for { set vloc 0 } { $vloc < 15 } { incr vloc 1 } {
			catch {
				pack .f.top.$vloc.$hloc -side top -anchor nw -padx 0 -pady 0
			}
		}
	}
}
	
# 初始设置
destroy .f
frame .f
frame .f.side
pack .f.side -side left -fill both

frame .f.type
pack .f.type -side right -fill both

frame .f.set
pack .f.set -side right -fill both

set i 0
foreach module {颈椎 胸椎 腰骶 四肢 头肩 韧带 肌肉} {
    pack [radiobutton .f.side.$i -text $module -variable ::bodyGUI::currentModule \
        -value $module \
		-height 1\
		-width $::bodyGUI::button_width\
		-font {MS 12}\
        -command "pushPanel $module" ]
	incr i
}

set j 1
label .f.set.0 -text "套装" -width $::bodyGUI::side_width -font {MS 12}  -compound center -height 1 -fg #000000
pack .f.set.0 -side top
foreach set {默认 女性 儿童 病例-1 病例-2} {
	pack [radiobutton .f.set.$j -text $set -variable ::bodyGUI::set \
        -value $set \
		-height 1\
		-width $::bodyGUI::button_width\
		-font {MS 12} ]
	incr j
}

set k 1
label .f.type.0 -text "导入格式" -width $::bodyGUI::side_width -font {MS 12}  -compound center -height 1 -fg #000000
pack .f.type.0 -side top
foreach type {2D网格 3D网格 几何 面片} {
	pack [checkbutton .f.type.$k -text $type\
		-font {MS 10}\
		-height 1\
		-width $::bodyGUI::button_width\
		-offvalue 0\
		-onvalue 1\
		-command "setTypes $k"]
	incr k
}

pushPanel ::bodyGUI::currentModule

# -----------------------
# 界面Panel推送
hm_framework addpanel .f $::bodyGUI::name
hm_framework drawpanel .f