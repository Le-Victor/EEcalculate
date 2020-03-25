# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'mainWindow.ui'
#
# Created by: PyQt5 UI code generator 5.11.3
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import *
from subWindow import *

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(800, 600)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        MainWindow.setWindowTitle("MainWindow")
        MainWindow.setCentralWidget(self.centralwidget)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

        self.centralwidget.setObjectName("centralwidget")


        # self.comboBox = QtWidgets.QComboBox(self.centralwidget)
        # self.comboBox.setGeometry(QtCore.QRect(100, 250, 300, 30))
        # self.comboBox.setObjectName("comboBox")
        # self.comboBox.addItem('方法一')
        # self.comboBox.addItem('方法二')
        # self.comboBox.addItem('方法三')
        # self.comboBox.addItem('方法四')
        # self.comboBox.addItem('方法五')
        # self.comboBox.addItem('方法六')
        # self.comboBox.addItem('方法七')
        # self.comboBox.addItem('方法八')

        self.pushButton1 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton1.setGeometry(QtCore.QRect(200, 200, 100, 30))
        self.pushButton1.setObjectName("pushButton1")
        self.pushButton1.setText("计算1")
        self.pushButton1.released.connect(self.button_released)

        self.pushButton2 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton2.setGeometry(QtCore.QRect(200, 250, 100, 30))
        self.pushButton2.setObjectName("pushButton2")
        self.pushButton2.setText("计算2")
        self.pushButton2.released.connect(self.button_released)

        self.pushButton3 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton3.setGeometry(QtCore.QRect(200, 300, 100, 30))
        self.pushButton3.setObjectName("pushButton3")
        self.pushButton3.setText("计算3")
        self.pushButton3.released.connect(self.button_released)

        self.pushButton4 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton4.setGeometry(QtCore.QRect(200, 350, 100, 30))
        self.pushButton4.setObjectName("pushButton4")
        self.pushButton4.setText("计算4")
        self.pushButton4.released.connect(self.button_released)

        self.pushButton5 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton5.setGeometry(QtCore.QRect(500, 200, 100, 30))
        self.pushButton5.setObjectName("pushButton5")
        self.pushButton5.setText("计算5")
        self.pushButton5.released.connect(self.button_released)

        self.pushButton6 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton6.setGeometry(QtCore.QRect(500, 250, 100, 30))
        self.pushButton6.setObjectName("pushButton6")
        self.pushButton6.setText("计算6")
        self.pushButton6.released.connect(self.button_released)

        self.pushButton7 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton7.setGeometry(QtCore.QRect(500, 300, 100, 30))
        self.pushButton7.setObjectName("pushButton7")
        self.pushButton7.setText("计算7")
        self.pushButton7.released.connect(self.button_released)

        self.pushButton8 = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton8.setGeometry(QtCore.QRect(500, 350, 100, 30))
        self.pushButton8.setObjectName("pushButton8")
        self.pushButton8.setText("计算8")
        self.pushButton8.released.connect(self.button_released)


    def button_released(self):
        sending_button = self.sender()
        sub = Ui_SubWindow(self)
        sub.show()
        sub.setWindowTitle(str(sending_button.objectName()))
