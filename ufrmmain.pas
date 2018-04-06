//By Wilton Queiroz Araguaina - TO
{
  como usar
     informe o arquivo DFM que deseja converter,
     indique a pasta onde será salvo o .pas e o .dfm
     depois de convertido, abra o .pas no delphi e mande salvar.
     o delphi irá alterar as classes dos objetos.


}

unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Controls, Vcl.ExtCtrls,forms,inifiles;

type
  Tfrmmain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    edArquivo: TEdit;
    Label1: TLabel;
    OpenDialog: TOpenDialog;
    Button2: TButton;
    mOrigem: TMemo;
    Button3: TButton;
    mDestino: TMemo;
    btnconverteDFM: TButton;
    edEndsalva: TEdit;
    Label2: TLabel;
    mObs: TMemo;
    edMainModule: TEdit;
    Label3: TLabel;
    edUses: TEdit;
    Label4: TLabel;
    edButton: TEdit;
    Label5: TLabel;
    mUses: TMemo;
    mTemp: TMemo;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnconverteDFMClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  function Separa(dados: string; item_a_retornar: Integer;  caracter: string): string;
  function espaco(qtd:smallint):string;
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure SalvaNoIni(secao, chave, valor: String);
function  LerNoIni(secao, chave: String): String;
function  StrSubst(const S, Del, Ins: string; Count: Integer): string;
function  DirAtual:String;
function  IIF(TestExp: Boolean; TrueExp, FalseExp: Variant): Variant;

var
  frmmain: Tfrmmain;

implementation

{$R *.dfm}


procedure Tfrmmain.Button2Click(Sender: TObject);
begin

OpenDialog.InitialDir :=ExtractFilePath(edArquivo.Text);
if OpenDialog.Execute then
   edArquivo.Text :=OpenDialog.FileName;
end;

procedure Tfrmmain.Button3Click(Sender: TObject);
begin
if fileexists(edArquivo.Text) then
   mOrigem.Lines.LoadFromFile(edArquivo.Text);
btnconverteDFM.Enabled :=true;
end;

function Tfrmmain.espaco(qtd: smallint): string;
var x:integer;
begin
  result :='';
  for x := 1 to qtd do
   result :=result+' ';


end;

procedure Tfrmmain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
SALVANOINI('CONFIG','ULTIMO ARQUIVO DFM',edArquivo.text);
SALVANOINI('CONFIG','ULTIMO PASTA DESTINO',edEndsalva.text);
SALVANOINI('CONFIG','MAIN MODULE',edMainModule.text);
SALVANOINI('CONFIG','USES',eduses.text);
SALVANOINI('CONFIG','BUTTON',edButton.text);
muses.lines.SaveToFile(diratual+'uses.txt');

end;

procedure Tfrmmain.FormShow(Sender: TObject);
begin
edArquivo.text    :=lernoini('CONFIG','ULTIMO ARQUIVO DFM');
edEndsalva.text   :=lernoini('CONFIG','ULTIMO PASTA DESTINO');
edMainModule.text :=lernoini('CONFIG','MAIN MODULE');
eduses.text       :=lernoini('CONFIG','USES');
edButton.text     :=lernoini('CONFIG','BUTTON');
if fileexists(diratual+'uses.txt') then
muses.lines.LoadFromFile(diratual+'uses.txt');

if edMainModule.text='' then
   edMainModule.text :='uniMainModule';

if edButton.text='' then
   edButton.text :='TUniButton';

if edUses.text='' then
   edUses.text :='uniGUIVars, MainModule, uniGUIApplication';

if mUses.Lines.text='' then
   mUses.Lines.text :='  Windows, Messages, SysUtils, Classes, Graphics, Controls, uniGUIForm, uniGUIDialogs,'+#13+
                      '  Menus, Db, DBTables, Vcl.Forms,StdCtrls, uniGUITypes, jpeg, uniTimer, uniMainMenu,'+#13+
                      '  uniGUIBaseClasses, uniGUIClasses,  uniImageList, uniRadioButton, uniDateTimePicker,'+#13+
                      '  uniDBDateTimePicker,  uniMultiItem, uniComboBox, uniDBComboBox, uniGroupBox, uniEdit,'+#13+
                      '  uniDBCheckBox, uniDBEdit, uniButton, uniDBText, uniCheckBox, uniBasicGrid,'+#13+
                      '  uniDBGrid, uniLabel, uniPanel, uniImage;';

end;

procedure Tfrmmain.btnconverteDFMClick(Sender: TObject);
var x:integer;
l:string;
strparte3,alinhamentoTitulo,larguracoluna,montacoluna,captiongrid,colunasgrid,
itensradiogroup,alinhamento,datasource,strparte,strparte2,fclasForm,fnameform,fpas:string;
converteobj:smallint;
posicao :integer;
zLeft,
zTop,
zWidth,
zHeight,
zAlign:string;
FLAGUSES:BOOLEAN;
begin
     mObs.lines.clear;
     mDestino.Lines.Clear;

     x :=0;
     fclasForm :=Trim(Separa(morigem.Lines.Strings[0],2,':'));
     fnameform :=copy(fclasForm,2,length(fclasForm));
     while true do
       begin
                converteobj:=0;
                l :=mOrigem.Lines.Strings[x];
                if (pos('object',l)>0) and (trim(separa(l,2,':'))='TPanel') then
                  mDestino.Lines.Add(StrSubst(l,'TPanel','TUniPanel',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TLabel') then
                  mDestino.Lines.Add(StrSubst(l,'TLabel','TUniLabel',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TEdit','TUniEdit',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TEdit','TUniEdit',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TButton') then
                  mDestino.Lines.Add(StrSubst(l,'TButton',edButton.text,0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TBitBtn') then
                  mDestino.Lines.Add(StrSubst(l,'TBitBtn',edButton.text,0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TRadioGroup') then
                  mDestino.Lines.Add(StrSubst(l,'TRadioGroup','TUniRadioGroup',0))


                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxRadioGroup') then
                  begin
                  mDestino.Lines.Add(StrSubst(l,'TcxRadioGroup','TUniRadioGroup',0));
                  converteobj:=2;
                  end

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TGroupBox') then
                  mDestino.Lines.Add(StrSubst(l,'TGroupBox','TUniGroupBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxGroupBox') then
                  mDestino.Lines.Add(StrSubst(l,'TcxGroupBox','TUniGroupBox',0))

                 //unigui nao possui checkcombobox, nem checklistbox, foi utilizado componente free
                 //http://forums.unigui.com/index.php?/topic/9041-new-tunichecklistbox-component/page-2?hl=tunichecklist

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxCheckComboBox') then
                  mDestino.Lines.Add(StrSubst(l,'TcxCheckComboBox','TUniCheckListBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TCheckListBox') then
                  mDestino.Lines.Add(StrSubst(l,'TCheckListBox','TUniCheckListBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TDBCheckListBox') then
                  begin
                  mDestino.Lines.Add(StrSubst(l,'TDBCheckListBox','TUniCheckListBox',0));
                  mObs.lines.add(l+' revisar componente TCheckListbox');
                  end

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxCheckListBox') then
                  mDestino.Lines.Add(StrSubst(l,'TcxCheckListBox','TUniCheckListBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBCheckListBox') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBCheckListBox','TUniCheckListBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TMemo') then
                  mDestino.Lines.Add(StrSubst(l,'TMemo','TUniMemo',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxTextEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TcxTextEdit','TUniEdit',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBTextEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBTextEdit','TUniDBEdit',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TDBText') then
                  mDestino.Lines.Add(StrSubst(l,'TDBText','TUniDBText',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TDBEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TDBEdit','TUniDBEdit',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBCurrencyEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBCurrencyEdit','TUniDBFormattedNumberEdit',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBMaskEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBMaskEdit','TUniDBEdit',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TMaskEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TMaskEdit','TUniEdit',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TRadioButton') then
                  mDestino.Lines.Add(StrSubst(l,'TRadioButton','TUniRadioButton',0))


                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBMaskEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBMaskEdit','TUniDBEdit',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxCurrencyEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TcxCurrencyEdit','TUniFormattedNumberEdit',0))


                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TMainMenu') then
                  mDestino.Lines.Add(StrSubst(l,'TMainMenu','TUniMainMenu',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TMenuItem') then
                  mDestino.Lines.Add(StrSubst(l,'TMenuItem','TUniMenuItem',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TPopupMenu') then
                  mDestino.Lines.Add(StrSubst(l,'TPopupMenu','TUniPopupMenu',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxMaskEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TcxMaskEdit','TUniEdit',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxButton') then
                  mDestino.Lines.Add(StrSubst(l,'TcxButton',edButton.text,0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxLabel') then
                  mDestino.Lines.Add(StrSubst(l,'TcxLabel','TUniLabel',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxLabel') then
                  mDestino.Lines.Add(StrSubst(l,'TcxLabel','TUniLabel',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxComboBox') then
                  mDestino.Lines.Add(StrSubst(l,'TcxComboBox','TUniComboBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBComboBox') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBComboBox','TUniDBComboBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBLookupComboBox') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBLookupComboBox','TUniDBLookupComboBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxLookupComboBox') then
                  mDestino.Lines.Add(StrSubst(l,'TcxLookupComboBox','TUniDBLookupComboBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDateEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDateEdit','TUniDateTimePicker',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBNavigator') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBNavigator','TUniDBNavigator',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TTimer') then
                  mDestino.Lines.Add(StrSubst(l,'TTimer','TUniTimer',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBLabel') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBLabel','TUniDBText',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBLabel') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBLabel','TUniDBText',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TwwDBLookupCombo') then
                  begin
                   mDestino.Lines.Add(StrSubst(l,'TwwDBLookupCombo','TUniDBLookupComboBox',0));
                   mObs.lines.add(l+' vincular datasource componente lockup infopower');
                  end

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TwwDBComboBox') then
                  mDestino.Lines.Add(StrSubst(l,'TwwDBComboBox','TUniDBComboBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TwwDBDateTimePicker') then
                  mDestino.Lines.Add(StrSubst(l,'TwwDBDateTimePicker','TUniDBDateTimePicker',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TImageList') then
                  mDestino.Lines.Add(StrSubst(l,'TImageList','TUniNativeImageList',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TImage') then
                  mDestino.Lines.Add(StrSubst(l,'TImage','TUniImage',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TImage') then
                  mDestino.Lines.Add(StrSubst(l,'TImage','TUniImage',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxPageControl') then
                  mDestino.Lines.Add(StrSubst(l,'TcxPageControl','TUniPageControl',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxTabSheet') then
                  mDestino.Lines.Add(StrSubst(l,'TcxTabSheet','TUniTabSheet',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxSplitter') then
                  mDestino.Lines.Add(StrSubst(l,'TcxSplitter','TUniSplitter',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TSplitter') then
                  mDestino.Lines.Add(StrSubst(l,'TSplitter','TUniSplitter',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxMemo') then
                  mDestino.Lines.Add(StrSubst(l,'TcxMemo','TUniMemo',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBMemo') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBMemo','TUniDBMemo',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TMemo') then
                  mDestino.Lines.Add(StrSubst(l,'TMemo','TUniMemo',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TDBMemo') then
                  mDestino.Lines.Add(StrSubst(l,'TDBMemo','TUniDBMemo',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxCheckBox') then
                  mDestino.Lines.Add(StrSubst(l,'TcxCheckBox','TuniCheckBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBCheckBox') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBCheckBox','TUniDBCheckBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TCheckBox') then
                  mDestino.Lines.Add(StrSubst(l,'TCheckBox','TUniCheckBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TDBCheckBox') then
                  mDestino.Lines.Add(StrSubst(l,'TDBCheckBox','TUniDBCheckBox',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TDBChart') then
                  begin
                   mDestino.Lines.Add(StrSubst(l,'TDBChart','TUniChart',0));
                   mObs.lines.add(l+' reconfigurar grafico');
                  end

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TLineSeries') then
                  mDestino.Lines.Add(StrSubst(l,'TLineSeries','TUniLineSeries',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TBarSeries') then
                  mDestino.Lines.Add(StrSubst(l,'TBarSeries','TUniBarSeries',0))

                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxGrid') then
                  begin
                  mDestino.Lines.Add(StrSubst(l,'TcxGrid','TUniDBGrid',0));
                  converteobj:=1;
                  end
                else if (pos('object',l)>0) and (trim(separa(l,2,':'))='TcxDBDateEdit') then
                  mDestino.Lines.Add(StrSubst(l,'TcxDBDateEdit','TUniDBDateTimePicker',0))
               else
                  Begin
                    if trim(separa(l,1,'='))='DataBinding.DataSource' then
                      l :='DataSource = '+separa(l,2,'=');

                    if trim(separa(l,1,'='))='DataBinding.DataField' then
                      l :='DataField = '+separa(l,2,'=');

                    mDestino.Lines.Add(l);
                  End;
          case converteobj of
          0:x :=x+1;
          1:Begin //capturar datasource do tcxgrid e jogar para o datasource do tunidbgrid
              strparte          :='';
              strparte2         :='';
              strparte3         :='';
              alinhamento       :='';
              datasource        :='';
              colunasgrid       :='';
              captiongrid       :='';
              montacoluna       :='';
              larguracoluna     :='';
              alinhamentoTitulo :='';
              zLeft             :='';
              zTop              :='';
              zWidth            :='';
              zHeight           :='';
              zAlign            :='';


              while True do
                Begin
                   l        :=mOrigem.Lines.Strings[x];
                   posicao  :=pos('object',l)-1;
                   if strparte='' then
                      strparte :=espaco(posicao)+'end';

                   if trim(separa(l,1,'='))='Left' then
                     zLeft :=trim(separa(l,2,'='));

                   if trim(separa(l,1,'='))='Top' then
                     zTop :=trim(separa(l,2,'='));

                   if trim(separa(l,1,'='))='Width' then
                     zWidth :=trim(separa(l,2,'='));

                   if trim(separa(l,1,'='))='Height' then
                     zHeight :=trim(separa(l,2,'='));

                   if trim(separa(l,1,'='))='Align' then
                     zAlign :=trim(separa(l,2,'='));

                   if (pos(': TcxGridDBTableView',l)>0) or (pos(': TcxGridDBBandedTableView',l)>0) then
                      Begin
                        posicao   :=pos('object',l)-1;
                        if (strparte2='') and (posicao>0) then
                            strparte2 :=espaco(posicao)+'end'; //final do end do objeto,
                        inc(x);

                        while true do
                           begin
                             l         :=mOrigem.Lines.Strings[x];
                             posicao   :=pos('object',l)-1;

                              if (trim(separa(l,1,'='))='Align') AND (alinhamento='') then
                                 alinhamento :=l;

                             if (strparte3='') and (posicao>0) then
                                strparte3 :=espaco(posicao)+'end'; //final do end do objeto,

                             if (pos('DataController.DataSource',l)>0) and (trim(Separa(l,2,'='))<>'') AND (datasource='') then
                               datasource :='DataSource = '+trim(Separa(l,2,'='));

                             if (pos('Caption =',l)>0) AND (trim(separa(l,2,'='))<>'') AND (trim(separa(l,2,'='))<>chr(39)) and (captiongrid='') then
                               captiongrid :='Title.Caption = '+trim(separa(l,2,'='));

                             if (pos('DataBinding.FieldName =',l)>0) AND (trim(separa(l,2,'='))<>'') AND (colunasgrid='') then
                               colunasgrid :='FieldName = '+trim(separa(l,2,'='));

                             if (pos('Properties.Alignment.Horz = taRightJustify',l)>0) AND (alinhamentoTitulo='') then
                               alinhamentoTitulo :='Title.Alignment = taRightJustify';

                             if (pos('Width =',l)>0) AND (TRIM(l)<>'') AND (larguracoluna='') then
                               larguracoluna :=TRIM(l);

                             if l=strparte3 then
                                begin
                                 montacoluna :=montacoluna+'item'+#13+
                                                          IIF(colunasgrid<>'',colunasgrid+#13+#10,'')+
                                                          IIF(captiongrid<>'',captiongrid+#13+#10,'')+
                                                          IIF(larguracoluna<>'',larguracoluna+#13+#10,'')+
                                                          IIF(alinhamentoTitulo<>'',alinhamentoTitulo+#13+#10,#13+#10)+
                                                          'end'+#10+#13;
                                 colunasgrid       :='';
                                 captiongrid       :='';
                                 larguracoluna     :='';
                                 alinhamentoTitulo :='';

                                end;
                             if l=strparte2 then
                                break;
                             inc(x);
                           end;

                         montacoluna :='Columns = <'+#13+#10+
                                       copy(montacoluna,1,length(montacoluna)-2)+
                                       '>';

                         captiongrid      :='';
                         colunasgrid      :='';
                         alinhamentoTitulo:='';
                         larguracoluna    :='';
                         strparte3        :='';
                      end;

                   if l=strparte then //achou o end final do objeto
                      Begin
                        if  zLeft<>'' then
                           mDestino.Lines.Add('Left = '+zLeft);
                        if  zTop<>'' then
                           mDestino.Lines.Add('Top = '+zTop);

                        if  zWidth<>'' then
                           mDestino.Lines.Add('Width = '+zWidth);

                        if  zHeight<>'' then
                           mDestino.Lines.Add('Height = '+zHeight);

                        if  zAlign<>'' then
                           mDestino.Lines.Add('Align = '+zAlign);

                        if datasource<>'' then
                           mDestino.Lines.Add(datasource);
                        if alinhamento<>'' then
                           mDestino.Lines.Add(alinhamento);
                        if montacoluna<>'' then
                           mDestino.Lines.Add(montacoluna);
                        strparte :='';

                        mDestino.Lines.Add('end');
                        x :=x+1;
                        break;
                      End;

                   x :=x+1;
                   if x>mOrigem.Lines.Count-1 then
                      Break;
                End;
            End;
          2:  //tuniradiogroup
            begin
                    itensradiogroup :='';
                    inc(x);
                    while True do
                    begin
                       l   :=mOrigem.Lines.Strings[x];
                       if pos('Properties.Items = <',l)>0 then
                          begin
                             inc(x);
                             while true do
                               begin
                                 l   :=mOrigem.Lines.Strings[x];
                                 if pos('Caption =',l)>0 then
                                   itensradiogroup :=itensradiogroup+trim(separa(l,2,'='))+#13;
                                 inc(x);
                                 if pos('end>',l)>0 then
                                    break;
                               end;
                            break;
                          end
                       else
                         mDestino.Lines.Add(l);
                     inc(x);
                    end;
                    mDestino.Lines.Add('Items.Strings = ('+#13+
                                        itensradiogroup+')');
                    inc(x);
            end;
          end;

        if x>mOrigem.Lines.Count-1 then
            break;
       end;

  mDestino.Lines.SaveToFile(edEndsalva.Text+ExtractFileName(edArquivo.Text));


  //converter .pas

  fpas :=ExtractFilePath(edArquivo.Text)+copy(ExtractFileName(edArquivo.Text),1,length(ExtractFileName(edArquivo.Text))-3)+'pas';


  mDestino.lines.Clear;
  mOrigem.Lines.clear;
  mtemp.lines.clear;
  mtemp.lines.LoadFromFile(fpas);
  x       :=0;
  FLAGUSES:=FALSE;
  while true do
    begin
       l :=mtemp.lines.Strings[x];
       if (pos('uses',l)>0) and (not flagUses) then
          begin
           mOrigem.Lines.add('uses ');
           mOrigem.Lines.add(mUses.lines.text);
           while true do
             begin
               l :=mtemp.lines.Strings[x];
               if pos(';',l)>0 then
                  BEGIN
                   flagUses :=true;
                   X :=X+1;
                   break;
                  END;
               x :=x+1;
             end;
          end
       else
       begin
        mOrigem.Lines.add(l);
        x :=x+1;
       end;

       if x>mtemp.lines.count then
          break;
    End;

  x :=0;
   while true do
      begin
         l :=mOrigem.Lines.Strings[x];

         if (pos('class(TForm)',l)>0)then
           mDestino.Lines.Add(StrSubst(l,'class(TForm)','class(TUniForm)',0))

         else if pos('implementation',l)>0 then
             begin
               mDestino.Lines.Add('function '+fnameform+': '+fclasForm+';');
               mDestino.Lines.Add('implementation');
               mDestino.Lines.Add('');
               mDestino.Lines.Add('{$R *.dfm}');
               mDestino.Lines.Add('uses');
               mDestino.Lines.Add(eduses.text);
               mDestino.Lines.Add('');
               mDestino.Lines.Add('');

               mDestino.Lines.Add('function '+fnameform+': '+fclasForm+';');
               mDestino.Lines.Add('begin');
               mDestino.Lines.Add('  Result := '+fclasForm+'('+edMainModule.text+'.GetFormInstance('+fclasForm+'));');
               mDestino.Lines.Add('end;');

               while true do
                 begin
                   l :=mOrigem.Lines.Strings[x];
                   if pos('{$R *.DFM}',uppercase(l))>0 then
                     begin
                       x :=x+1;
                       break;
                     end;
                   x :=x+1;
                 end;
             end
         else
             begin
               if (pos('$R *.dfm',l)=0) and (lowercase(l)<>'end.') then
                  mDestino.Lines.Add(l);

               if lowercase(l)='end.' then
                 begin
                   mDestino.Lines.Add('initialization');
                   mDestino.Lines.Add('RegisterAppFormClass('+fclasForm+')');
                   mDestino.Lines.Add('End.');
                 end;
             end;

        x :=x+1;
        if x>mOrigem.Lines.Count-1 then
           break;
      end;

     mDestino.Lines.SaveToFile(edEndsalva.Text+copy(ExtractFileName(edArquivo.Text),1,length(ExtractFileName(edArquivo.Text))-3)+'pas');
     btnconverteDFM.enabled :=false;

end;

function Tfrmmain.Separa(dados: string; item_a_retornar: Integer;  caracter: string): string;
var
  Items: array [1 .. 1001] of string;
  X: Integer;
  aitem: Integer;
Begin
  aitem := 1;
  for X := 1 to Length(dados) do
    if dados[X] = caracter then
      inc(aitem)
    else
      Items[aitem] := Items[aitem] + dados[X];
  Result := Items[item_a_retornar];
End;


function IIF(TestExp: Boolean; TrueExp, FalseExp: Variant): Variant;
begin
  if TestExp then
    Result := TrueExp
  else
    Result := FalseExp;
end;

function  DirAtual:String;
begin
 result :=ExtractFilePath(application.ExeName);
 IF COPY(result,length(result),1)<>'\' then
    result :=result+'\';

end;

Procedure SalvaNoIni(secao, chave, valor: String);
var iniFile: TIniFile;
begin
  try
    iniFile := TIniFile.Create(DirAtual+'conversor.ini');
    iniFile.WriteString(secao, chave, valor);
  finally
    freeandnil(iniFile);
  end;

end;

function LerNoIni(secao, chave: String): String;
var iniFile: TIniFile;
begin
  try
    iniFile := TIniFile.Create(DirAtual+'conversor.ini');
    Result  := iniFile.ReadString(secao, chave, '');
  finally
    freeandnil(iniFile);
  end;

end;


function StrSubst(const S, Del, Ins: string; Count: Integer): string;
var
  I, Found: Integer;
  R: string;
begin
  R := S;
  if (S = '') or (Del = '') or (Del = Ins) then
    R := ''
  else
    begin
      Found := 0;
      I := 1;
      while ((Count = 0) or (Found < Count)) and (I <= Length(R)) do
        begin
          if Copy(R, I, Length(Del)) = Del then
            begin
              Inc(Found);
              Delete(R, I, Length(Del));
              Insert(Ins, R, I);
              Inc(I, Length(Ins));
            end
          else
            Inc(I);
        end;
    end;
  Result := R;
end;
end.
