from MainForm import FMainForm

class FMainFormImpl(FMainForm):
    def __init__(self, owner):
        super().__init__(owner)

    def addButtonClick(self, Sender):
        if self.itemEdit.Text != "":
            self.todoList.Items.Add(self.itemEdit.Text)

    
