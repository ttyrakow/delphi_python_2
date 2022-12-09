unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ControlList, Vcl.StdCtrls,
  PythonEngine, VarPyth, WrapDelphi;

type

  NewsItem = record
    url: string;
    headline: string;
    description: string;
  end;


  TForm1 = class(TForm)
    newsList: TControlList;
    headlineLabel: TLabel;
    descriptionLabel: TLabel;
    ControlListButton1: TControlListButton;
    Label1: TLabel;
    keywordEdit: TEdit;
    getNewsButton: TButton;
    quitButton: TButton;
    eng: TPythonEngine;
    statusLabel: TLabel;
    pymod: TPythonModule;
    wrapper: TPyDelphiWrapper;
    procedure newsListBeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure ControlListButton1Click(Sender: TObject);
    procedure keywordEditChange(Sender: TObject);
    procedure getNewsButtonClick(Sender: TObject);
    procedure quitButtonClick(Sender: TObject);
    procedure engBeforeLoad(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pymodEvents0Execute(Sender: TObject; PSelf, Args: PPyObject;
      var Result: PPyObject);
    procedure setStatus(msg: string);
  private
    { Private declarations }
    allNews: TArray<NewsItem>;
    filteredNews: TArray<NewsItem>;

    procedure getNews();
    procedure filterNews();



  public
    { Public declaration4s }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses ShellAPI, PythonIntf;

procedure TForm1.getNewsButtonClick(Sender: TObject);
begin
  Cursor := crHourGlass;
  getNewsButton.Enabled := false;
  Application.ProcessMessages();
  try
    getNews();
    filterNews();
  finally
    Cursor := crDefault;
    getNewsButton.Enabled := true;
  end;
end;

procedure TForm1.ControlListButton1Click(Sender: TObject);
begin
  var idx := newsList.ItemIndex;
  ShellAPI.ShellExecute(
    0, 'OPEN', PWideChar(filteredNews[idx].url), '', '', SW_SHOWNORMAL);
end;

procedure TForm1.engBeforeLoad(Sender: TObject);
begin
  eng.SetPythonHome(ExtractFileDir(Application.ExeName));
end;

procedure TForm1.filterNews;
begin
  var kw := Trim(keywordEdit.Text).ToUpper();
  if kw = '' then
    filteredNews := allNews
  else
  begin
    SetLength(filteredNews, Length(allNews));
    var ii := 0;
    for var i := Low(allNews) to High(allNews) do
      if
        allNews[i].headline.ToUpper().Contains(kw)
        or allNews[i].description.ToUpper().Contains(kw)
      then
      begin
        filteredNews[ii] := allNews[i];
        ii := ii + 1;
      end;
    SetLength(filteredNews, ii);
  end;
  newsList.ItemCount := Length(filteredNews);
  newsList.Invalidate();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  eng.DllPath := ExtractFileDir(Application.ExeName);
  eng.LoadDll();
end;

procedure TForm1.getNews;
begin
  var myForm := wrapper.Wrap(self);
  pymod.SetVar('form', myForm);
  eng.Py_DECREF(myForm);
  var module := Import('bscnews');
  var news := module.get_news(url := 'https://www.bsc.com.pl');
  var len := Integer(news.Length());
  SetLength(allNews, len);
  var i := 0;
  for var n in VarPyIterate(news) do
  begin
    allNews[i].url := n.GetItem('url');
    allNews[i].headline := n.GetItem('headline');
    allNews[i].description := n.GetItem('description');
    i := i + 1;
  end;





{  Py_Initialize();
  try
    var modName := PyUnicode_FromString('bscnews');
    var module := PyImport_Import(modName);
    var get_news := PyObject_GetAttrString(module, 'get_news');
    var args := Pytuple_New(1);
    var newsUrl := PyUnicode_FromString('https://www.bsc.com.pl');
    Pytuple_SetItem(args, 0, newsUrl);
    var news := PyObject_Call(get_news, args, nil);
    if news <> nil then
    begin
      var len := PyList_Size(news);
      SetLength(allNews, len);
      for var i := 0 to len-1 do
      begin
        var item := PyList_GetItem(news, i);
        allNews[i].url :=
          UTF8ToWideString(PyUnicode_AsUTF8(PyDict_GetItemString(item, 'url')));
        allNews[i].headline :=
          UTF8ToWideString(PyUnicode_AsUTF8(PyDict_GetItemString(item, 'headline')));
        allNews[i].description :=
          UTF8ToWideString(PyUnicode_AsUTF8(PyDict_GetItemString(item, 'description')));
      end;
    end;
    Py_DecRef(get_news);
    Py_DecRef(module);
    Py_DecRef(modName);
  finally
    Py_Finalize();
  end;
  }
end;

procedure TForm1.keywordEditChange(Sender: TObject);
begin
  filterNews();
end;

procedure TForm1.newsListBeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
  ARect: TRect; AState: TOwnerDrawState);
begin
  headlineLabel.Caption := filteredNews[AIndex].headline;
  descriptionLabel.Caption := filteredNews[AIndex].description;
end;

procedure TForm1.pymodEvents0Execute(Sender: TObject; PSelf, Args: PPyObject;
  var Result: PPyObject);
var m: PAnsiChar;
begin
  if eng.PyArg_ParseTuple(Args, 's:set_status', @m) <> 0 then
  begin
    setStatus(UTF8ToWideString(m));
    Result := eng.Py_None;
  end;
end;

procedure TForm1.quitButtonClick(Sender: TObject);
begin
  Application.Terminate();
end;

procedure TForm1.setStatus(msg: string);
begin
  statusLabel.Caption := msg;
  Application.ProcessMessages();
end;

end.
