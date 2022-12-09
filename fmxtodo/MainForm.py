import os
from delphifmx import *

class FMainForm(Form):

    def __init__(self, owner):
        self.Label1 = None
        self.itemEdit = None
        self.addButton = None
        self.todoList = None
        self.todoListMenu = None
        self.deleteItem = None
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "MainForm.pyfmx"))

    def addButtonClick(self, Sender):
        pass

    def deleteItemClick(self, Sender):
        pass