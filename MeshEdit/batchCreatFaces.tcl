*createmarkpanel comps 1 "select the comps"
set compsId [hm_getmark comps 1]
foreach compId $compsId {
	set compName [hm_entityinfo name comps $compId]
	*createmark components 1 $compName
	*findfaces components 1
	set newCompId [hm_entityinfo maxid comps]
	set newCompName [hm_entityinfo name comps $newCompId]
	*createmark elements 1 "by collector id" $newCompId
	*movemark elements 1 $compName
	*createmark components 1 $newCompName
	*deletemark components 1
 } 