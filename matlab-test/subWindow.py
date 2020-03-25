# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'subWindow.ui'
#
# Created by: PyQt5 UI code generator 5.11.3
#
# WARNING! All changes made in this file will be lost!

import os
import sys
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import *
import matlab.engine


class Ui_SubWindow(QMainWindow):

    def __init__(self, parent=None):
        self.cwd = os.getcwd()
        self.fileName1 = 'none'
        super(Ui_SubWindow,self).__init__(parent)
        self.setObjectName("SubWindow")
        self.resize(800, 600)
        self.centralwidget = QtWidgets.QWidget(self)
        self.setCentralWidget(self.centralwidget)
        QtCore.QMetaObject.connectSlotsByName(self)

        self.centralwidget.setObjectName("centralwidget")

        self.fileDir = QtWidgets.QLineEdit(self.centralwidget)
        self.fileDir.setGeometry(QtCore.QRect(100, 150, 300, 30))
        self.fileDir.setObjectName("fileDir")
        self.fileDir.setFocusPolicy(QtCore.Qt.NoFocus)

        self.btn_chooseFile = QtWidgets.QPushButton(self.centralwidget)
        self.btn_chooseFile.setGeometry(QtCore.QRect(500, 150, 100, 30))
        self.btn_chooseFile.setObjectName("btn_chooseDir")
        self.btn_chooseFile.setText("选择文件夹")
        self.btn_chooseFile.clicked.connect(self.slot_btn_chooseFile)


        self.pushButton = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton.setGeometry(QtCore.QRect(500, 250, 100, 30))
        self.pushButton.setObjectName("pushButton")
        self.pushButton.setText("计算")
        self.pushButton.clicked.connect(self.cal)


        self.textEdit = QtWidgets.QTextEdit(self.centralwidget)
        self.textEdit.setGeometry(QtCore.QRect(100, 300, 500, 250))
        self.textEdit.setObjectName("textEdit")
        self.textEdit.setReadOnly(True)
        # 下面将输出重定向到textEdit中

        sys.stdout = EmittingStream(textWritten=self.outputWritten)
        sys.stderr = EmittingStream(textWritten=self.outputWritten)


    def outputWritten(self, text):
        cursor = self.textEdit.textCursor()
        cursor.movePosition(QtGui.QTextCursor.End)
        cursor.insertText(text)
        self.textEdit.setTextCursor(cursor)
        self.textEdit.ensureCursorVisible()


    def slot_btn_chooseFile(self):
        self.fileName1 = QFileDialog.getExistingDirectory(self,"选取文件夹",self.cwd)
        self.fileDir.setText(self.fileName1)
        print(self.fileName1)


    def cal(self):
        if self.fileName1 == 'none' or self.fileName1 == "":
            print("未选择文件夹")
            QMessageBox.about(self, "错误", "未选择文件夹")
        else:
            print(self.fileName1)
            try:
                eng = matlab.engine.start_matlab()
                eng.main2(self.fileName1,nargout=0)
                eng.quit()
                QMessageBox.about(self, "通知", "计算完成")
            except Exception:
                QMessageBox.about(self, "错误", "计算失败")



class EmittingStream(QtCore.QObject):
    textWritten = QtCore.pyqtSignal(str)  # 定义一个发送str的信号

    def write(self, text):
        self.textWritten.emit(str(text))