program tempchart;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {FMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainForm, FMainForm);
  Application.Run;
end.
