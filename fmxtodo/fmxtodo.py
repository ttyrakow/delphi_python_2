from delphifmx import *
from MainFormImpl import FMainFormImpl

def main():
    Application.Initialize()
    Application.Title = 'FMX ToDo List'
    Application.MainForm = FMainFormImpl(Application)
    Application.MainForm.Show()
    Application.Run()
    Application.MainForm.Destroy()

if __name__ == '__main__':
    main()
