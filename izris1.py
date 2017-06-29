import sys
from PyQt4 import QtGui, QtCore
from subprocess import call

import sys
from PyQt4 import QtGui, QtCore
from subprocess import call

class Window(QtGui.QMainWindow):
	def __init__(self):
		super(Window, self).__init__()
		self.setGeometry(50,50,1000,300)
		self.setWindowTitle("Izris vremena")
		self.setWindowIcon(QtGui.QIcon('logo.jpg'))
		

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
		#btn=QtGui.QPushButton("Exit",self)
		#btn.clicked.connect(self.close_application)

		#btn.resize(100,50)
		#btn.resize(btn.sizeHint())
		#btn.move(100,100)




		btnFolder=QtGui.QPushButton("Izberi &mapo", self)
		btnFolder.clicked.connect(self.search_folder)
		btnFolder.move(200,150)

		btn2=QtGui.QPushButton("&Run",self)
		btn2.clicked.connect(self.run_octave)
		btn2.resize(btn2.sizeHint())
		btn2.move(0,0)
	

		self.checkBox1=QtGui.QCheckBox('&Navor', self)
		self.checkBox1.move(100,25)

		self.checkBox2=QtGui.QCheckBox('&Samodrzni navor', self)
		self.checkBox2.move(100,50)

		self.checkBox3=QtGui.QCheckBox('&Izracun', self)
		self.checkBox3.move(100,75)

		self.checkBox4=QtGui.QCheckBox('I&zris', self)
		self.checkBox4.move(100,100)

		#checkBox1.stateChanged.connect(self.enlarge_window)


	#	self.progress=QtGui.QProgressBar(self)
	#	self.progress.setGeometry(200,80,250,20)

	#	self.btn3=QtGui.QPushButton("Download", self)
	#	self.btn3.move(200,120)
	#	self.btn3,clicked.connect(self.download)

#		self.text=QtGui.QLabel("Ime projekta",self)
#		self.text.move(200,100)
#
#		self.dirName=QtGui.QLabel("",self)
#		self.dirName.move(200,200)

#		self.txtIn=QtGui.QLineEdit(self)
#		self.txtIn.resize(100,25)
#		self.txtIn.move(200,125)
#		self.show()

	#def download(self):
	#	self.completed=0

	#	while self.completed<100:
	#		self.completed += 0.0001
	#		self.progress.setValue(self.completed)

	#def enlarge_window(self, state):
	#	if state==QtCore.Qt.Checked:
	#		self.setGeometry(50,50,1000,600)
	#	else:
	#		self.setGeometry(50,50,500,300)

	def search_folder(self):
		dirs=QtGui.QFileDialog(self)
		dirs.setFileMode(QtGui.QFileDialog.DirectoryOnly)
		ime=str(dirs.getExistingDirectory(self))+"/"
		self.dirName.setText(ime)
		self.dirName.resize(self.dirName.sizeHint())


	def close_application(self):
		sys.exit()

	def run_octave(self):
		ime=self.dirName.text()
		ime_projekta=self.txtIn.text()

		if ime_projekta=="" or ime=="":
			QtGui.QMessageBox.critical(self, "Error", "Ni izbrana mapa, ali pa je nepravilno ime!")
			return
		else:
			pass

		projekt=ime+ime_projekta
		
		call(['mkdir',projekt])

		text_file=open("program.m", "w")

		text_file.write("direktorij='%s'\n"%projekt)

		if self.checkBox1.isChecked():
			text_file.write("navor='y';\n")
		else:
			text_file.write("navor='n';\n")

		if self.checkBox2.isChecked():
			text_file.write("samodrzni_navor='y';\n")
		else:
			text_file.write("samodrzni_navor='n';\n")	

		if self.checkBox3.isChecked():
			text_file.write("izracun='y';\n")
		else:
			text_file.write("izracun='n';\n")
		if self.checkBox4.isChecked():
			text_file.write("izris='y';\n")
		else:
			text_file.write("izris='n';\n")
		
		text_file.close()
		call(["octave-cli", "risanje_motorja.m", "$"])

def run():
	app=QtGui.QApplication(sys.argv)
	GUI=Window()
	sys.exit(app.exec_())

run()