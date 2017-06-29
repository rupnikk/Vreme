import sys
from PyQt4 import QtGui, QtCore
from subprocess import call



w=600
h=300
x0=30
y0=40
qbtnsize=[50,25]
foldsize=[100,25]
runsize=[50,25]
combopos=[x0,y0]



class Window(QtGui.QMainWindow):
	def __init__(self):
		super(Window, self).__init__()
		self.setGeometry(0,0,w,h)
		self.setWindowTitle("Izris vremena")
		self.setWindowIcon(QtGui.QIcon('logo.png'))

		extractAction=QtGui.QAction("Exit", self)
		extractAction.setShortcut("Ctrl+Q")
		extractAction.setStatusTip('Leave the app')
		extractAction.triggered.connect(self.close_application)

		self.statusBar()

		mainMenu=self.menuBar()
		fileMenu=mainMenu.addMenu('&File')
		fileMenu.addAction(extractAction)

		self.home()

	def home(self):
		self.comboBox=QtGui.QComboBox(self)
		self.comboBox.addItem("Dan")
		self.comboBox.addItem("Teden")
		self.comboBox.addItem("Mesec")
		self.comboBox.addItem("Klimogram")

		self.comboBox.move(combopos[0],combopos[1])
		comw=self.comboBox.width()
		comh=self.comboBox.height()


		self.check1=QtGui.QCheckBox("&Temperatura",self)
		self.check1.move(x0,y0+comh+5)
		self.check1.resize(self.check1.sizeHint())
		self.check1.toggle()

		checkh=self.check1.height()

		self.check2=QtGui.QCheckBox("&Padavine",self)
		self.check2.move(x0,y0+comh+5+1*(checkh))
		self.check2.resize(self.check2.sizeHint())
		self.check2.toggle()

		self.check3=QtGui.QCheckBox("&Vsota padavin",self)
		self.check3.move(x0,y0+comh+5+2*(checkh))
		self.check3.resize(self.check3.sizeHint())
		self.check3.toggle()

		self.check4=QtGui.QCheckBox("V&laga",self)
		self.check4.move(x0,y0+comh+5+3*(checkh))
		self.check4.resize(self.check4.sizeHint())
		self.check4.toggle()

		self.check5=QtGui.QCheckBox("&Snezna oddeja",self)
		self.check5.move(x0,y0+comh+5+4*(checkh))
		self.check5.resize(self.check5.sizeHint())
		self.check5.toggle()

		checkw=[self.check1.width(),self.check2.width(),self.check3.width(),\
		self.check4.width(),self.check5.width(),]

		checkw_max=max(checkw)


		calpos=[combopos[0]+checkw_max+10,combopos[1]]
		self.calend=QtGui.QCalendarWidget(self)
		self.calend.setGridVisible(True)
		self.calend.setFirstDayOfWeek(QtCore.Qt.Monday)
		self.calend.move(calpos[0],calpos[1])
		self.calend.resize(self.calend.sizeHint())
		#calend.clicked[QtCore.QDate].connect(self.select_date)
		calw=self.calend.width()
		calh=self.calend.height()


		#btnFolder=QtGui.QPushButton("Izberi &mapo", self)
		#btnFolder.clicked.connect(self.search_folder)
		#btnFolder.resize(foldsize[0],foldsize[1])
		#btnFolder.move(x0,calpos[1]+calh)

		#self.dirName=QtGui.QLabel("",self)
		#self.dirName.move(x0,calpos[1]+calh+foldsize[1])

		btnrun=QtGui.QPushButton("&Run",self)
		btnrun.clicked.connect(self.run_octave)
		btnrun.resize(runsize[0],runsize[1])
		btnrun.move(calpos[0]+calw-qbtnsize[0],y0+calh+1)


		btn=QtGui.QPushButton("&Exit",self)
		btn.clicked.connect(self.close_application)
		btn.resize(qbtnsize[0],qbtnsize[1])
		btn.move(calpos[0]+calw-qbtnsize[0],y0+calh+runsize[1]+2)

		self.setGeometry(0,0,calpos[0]+calw+x0,2*y0+calh+runsize[1]+qbtnsize[1]+2)

		self.show()

	def search_folder(self):
		dirs=QtGui.QFileDialog(self)
		dirs.setFileMode(QtGui.QFileDialog.DirectoryOnly)
		ime=str(dirs.getExistingDirectory(self))+"/"
		self.dirName.setText(ime)
		self.dirName.resize(self.dirName.sizeHint())

	def run_octave(self):
		self.clear()
		self.save()

		call("octave-cli program.m", shell=True)
		self.open()

	def save(self):
		datum=self.calend.selectedDate()
		
		dan=datum.day()
		mesec=datum.month()
		leto=datum.year()
		obdobje=str(self.comboBox.currentText()).lower()

		if self.check1.isChecked():
			temperatura="temperatura"
		else:
			temperatura=""

		if self.check2.isChecked():
			dez="dez"
		else:
			dez=""

		if self.check3.isChecked():
			dez_vsota="dez_vsota"
		else:
			dez_vsota=""

		if self.check4.isChecked():
			vlaga="vlaga"
		else:
			vlaga=""

		if self.check5.isChecked():
			sneg="sneg"
		else:
			sneg=""


		mapa='/home/urban/Documents/Projekti/Vreme/'
		datoteka='nastavitve_program.m'


 
		text_file=open(mapa+datoteka, "w")

		text_file.write("dan=%d;\n"%dan)
		text_file.write("mesec=%d;\n"%mesec)
		text_file.write("leto=%d;\n"%leto)
		text_file.write("obdobje='%s';\n"%obdobje)
		text_file.write("izris=[{'%s', '%s','%s','%s','%s'}];\n"%(temperatura,dez,dez_vsota,vlaga,sneg));


		text_file.close()

	def open(self):
		call("eog temperatura.jpg &", shell=True)
		call("eog dez.jpg &", shell=True)
		call("eog vlaga.jpg &", shell=True)
		call("eog sneg.jpg &", shell=True)
		call("eog klimo.jpg &", shell=True)

	def clear(self):
		call(["rm","-f","temperatura.jpg"])
		call(["rm","-f","dez.jpg"])
		call(["rm","-f","sneg.jpg"])
		call(["rm","-f","vlaga.jpg"])
		call(["rm","-f","klimo.jpg"])



	def close_application(self):
		self.clear()
		sys.exit()

def run():
	app=QtGui.QApplication(sys.argv)
	GUI=Window()
	sys.exit(app.exec_())

run()