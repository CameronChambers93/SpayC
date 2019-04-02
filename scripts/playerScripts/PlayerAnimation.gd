#Written by Michael LaBarbera

#Dict of directions
var currentAnim = null
var currentTime = 0
var index = 0

var FPSTar = 15
var deltaCut = 1.0 / FPSTar

# Key "Verb_Aim_Dir" Verbs: S = Standing, M = Moving, J = Jumping, T = Turn from Direction; 
#					 Aim: F = Foreward, D = Down Diagonal, U = Up Diagonal, W = Up, S = Down, I = Idle, B = Beginning
#					 Dir: R = Right, L = Left

var _AimDirection = {"Up": 0, "Up_Diag": 1, "Foreward": 2, "Down_Diag": 3, "Down": 4}
var _StateToKey = {"stand": "S", "move": "M", "jump": "J"}
var _AimToKey = {0: "W", 1: "U", 2: "F", 3: "D", 4: "S"}
var _DirToKey = {1: "R", -1: "L"}
var _TransToKey = {false: "N", true: "T"}

var _KeyToState = {"S": "stand", "M": "move", "J": "jump"}
var _KeyToAim = {"W": 0, "U": 1, "F": 2, "D": 3, "S": 4}
var _KeyToDir = {"R": 1, "L": -1}
var _KeyToTrans = {"N": false, "T": true}

# List meanings [First Frame, Frame Count, Increment counter (1 if null), Next Animation to play after completion]
var _Anim = {"S_F_R_N": [0, 1, 1, null],
			 "S_D_R_N": [13, 1, 1, null],
			 "S_U_R_N": [26, 1, 1, null],
			 "S_W_R_N": [39, 1, 1, null],
			 "S_F_L_N": [52, 1, 1, null],
			 "S_D_L_N": [65, 1, 1, null],
			 "S_U_L_N": [78, 1, 1, null],
			 "S_W_L_N": [91, 1, 1, null],
			 "M_F_R_N": [1, 12, 1, null],
			 "M_D_R_N": [14, 12, 1, null],
			 "M_U_R_N": [27, 12, 1, null],
			 "M_I_R_N": [40, 12, 1, null],
			 "M_F_L_N": [53, 12, 1, null],
			 "M_D_L_N": [66, 12, 1, null],
			 "M_U_L_N": [79, 12, 1, null],
			 "M_I_L_N": [92, 12, 1, null],
			 "J_F_R_T": [107, 3, 1, "J_F_R_N"],
			 "J_F_L_T": [120, 3, 1, "J_F_L_N"],
			 "J_F_R_N": [133, 1, 1, null],
			 "J_W_R_N": [134, 1, 1, null],
			 "J_S_R_N": [135, 1, 1, null],
			 "J_U_R_N": [136, 1, 1, null],
			 "J_D_R_N": [137, 1, 1, null],
			 "J_F_L_N": [138, 1, 1, null],
			 "J_W_L_N": [139, 1, 1, null],
			 "J_S_L_N": [140, 1, 1, null],
			 "J_U_L_N": [141, 1, 1, null],
			 "J_D_L_N": [142, 1, 1, null],
			 "M_U_R_T": [106, 3, -1, "M_U_L_N"],
			 "M_F_R_T": [119, 3, -1, "M_F_L_N"],
			 "M_D_R_T": [132, 3, -1, "M_D_L_N"],
			 "J_F_R_T": [145, 3, -1, "J_F_L_N"],
			 "M_U_L_T": [104, 3, 1, "M_U_R_N"],
			 "M_F_L_T": [117, 3, 1, "M_F_R_N"],
			 "M_D_L_T": [130, 3, 1, "M_D_R_N"],
			 "J_F_L_T": [143, 3, 1, "J_F_R_N"],} 

func default(state, aim, direction, transitionLock):
	currentAnim = genAnim(state, aim, direction, transitionLock)
	index = _Anim[currentAnim][0]

func getState():
	return _KeyToState[currentAnim.split("_")[0]]

func setState(S):
	currentAnim = genAnim(S, getAim(), getDir(), getTrans())

func getAim():
	return _KeyToAim[currentAnim.split("_")[1]]

func setAim(A):
	if !(index in range(_Anim[currentAnim][0], _Anim[currentAnim][0] + _Anim[currentAnim][1]*_Anim[currentAnim][2], _Anim[currentAnim][2])):
		index = _Anim[currentAnim][0]
	var indexStep = index - _Anim[currentAnim][0] 
	currentAnim = genAnim(getState(), A, getDir(), getTrans())
	index = _Anim[currentAnim][0] + indexStep
	
func getDir():
	return _KeyToDir[currentAnim.split("_")[2]]

func setDir(D):
	currentAnim = genAnim(getState(), getAim(), D, getTrans())

func getTrans():
	return _KeyToTrans[currentAnim.split("_")[3]]

func setTrans(T):
	currentAnim = genAnim(getState(), getAim(), getDir(), T)

func genAnim(S = getState(), A = getAim(), D = getDir(), T = getTrans()):
	if(T and S == "stand"):
		setState("move")
		S = "move"
	var out = ""
	out = _StateToKey[S] + "_" + _AimToKey[A] 
	out += "_" + _DirToKey[D]+ "_" + _TransToKey[T]
	return out

func stopMoving():
	if(getState() == "move" and !getTrans()):
		setState("stand")

func move(D):
	#print(getDir())
	if(D == getDir()):
		if(getState() == "stand"):
			setState("move")
	else:
		turn()
		

func jump():
	pass
	
func land():
	pass

func turn():
	if(!getTrans()):
		if(getState() == "jump"):
			 setAim(2) ###########WARNING May cause problems
		setTrans(true)
		
func finish():
	if(getTrans()):
		setTrans(false)
		setDir(-getDir())
	index = _Anim[currentAnim][0]
	
	
func update(delta):
	if !(index in range(_Anim[currentAnim][0], _Anim[currentAnim][0] + _Anim[currentAnim][1]*_Anim[currentAnim][2], _Anim[currentAnim][2])):
		index = _Anim[currentAnim][0]
	else:
		if(_Anim[currentAnim][1] != 1):
			currentTime += delta
			if(currentTime >= deltaCut):
				currentTime -= deltaCut
				index += _Anim[currentAnim][2]
			
			if(abs(_Anim[currentAnim][0] - index)  >= _Anim[currentAnim][1]): 
				finish()
	if(get_frame() != index):
		#print("Current Anim: ", currentAnim, " Index: ", index)
		set_frame(index)