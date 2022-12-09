unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Menus, FMX.Layouts, FMX.ListBox;

type
  TFMainForm = class(TForm)
    Label1: TLabel;
    itemEdit: TEdit;
    addButton: TButton;
    todoList: TListBox;
    todoListMenu: TPopupMenu;
    deleteItem: TMenuItem;
    procedure addButtonClick(Sender: TObject);
    procedure deleteItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMainForm: TFMainForm;

implementation

{$R *.fmx}

procedure TFMainForm.addButtonClick(Sender: TObject);
begin
//
end;

procedure TFMainForm.deleteItemClick(Sender: TObject);
begin
//
end;

end.
