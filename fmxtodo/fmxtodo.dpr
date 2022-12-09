program fmxtodo;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainForm in 'MainForm.pas' {FMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMainForm, FMainForm);
  Application.Run;
end.
