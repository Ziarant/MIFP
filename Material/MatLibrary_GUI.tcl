# hypermesh 2021
# 二次开发菜单，运行时创建材料库界面
# 根据各个按钮，调用其他代码

# 变量空间
namespace eval ::matGUI {
    variable filepath;
    variable label_width;
    variable button_cloumn 12; 
	variable button_width;
	variable sheet
	variable currentModule
}
if {[info exists ::matGUI::sheet]==0}		{set ::matGUI::sheet 0}
if {[info exists ::matGUI::currentModule]==0}		{set ::matGUI::currentModule 线弹性体}

set width [expr {$panelWidth / $::matGUI::button_cloumn / 10 + 1}]
set ::matGUI::button_width $width
set ::matGUI::filepath [file dirname [info script]]
set ::matGUI::label_width $::matGUI::button_width
set ::matGUI::name "材料库"

# 创建按键阵列：函数{位置，列表}
proc create_label_button {loc line} {

	set line_title [lindex $line 0]
	set line_button [lrange $line 1 end]

	label .f.top.$loc.0  -text "$line_title" -width $::matGUI::label_width -font {MS 10}  -compound center -height 1 -fg #A00000
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
		-command [format "source %s/%s" $::matGUI::filepath $file_command]\
		-state $BTstate\
		-background #F0F0F0 \
		-fg #000000 \
		-height 1\
		-width $::matGUI::button_width\
		-font {MS 9}\
		-relief groove
		if {$n_cur==$num} { break }
		set n_cur [expr $n_cur+1]
	}
	set loc [expr $loc+1]
	return $loc
}

proc pushPanel {module} {
	if {$module=="线弹性体"} { set ::matGUI::sheet 0}
	if {$module=="弹塑性体"} { set ::matGUI::sheet 1}
	if {$module=="超弹性体"} { set ::matGUI::sheet 2}
	if {$module=="多孔材料"} { set ::matGUI::sheet 3}
	if {$module=="其他材料"} { set ::matGUI::sheet 4}
	creatMatPanel $::matGUI::sheet
}

proc creatMatPanel {sheet} {
	
	destroy  .f.top
	frame .f.top
	pack .f.top -side top -fill both

	# 材料矩阵
	for { set j 0 } { $j < 13 } { incr j 1 } {
		frame .f.top.$j
		pack .f.top.$j -side left -fill x -anchor nw -padx 0 -pady 0
	}
	
	# 第一页：线弹性体
	if {$sheet==0} {
		set col 0
	
		set 	line "实体"
		lappend line "{默认(空白)} {creatMaterial.tcl;creatElasticMat Defult}"
		lappend line "{Peek(572M)} {creatMaterial.tcl;creatElasticMat Peek}"
		lappend line "{钛(114G)} {creatMaterial.tcl;creatElasticMat Ti}"
		lappend line "{不锈钢(220G)} {creatMaterial.tcl;creatElasticMat Steel}"
		lappend line "{钴铬钼(241G)} {creatMaterial.tcl;creatElasticMat CoCrMo}"
		lappend line "{15级SawBone} {creatMaterial.tcl;creatElasticMat SawBone15}"
		set col [create_label_button $col $line]

		set 	line "颈椎"
		lappend line "{皮质骨} {creatMaterial.tcl;creatElasticMat C_Cor}"
		lappend line "{松质骨} {creatMaterial.tcl;creatElasticMat C_Can}"
		lappend line "{终板} {creatMaterial.tcl;creatElasticMat C_EndP}"
		lappend line "{后部} {creatMaterial.tcl;creatElasticMat C_Post}"
		lappend line "{纤维环基质} {creatMaterial.tcl;creatElasticMat C_AF}"
		lappend line "{髓核} {creatMaterial.tcl;creatElasticMat C_NP}"
		lappend line "{关节囊} {creatMaterial.tcl;creatElasticMat C_FACET}"
		set col [create_label_button $col $line]
		
		set 	line "颈椎韧带"
		lappend line "{横韧带(4)} {creatMaterial.tcl;creat1DElasticMat C_TL}"
		lappend line "{翼状韧带(8)} {creatMaterial.tcl;creat1DElasticMat C_AL}"
		lappend line "{前纵韧带(10)} {creatMaterial.tcl;creat1DElasticMat C_ALL}"
		lappend line "{后纵韧带(10)} {creatMaterial.tcl;creat1DElasticMat C_PLL}"
		lappend line "{黄韧带(6)} {creatMaterial.tcl;creat1DElasticMat C_LF}"
		lappend line "{棘间韧带(10)} {creatMaterial.tcl;creat1DElasticMat C_ISL}"
		lappend line "{关节囊韧带(10)} {creatMaterial.tcl;creat1DElasticMat C_JCL}"
		set col [create_label_button $col $line]
		
		# set		line "胸椎"
		# lappend line "{皮质骨} {creatMaterial.tcl;creatElasticMat T_Cor}"
		# lappend line "{松质骨} {creatMaterial.tcl;creatElasticMat T_Can}"
		# lappend line "{终板} {creatMaterial.tcl;creatElasticMat T_EndP}"
		# lappend line "{后部} {creatMaterial.tcl;creatElasticMat T_Post}"
		# lappend line "{纤维环基质} {creatMaterial.tcl;creatElasticMat T_AF}"
		# lappend line "{髓核} {creatMaterial.tcl;creatElasticMat T_NP}"
		# lappend line "{关节囊} {creatMaterial.tcl;creatElasticMat T_FACET}"
		# set col [create_label_button $col $line]
		
		set		line "胸腰椎"
		lappend line "{皮质骨} {creatMaterial.tcl;creatElasticMat L_Cor}"
		lappend line "{松质骨} {creatMaterial.tcl;creatElasticMat L_Can}"
		lappend line "{终板} {creatMaterial.tcl;creatElasticMat L_EndP}"
		lappend line "{后部} {creatMaterial.tcl;creatElasticMat L_Post}"
		lappend line "{纤维环基质} {creatMaterial.tcl;creatElasticMat L_AF}"
		lappend line "{髓核} {creatMaterial.tcl;creatElasticMat L_NP}"
		lappend line "{关节囊} {creatMaterial.tcl;creatElasticMat L_FACET}"
		set col [create_label_button $col $line]
		
		set		line "胸腰椎韧带"
		lappend line "{前纵韧带(5)} {creatMaterial.tcl;creat1DElasticMat L_ALL}"
		lappend line "{后纵韧带(5)} {creatMaterial.tcl;creat1DElasticMat L_PLL}"
		lappend line "{黄韧带(4)} {creatMaterial.tcl;creat1DElasticMat L_LF}"
		lappend line "{棘间韧带(10)} {creatMaterial.tcl;creat1DElasticMat L_ISL}"
		lappend line "{棘上韧带(10)} {creatMaterial.tcl;creat1DElasticMat L_SSL}"
		lappend line "{关节囊韧带(15)} {creatMaterial.tcl;creat1DElasticMat L_JCL}"
		lappend line "{横间突韧带(15)} {creatMaterial.tcl;creat1DElasticMat L_ITL}"
		set col [create_label_button $col $line]
		
		set		line "头部"
		set col [create_label_button $col $line]
		
		set		line "四肢"
		lappend line "{髓腔} {creatMaterial.tcl;creatElasticMat Marrow}"
		set col [create_label_button $col $line]
		
		set		line "手"
		set col [create_label_button $col $line]
		
		set		line "足"
		set col [create_label_button $col $line]
		
		set		line "其他"
		lappend line "{纤维环纤维} {creatMaterial.tcl;creat1DElasticMat Fibers}"
		set col [create_label_button $col $line]
	}

	# 第二页：弹塑性体
	if {$sheet==1} {
		set col 0
		
		set		line "实体"
		lappend line "{超高聚乙烯} {creatMaterial.tcl;creatPlasticMat Ti-6Al-4V}"
		lappend line "{钛(114G)} {creatMaterial.tcl;creatPlasticMat Ti-6Al-4V}"
		lappend line "{不锈钢(220G)} {creatMaterial.tcl;creatPlasticMat Steel}"
		lappend line "{钴铬钼(241G)} {creatMaterial.tcl;creatPlasticMat CoCrMo}"
		set col [create_label_button $col $line]
	
		set		line "多孔材料"
		lappend line "{钻石型} {creatMaterial.tcl;creatPlasticMat Porous_Diamond}"
		lappend line "{十二面体} {creatMaterial.tcl;creatPlasticMat Porous_12hedron}"
		lappend line "{体心立方} {creatMaterial.tcl;creatPlasticMat Porous_BodyCenter}"
		set col [create_label_button $col $line]
	}

	# 第三页：超弹性体
	if {$sheet==2} {
		set col 0
		
		set		line "实体"
		set col [create_label_button $col $line]
	}
	
	# 第四页：多孔材料
	if {$sheet==3} {
		set col 0
		
		set		line "实体"
		set col [create_label_button $col $line]
	}
	
	# 第五页：其他材料
	if {$sheet==4} {
		set col 0
		
		set		line "骨愈合(Soil)"
		lappend line "{皮质骨} {creatMaterial.tcl;creatSoilMat Heal_Cor}"
		lappend line "{髓腔} {creatMaterial.tcl;creatSoilMat Heal_Marrow}"
		lappend line "{生长迭代区} {creatMaterial.tcl;creatSoilMat Heal_Granulation}"
		lappend line "{纤维化骨} {creatMaterial.tcl;creatSoilMat Heal_Fibrous}"
		lappend line "{分化软骨} {creatMaterial.tcl;creatSoilMat Heal_Car}"
		lappend line "{未成熟骨} {creatMaterial.tcl;creatSoilMat Heal_Immature}"
		lappend line "{成熟骨} {creatMaterial.tcl;creatSoilMat Heal_Mature}"
		set col [create_label_button $col $line]
	}
	
	# pack小部件设置
	for { set hloc 0 } { $hloc < 12 } { incr hloc 1 } {
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

set i 0
foreach module {线弹性体 弹塑性体 超弹性体 多孔材料 其他材料} {
    pack [radiobutton .f.side.$i -text $module -variable ::matGUI::currentModule \
        -value $module \
		-height 1\
		-width $::matGUI::button_width\
		-font {MS 12}\
        -command "pushPanel $module" ]
	incr i
}
pushPanel ::matGUI::currentModule

# -----------------------
# 界面Panel推送
hm_framework addpanel .f $::matGUI::name
hm_framework drawpanel .f