unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, PythonEngine, VarPyth;

type
  TFMainForm = class(TForm)
    otworzArkuszButton: TButton;
    Label1: TLabel;
    miastoCombo: TComboBox;
    Label2: TLabel;
    miesiecznyCheck: TRadioButton;
    rokCombo: TComboBox;
    rocznyCheck: TRadioButton;
    miesiacCombo: TComboBox;
    img: TImage;
    OpenDialog1: TOpenDialog;
    wykresButton: TButton;
    eng: TPythonEngine;
    procedure FormCreate(Sender: TObject);
    procedure otworzArkuszButtonClick(Sender: TObject);
    procedure wykresButtonClick(Sender: TObject);
    procedure engBeforeLoad(Sender: TObject);
  private
    { Private declarations }
    module: Variant;
  public
    { Public declarations }
  end;

var
  FMainForm: TFMainForm;

implementation

{$R *.dfm}

uses pngimage;

procedure TFMainForm.engBeforeLoad(Sender: TObject);
begin
  eng.SetPythonHome(ExtractFileDir(Application.ExeName));
end;

procedure TFMainForm.FormCreate(Sender: TObject);
begin
  eng.DllPath := ExtractFileDir(Application.ExeName);
  eng.LoadDll();
end;

procedure TFMainForm.otworzArkuszButtonClick(Sender: TObject);
begin
  if not OpenDialog1.Execute() then
    Exit;

  module := Import('chart');
  var res := module.load_xls(string(OpenDialog1.FileName));
  if not VarIsTrue(res) then
  begin
    ShowMessage('B³¹d ³adowania arkusza');
    Exit;
  end;
  var miasta := module.get_cities();
  miastoCombo.Items.Clear();
  for var m in VarPyIterate(miasta) do
    miastoCombo.Items.Add(m);
  rokCombo.Items.Clear();
  var lata  := module.get_years();
  for var r in VarPyIterate(lata) do
    rokCombo.Items.Add(r);
  miesiacCombo.Items.Clear();
  var miesiace := module.get_months();
  for var m in VarPyIterate(miesiace) do
    miesiacCombo.Items.Add(m);
  ShowMessage('Arkusz za³adowany');
end;

procedure TFMainForm.wykresButtonClick(Sender: TObject);
begin
  //TODO sprawdziæ, czy wybrano odpowiednio kryteria

  var buf: Variant;

  if miesiecznyCheck.Checked then
    buf := module.plot_city_year(miastoCombo.Text, rokCombo.Text)
  else
    buf := module.plot_city_month(miastoCombo.Text, miesiacCombo.Text);

  var mems := TMemoryStream.Create();
  try
    for var v in VarPyIterate(buf) do
    begin
      var b: Byte := Byte(v);
      mems.Write(b, 1);
    end;
    mems.Seek(0, soFromBeginning);
    img.Picture.LoadFromStream(mems);
  finally
    mems.Free();
  end;
end;

initialization
  MaskFPUExceptions(true);
end.
