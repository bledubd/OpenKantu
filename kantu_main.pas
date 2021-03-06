unit kantu_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus, Grids,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, ExtDlgs, TAGraph, TASeries,
  TAFuncSeries, TAMultiSeries, TATools, TASources,  kantu_definitions,
  kantu_simulation, kantu_pricepattern, Math, kantu_filters,
  kantu_custom_filter, ZMConnection, laz_synapse,
  kantu_loadSymbol, kantu_portfolioresults, dateUtils, kantu_singleSystem, lclintf;

type

  { TMainForm }

  TMainForm = class(TForm)
    BalanceCurve: TLineSeries;
    BalanceCurveFit: TLineSeries;
    BalanceCurveFitPortfolio: TLineSeries;
    BalanceCurvePortfolio: TLineSeries;
    Button1: TButton;
    Button2: TButton;
    Chart1: TChart;
    Chart2: TChart;
    ChartOHLC: TChart;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem54: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem56: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem64: TMenuItem;
    MenuItem65: TMenuItem;
    MenuItem66: TMenuItem;
    MenuItem67: TMenuItem;
    ohlcCheck: TCheckBox;
    LabelCheck: TCheckBox;
    GraphOpenTrades: TBubbleSeries;
    GraphCloseTrades: TBubbleSeries;
    GraphOHLC_Up: TBoxAndWhiskerSeries;
    GraphOHLC_Down: TBoxAndWhiskerSeries;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    ME_Shorts: TBarSeries;
    ME_Longs: TBarSeries;
    extraLabel: TLabel;
    inSampleEndLine: TConstantLine;
    lowerStdDev: TLineSeries;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenKantuLibraryDialog: TOpenDialog;
    OpenSymbolHistoryDialog: TOpenDialog;
    OutOfSampleAnalysisLabel: TLabel;
    OutOfSampleEndLine: TConstantLine;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    PopupMenu4: TPopupMenu;
    PopupMenu5: TPopupMenu;
    PopupMenu6: TPopupMenu;
    PopupMenu7: TPopupMenu;
    ProgressBar1: TProgressBar;
    ResultsGrid: TStringGrid;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    SaveDialogMQL4: TSaveDialog;
    selectedPatternLabel: TLabel;
    StatusLabel: TLabel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TradeGrid: TStringGrid;
    upperStdDev: TLineSeries;
    zeroLine: TConstantLine;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LabelCheckChange(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem35Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure ohlcCheckChange(Sender: TObject);
    procedure ResultsGridClick(Sender: TObject);
    procedure showOrHideColumn(Sender: TObject);
    procedure ResultsGridCompareCells(Sender: TObject; ACol, ARow, BCol,
      BRow: Integer; var Result: integer);
    procedure ResultsGridGetCellHint(Sender: TObject; ACol, ARow: Integer;
      var HintText: String);
    procedure TabSheet1Exit(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
  private
    { private declarations }
  public
    atrMultiplier: integer;
    isVolumeUsed: boolean;
    mainProgramFolder: string;
    isCancel: boolean;
    simulationRuns: integer;
    simulationTime: integer;
    simulationType: integer;
    selectedSystem: integer;
    selectedSymbol: integer;
    totalSystems: double;
    tradeLines: array of TLineSeries;
    function   CheckBeforeSimulation: boolean;
    function   isDataLoaded: boolean;
    procedure  ExportToMQL4;
    procedure  LinearLeastSquares(data: TRealPointArray; var M,B, R: extended);
    procedure  LinearLeastSquaresNormal(data: TRealPointArray; var M,B, R: extended);
    procedure  ParseDelimited(const sl : TStrings; const value : string; const delimiter : string) ;
    procedure  addPricePatternLogic(var F4_Code: TStringList; pricePattern: TIndicatorPattern; logic: integer; useLibrary: boolean; strategyNumber: integer);
    function   findSymbol(symbolString: string): integer;
    procedure  pricePatternToMQL4(var Code_MQL4: TStringList; pricePattern: TIndicatorPattern; logic: integer);
    procedure  parseConfig;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

uses kantu_indicators, kantu_regular_simulation, kantu_simulation_show;

procedure TMainForm.parseConfig;
var
  configFile: TStringList;
  i, j: integer;
begin

if FileExists('config.ini') = False then
   exit;

DefaultFormatSettings.ShortDateFormat 	 := 'yyyy.mm.dd' ;
  DefaultFormatSettings.DateSeparator 	         := '.' ;
  DefaultFormatSettings.DecimalSeparator 	 := '.' ;

SetCurrentDir(mainProgramFolder);
j := 0;

  configFile := TStringList.Create;

  configFile.LoadFromFile('config.ini');

   for i := 1 to SimulationForm2.OptionsGrid.RowCount-1 do
   begin
        SimulationForm2.OptionsGrid.Cells[1,i] := configFile[j] ;
        j := j+1;
   end;

   for i := 1 to FiltersForm.FiltersGrid.RowCount-1  do
   begin
   FiltersForm.FiltersGrid.Cells[1,i] := configFile[j];
   j := j+1;
   FiltersForm.FiltersGrid.Cells[2,i] := configFile[j];
   j := j+1;
   FiltersForm.FiltersGrid.Cells[3,i] := configFile[j];
   j := j+1;
   FiltersForm.FiltersGrid.Cells[4,i] := configFile[j];
   j := j+1;
   end;

   CustomFilterForm.CustomFormulaEdit.Text := configFile[j];
   j := j+1;
   SimulationForm2.BeginInSampleCalendar.Date:= StrToDateTime(configFile[j]) ;
   SimulationForm2.BeginInSampleEdit.Text := configFile[j];
   SimulationForm.BeginInSampleCalendar.Date:= StrToDateTime(configFile[j]) ;
   SimulationForm.BeginInSampleEdit.Text := configFile[j];
   j := j+1;
   SimulationForm2.EndInSampleCalendar.Date:= StrToDateTime(configFile[j]) ;
   SimulationForm2.EndInSampleEdit.Text := configFile[j];
   SimulationForm.EndInSampleCalendar.Date:= StrToDateTime(configFile[j]) ;
   SimulationForm.EndInSampleEdit.Text := configFile[j];
   j := j+1;
   SimulationForm2.EndOutOfSampleCalendar.Date:= StrToDateTime(configFile[j]) ;
   SimulationForm2.EndOutOfSampleEdit.Text := configFile[j];
   SimulationForm.EndOutOfSampleCalendar.Date:= StrToDateTime(configFile[j]) ;
   SimulationForm.EndOutOfSampleEdit.Text := configFile[j];
   j := j+1;
   SimulationForm2.OptTargetComboBox.ItemIndex:= StrToInt(configFile[j]) ;
   SimulationForm.OptTargetComboBox.ItemIndex:= StrToInt(configFile[j]) ;
   j := j+1;
   SimulationForm2.UseSLCheck.Checked:= StrToBool(configFile[j]) ;
   SimulationForm.UseSLCheck.Checked:= StrToBool(configFile[j]) ;
   j := j+1;
   SimulationForm2.UseTPCheck.Checked:= StrToBool(configFile[j]) ;
   SimulationForm.UseTPCheck.Checked:= StrToBool(configFile[j]) ;
   j := j+1;
   SimulationForm2.UseHourFilter.Checked:= StrToBool(configFile[j]) ;
   SimulationForm.UseHourFilter.Checked:= StrToBool(configFile[j]) ;
   j := j+1;
   SimulationForm2.UseDayFilter.Checked:= StrToBool(configFile[j]) ;
   SimulationForm.UseDayFilter.Checked:= StrToBool(configFile[j]) ;
   j := j+1;
   SimulationForm2.LROriginCheck.Checked:= StrToBool(configFile[j]) ;
   SimulationForm.LROriginCheck.Checked:= StrToBool(configFile[j]) ;
   j := j+1;
   SimulationForm2.UseFixedSLTP.Checked:= StrToBool(configFile[j]) ;
   SimulationForm.UseFixedSLTP.Checked:= StrToBool(configFile[j]) ;
   j := j+1;
   SimulationForm2.UseFixedHour.Checked:= StrToBool(configFile[j]) ;
   SimulationForm.UseFixedHour.Checked:= StrToBool(configFile[j]) ;
   j := j+1;

   for i:= 0 to ResultsGrid.ColCount-1 do
   begin
        ResultsGrid.Columns.Items[i].Visible:= StrToBool(configFile[j]) ;
        j := j+1;
   end;

   FiltersForm.isLastYearProfitCheck.Checked:= StrToBool(configFile[j]) ;
   j := j+1;

   configFile.Free;

end;


procedure TMainForm.ParseDelimited(const sl : TStrings; const value : string; const delimiter : string) ;
var
   dx : integer;
   ns : string;
   txt : string;
   delta : integer;
begin
   delta := Length(delimiter) ;
   txt := value + delimiter;
   sl.BeginUpdate;
   sl.Clear;
   try
     while Length(txt) > 0 do
     begin
       dx := Pos(delimiter, txt) ;
       ns := Copy(txt,0,dx-1) ;
       sl.Add(ns) ;
       txt := Copy(txt,dx+delta,MaxInt) ;
     end;
   finally
     sl.EndUpdate;
   end;
end;

procedure TMainForm.MenuItem4Click(Sender: TObject);
begin

   loadSymbol.SymbolsList.Clear;
   loadSymbol.Datasource1.Enabled:=False; //Manual refresh of linked DBGrid
   loadSymbol.Datasource1.Enabled:=True;
   loadSymbol.ZMQueryDataSet1.SQL.Clear;
   loadSymbol.ZMQueryDataSet1.SQL.Add('SELECT * FROM symbols');
   loadSymbol.ZMQueryDataSet1.QueryExecute;

    with loadSymbol.SymbolsGrid.DataSource.DataSet do
 // begin
   // first;
     while not loadSymbol.SymbolsGrid.DataSource.DataSet.EOF do
     begin
        loadSymbol.SymbolsList.Items.Add(loadSymbol.SymbolsGrid.Columns[0].Field.AsString) ;
        loadSymbol.SymbolsGrid.DataSource.DataSet.Next;
     end ;

    //loadSymbol.SymbolsGrid.Columns[0].Width := 150;
    //loadSymbol.SymbolsGrid.Columns[1].Width := 250;

   loadSymbol.Visible := true;

end;

procedure TMainForm.MenuItem5Click(Sender: TObject);
begin

end;


function TMainForm.isDataLoaded: boolean;
begin

Result := true;

     if (Length(LoadedIndiHistoryData)=0) then
  begin

     ShowMessage('Please load data before running a simulation.');
     Result := false ;

  end;

end;

function TMainForm.CheckBeforeSimulation: boolean;
begin

Result := true;

     if SimulationForm.OptionsGrid.Cells[1, IDX_OPT_MAX_RULES_PER_CANDLE] = '0' then
     begin
     ShowMessage('Number of rules needs to be at least 1.');
     Result := false;
     end;

     if SimulationForm.OptionsGrid.Cells[1, IDX_OPT_NO_OF_CORES] = '0' then
     begin
     ShowMessage('Number of cores should be at least 1.');
     Result := false;
     end;

end;

procedure TMainForm.MenuItem8Click(Sender: TObject);
begin

end;

procedure TMainForm.ohlcCheckChange(Sender: TObject);
begin
  if ohlcCheck.Checked then
  begin
     GraphOHLC_Up.Active:= true;
     GraphOHLC_Down.Active:= true;
  end;

  if ohlcCheck.Checked = false then
  begin
     GraphOHLC_Up.Active:= false;
     GraphOHLC_Down.Active:= false;
  end;

  ChartOHLC.Repaint;

end;

function TMainForm.findSymbol(symbolString: string): integer;
var
i: integer;
begin

   Result := -1;

   if simulationType = SIMULATION_TYPE_INDICATORS then
   begin
        for i:= 0 to Length(LoadedIndiHistoryData)-1 do
        begin
             if symbolString = LoadedIndiHistoryData[i].symbol then
             Result := i;

        end;
   end;

end;

procedure TMainForm.ResultsGridClick(Sender: TObject);
var
  Val: Double;
  Col: Integer;
  Row: Integer;
  i: integer;
  ylist: array[0..4] of double;
  ylistBubble: array[0..1] of double;
  symbol:integer;
  simulationResults, simulationResultsInSample: TSimulationResults;
  positionType: string;
  indicatorSimulationResults, indicatorSimulationResultsInSample: TIndicatorSimulationResults;
begin

  for Col := ResultsGrid.Selection.Left to ResultsGrid.Selection.Right do
    for Row := ResultsGrid.Selection.Top to ResultsGrid.Selection.Bottom do
      if TryStrToFloat(ResultsGrid.Cells[Col, Row], Val) then
        begin

           if Col = IDX_GRID_USE_IN_PORTFOLIO then
           begin

                if ResultsGrid.Cells[IDX_GRID_USE_IN_PORTFOLIO, Row] = '0' then
                begin
                ResultsGrid.Cells[IDX_GRID_USE_IN_PORTFOLIO, Row] := '1';
                Exit
                end;

                if ResultsGrid.Cells[IDX_GRID_USE_IN_PORTFOLIO, Row] = '1' then
                begin
                ResultsGrid.Cells[IDX_GRID_USE_IN_PORTFOLIO, Row] := '0';
                Exit
                end;

           end;

           if Col = IDX_GRID_USE_IN_PORTFOLIO then
           Exit;

           selectedSystem := StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER, Row])-1;

           selectedPatternLabel.Caption := IntToStr(StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER, Row])-1) ;

           symbol := findSymbol(ResultsGrid.Cells[IDX_GRID_SYMBOL, Row]);

           selectedSymbol := symbol;

           if simulationType = SIMULATION_TYPE_INDICATORS then
           begin

           indicatorSimulationResultsInSample := runIndicatorSimulation(   indicatorEntryPatterns[StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER, Row])-1],
                                                                  indicatorClosePatterns[StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER, Row])-1],
                                                                  symbol,
                                                                  SimulationForm.useSLCheck.Checked,
                                                                  SimulationForm.useTPCheck.Checked,
                                                                  SimulationForm.BeginInSampleCalendar.Date,
                                                                  SimulationForm.EndInSampleCalendar.Date,
                                                                  true);

           indicatorSimulationResults := runIndicatorSimulation(           indicatorEntryPatterns[StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER, Row])-1],
                                                                  indicatorClosePatterns[StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER, Row])-1],
                                                                  symbol,
                                                                  SimulationForm.useSLCheck.Checked,
                                                                  SimulationForm.useTPCheck.Checked,
                                                                  SimulationForm.BeginInSampleCalendar.Date,
                                                                  Now,
                                                                  false);

          BalanceCurve.Clear;
          BalanceCurveFit.Clear;
          BalanceCurvePortfolio.Clear;
          BalanceCurveFitPortfolio.Clear;
          upperStdDev.Clear;
          lowerStdDev.Clear;
          ME_Longs.Clear;
          ME_Shorts.Clear;

          for i:=0 to Length(tradeLines)-1 do
          begin
               ChartOHLC.DeleteSeries(tradeLines[i]);
               tradeLines[i].Free;
          end;

          GraphOHLC_Up.Clear;
          GraphOHLC_Up.Source.YCount := 5;
          GraphOHLC_Down.Clear;
          GraphOHLC_Down.Source.YCount := 5;
          GraphOpenTrades.Clear ;
          GraphCloseTrades.Clear ;
          GraphOpenTrades.Source.YCount := 2;
          GraphCloseTrades.Source.YCount := 2;
          tradeLines := nil;

          for i := 0 to Length(LoadedIndiHistoryData[symbol].OHLC)-1 do
          begin

               if LoadedIndiHistoryData[symbol].OHLC[i].close > LoadedIndiHistoryData[symbol].OHLC[i].open then
               begin
                    ylist[0] := LoadedIndiHistoryData[symbol].OHLC[i].open;
                    ylist[1] := (LoadedIndiHistoryData[symbol].OHLC[i].open+LoadedIndiHistoryData[symbol].OHLC[i].close)/2;
                    ylist[4] := LoadedIndiHistoryData[symbol].OHLC[i].high;
                    ylist[3] := LoadedIndiHistoryData[symbol].OHLC[i].low;
                    ylist[2] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    GraphOHLC_Up.AddXY(LoadedIndiHistoryData[symbol].Time[i]*100/LoadedIndiHistoryData[symbol].pointConversion, ylist[4], ylist) ;
                    ylist[0] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    ylist[1] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    ylist[4] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    ylist[3] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    ylist[2] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    GraphOHLC_Down.AddXY(LoadedIndiHistoryData[symbol].Time[i]*100/LoadedIndiHistoryData[symbol].pointConversion, ylist[4], ylist)
               end else
               begin
                    ylist[0] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    ylist[2] := LoadedIndiHistoryData[symbol].OHLC[i].open;
                    ylist[4] := LoadedIndiHistoryData[symbol].OHLC[i].high;
                    ylist[3] := LoadedIndiHistoryData[symbol].OHLC[i].low;
                    ylist[1] := (LoadedIndiHistoryData[symbol].OHLC[i].open+LoadedIndiHistoryData[symbol].OHLC[i].close)/2;
                    GraphOHLC_Down.AddXY(LoadedIndiHistoryData[symbol].Time[i]*100/LoadedIndiHistoryData[symbol].pointConversion, ylist[4], ylist) ;
                    ylist[0] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    ylist[1] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    ylist[4] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    ylist[3] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    ylist[2] := LoadedIndiHistoryData[symbol].OHLC[i].close;
                    GraphOHLC_Up.AddXY(LoadedIndiHistoryData[symbol].Time[i]*100/LoadedIndiHistoryData[symbol].pointConversion, ylist[4], ylist)  ;
               end;
          end;

          // plot long trade ME
          for i:= 0 to Length(indicatorSimulationResultsInSample.MFE_Longs)-1 do
          begin
                    ME_Longs.AddXY(i, indicatorSimulationResultsInSample.MFE_Longs[i]-indicatorSimulationResultsInSample.MUE_Longs[i]);
                    ME_Shorts.AddXY(i, indicatorSimulationResultsInSample.MFE_Shorts[i]-indicatorSimulationResultsInSample.MUE_Shorts[i]);
          end;

          Chart1.AxisList[1].Marks.Source := BalanceCurve.Source;

          TradeGrid.RowCount := 1;

          if MenuItem29.Checked then
          begin
               StatusLabel.Caption := 'Creating trade table entries';
               StatusLabel.Visible := true;
               ProgressBar1.Position := 0;
               ProgressBar1.Max := Length(indicatorSimulationResults.balanceCurve)-1;
          end;

          zeroLine.Position := INITIAL_BALANCE;

          inSampleEndLine.Position := SimulationForm.EndInSampleCalendar.Date;
          OutOfSampleEndLine.Position := SimulationForm.EndOutOfSampleCalendar.Date;


          for i:= 1 to Length(indicatorSimulationResults.balanceCurve)-1 do
          begin

          if indicatorSimulationResults.trades[i-1].orderType = BUY then  positionType := 'BUY' else positionType := 'SELL';

          ylistBubble[0] := 10/LoadedIndiHistoryData[symbol].pointConversion;
          ylistBubble[1] := indicatorSimulationResults.trades[i-1].openPrice*1.03;

          GraphOpenTrades.AddXY(indicatorSimulationResults.trades[i-1].openTime*100/LoadedIndiHistoryData[symbol].pointConversion, ylistBubble[1], ylistBubble, DateTimeToStr(indicatorSimulationResults.trades[i-1].openTime) + '- open ' + IntToStr(i));

          ylistBubble[0] := 10/LoadedIndiHistoryData[symbol].pointConversion;
          ylistBubble[1] := indicatorSimulationResults.trades[i-1].closePrice*0.97;

          GraphCloseTrades.AddXY(indicatorSimulationResults.trades[i-1].closeTime*100/LoadedIndiHistoryData[symbol].pointConversion, ylistBubble[1], ylistBubble, DateTimeToStr(indicatorSimulationResults.trades[i-1].closeTime) + '- close ' + IntToStr(i));

          SetLength(tradeLines, Length(tradeLines)+1);

          tradeLines[Length(tradeLines)-1] := TLineSeries.Create(ChartOHLC);

          with tradeLines[Length(tradeLines)-1]  do begin
          LinePen.Width := 3;

          if indicatorSimulationResults.trades[i-1].profit > 0 then
          LinePen.Color := clGreen else
          LinePen.Color := clRed;

          AddXY(indicatorSimulationResults.trades[i-1].openTime*100/LoadedIndiHistoryData[symbol].pointConversion, indicatorSimulationResults.trades[i-1].openPrice) ;
          AddXY(indicatorSimulationResults.trades[i-1].closeTime*100/LoadedIndiHistoryData[symbol].pointConversion, indicatorSimulationResults.trades[i-1].closePrice) ;
          end;

          ChartOHLC.AddSeries(tradeLines[Length(tradeLines)-1]);
          ChartOHLC.Repaint;

          //this line draws the balance curve
          BalanceCurve.AddXY(indicatorSimulationResults.trades[i-1].closeTime, indicatorSimulationResults.balanceCurve[i], FormatDateTime('mm/yyyy', indicatorSimulationResults.trades[i-1].closeTime));

          if indicatorSimulationResultsInSample.linearFitR2 > 0.1 then
          begin
          upperStdDev.AddXY(indicatorSimulationResults.trades[i-1].closeTime, indicatorSimulationResultsInSample.linearFitSlope*(indicatorSimulationResults.trades[i-1].closeTime-indicatorSimulationResults.trades[0].closeTime) + indicatorSimulationResultsInSample.linearFitIntercept - indicatorSimulationResultsInSample.standardDeviationResiduals, FormatDateTime('mm/yyyy', indicatorSimulationResults.trades[i-1].closeTime)) ;
          lowerStdDev.AddXY(indicatorSimulationResults.trades[i-1].closeTime, indicatorSimulationResultsInSample.linearFitSlope*(indicatorSimulationResults.trades[i-1].closeTime-indicatorSimulationResults.trades[0].closeTime) + indicatorSimulationResultsInSample.linearFitIntercept - indicatorSimulationResultsInSample.standardDeviationResiduals*2, FormatDateTime('mm/yyyy', indicatorSimulationResults.trades[i-1].closeTime)) ;
          BalanceCurveFit.AddXY(indicatorSimulationResults.trades[i-1].closeTime, indicatorSimulationResultsInSample.linearFitSlope*(indicatorSimulationResults.trades[i-1].closeTime-indicatorSimulationResults.trades[0].closeTime) + indicatorSimulationResultsInSample.linearFitIntercept, FormatDateTime('mm/yyyy', indicatorSimulationResults.trades[i-1].closeTime));
          end;

            if MenuItem29.Checked then
            begin

               StatusLabel.Caption := 'Creating trade table entries ' + IntToStr(i) + '/' + IntToStr(Length(indicatorSimulationResults.balanceCurve)-1) ;
               ProgressBar1.Position := ProgressBar1.Position + 1;

               if i Mod 10 = 0 then
               Application.ProcessMessages;

               TradeGrid.RowCount := TradeGrid.RowCount + 1;
               TradeGrid.Cells[0, TradeGrid.RowCount-1] := IntToStr(i);
               TradeGrid.Cells[1, TradeGrid.RowCount-1] := DateTimeToStr(indicatorSimulationResults.trades[i-1].openTime);
               TradeGrid.Cells[2, TradeGrid.RowCount-1] := DateTimeToStr(indicatorSimulationResults.trades[i-1].closeTime);
               TradeGrid.Cells[3, TradeGrid.RowCount-1] := FloatToStr(Round(indicatorSimulationResults.trades[i-1].openPrice*100000)/100000);
               TradeGrid.Cells[4, TradeGrid.RowCount-1] := FloatToStr(Round(indicatorSimulationResults.trades[i-1].closePrice*100000)/100000);
               TradeGrid.Cells[5, TradeGrid.RowCount-1] := FloatToStr(Round(indicatorSimulationResults.trades[i-1].SL*100000)/100000) + ' (' + FloatToStr(Round(Abs(indicatorSimulationResults.trades[i-1].openPrice-indicatorSimulationResults.trades[i-1].SL)*100000)/100000) + ')' ;
               TradeGrid.Cells[6, TradeGrid.RowCount-1] := FloatToStr(Round(indicatorSimulationResults.trades[i-1].TP*100000)/100000) + ' (' + FloatToStr(Round(Abs(indicatorSimulationResults.trades[i-1].openPrice-indicatorSimulationResults.trades[i-1].TP)*100000)/100000) + ')' ;
               TradeGrid.Cells[7, TradeGrid.RowCount-1] := FloatToStr(Round(indicatorSimulationResults.trades[i-1].profit*100)/100);
               TradeGrid.Cells[8, TradeGrid.RowCount-1] := positionType;

               TradeGrid.Cells[9, TradeGrid.RowCount-1] := FloatToStr(Round(indicatorSimulationResults.trades[i-1].volume*100)/100);



            end;

          end;

          Chart1.AxisList.BottomAxis.Range.Max:= indicatorSimulationResults.trades[Length(indicatorSimulationResults.trades)-1].closeTime;
          Chart1.AxisList.BottomAxis.Range.Min:= indicatorSimulationResults.trades[0].closeTime ;

          // only show this info on trade analysis on click
          if MenuItem29.Checked then
          begin
               ChartOHLC.Visible := true;
               LabelCheck.Visible := true;
               Button2.Visible := true;
               ohlcCheck.Visible := true;
          end;

           end;

          // ShowMessage(FloatToStr(simulationResults.balanceCurve[Length(simulationResults.balanceCurve)-1])) ;


          //StatusLabel.Visible := false;

        end;

end;

procedure TMainForm.showOrHideColumn(Sender: TObject);
var
  i: integer;
begin

  if Sender is TMenuItem then
      begin
       with Sender as TMenuItem do
       begin
            for i := 0 to ResultsGrid.ColCount-1 do
            begin

                 if (ResultsGrid.Columns.Items[i].Title.Caption = Caption) and (ResultsGrid.Columns.Items[i].Visible = false) then
                 begin
                 ResultsGrid.Columns.Items[i].Visible := true;
                 Checked := true;
                 break;
                 end;

                 if (ResultsGrid.Columns.Items[i].Title.Caption = Caption) and (ResultsGrid.Columns.Items[i].Visible) then
                 begin
                 ResultsGrid.Columns.Items[i].Visible := false;
                 Checked := false;
                 break;
                 end;

            end;
       end;

      end;
end;

 procedure TMainForm.LinearLeastSquares(data: TRealPointArray; var M,B, R: extended);
var
  SumY, SumX, SumX2,SumXY,SumY2: extended;
  Sx,Sy :extended;
  n, i: Integer;
begin
  if SimulationForm.LROriginCheck.Checked then
  begin;
  n := Length(data); {number of points}
  SumY := 0.0;
  SumX2 := 0.0;
  SumXY := 0.0; Sx := 0.0; Sy := 0.0;

  for i := 0 to n - 1 do
  begin
    SumY := SumY + (data[i].Y-INITIAL_BALANCE);
    SumX2 := SumX2 + (data[i].X-data[0].x)*(data[i].X-data[0].x);
    SumXY := SumXY + (data[i].X-data[0].x)*(data[i].Y-INITIAL_BALANCE);
  end;

  SumY := SumY/n;

  M := 0;
  R := 0;

    if SumX2 <> 0 then
    M:=(SumXY)/SumX2;  {Slope M}

    B:= INITIAL_BALANCE;  {Intercept B}
    for i := 0 to n - 1 do
    begin
         Sx := Sx+((data[i].Y-INITIAL_BALANCE)-M*(data[i].X-data[0].x))*((data[i].Y-INITIAL_BALANCE)-M*(data[i].X-data[0].x)) ;
         Sy := Sy+ (data[i].Y-INITIAL_BALANCE-SumY)*(data[i].Y-INITIAL_BALANCE-SumY)
    end;

    if Sy <> 0 then
    R:=1-(Sx/Sy);

  end else
  begin

  n := Length(data); {number of points}
  SumX := 0.0;  SumY := 0.0;
  SumX2 := 0.0;  SumY2:=0.0;
  SumXY := 0.0;

  for i := 0 to n - 1 do
  with data[i] do
  begin
    SumX := SumX + (X-data[0].x);
    SumY := SumY + Y;
    SumX2 := SumX2 + (X-data[0].x)*(X-data[0].x);
    SumY2 := SumY2 + Y*Y;
    SumXY := SumXY + (X-data[0].x)*Y;
  end;

  if (n*SumX2=SumX*SumX) or (n*SumY2=SumY*SumY)
  then
  begin
    M:=0;
    B:=0;
  end
  else
  begin
    M:=((n * SumXY) - (SumX * SumY)) / ((n * SumX2) - (SumX * SumX));  {Slope M}
    B:=(sumy-M*sumx)/n;  {Intercept B}
    Sx:=sqrt(Sumx2-sqr(sumx)/n);
    Sy:=Sqrt(Sumy2-sqr(Sumy)/n);
    r:=(Sumxy-Sumx*sumy/n)/(Sx*sy);
    //RSquared:=r*r;
  end;

  end;

end;

  procedure TMainForm.LinearLeastSquaresNormal(data: TRealPointArray; var M,B, R: extended);
var
  SumY, SumX, SumX2,SumXY,SumY2: extended;
  Sx,Sy :extended;
  n, i: Integer;
begin

  n := Length(data); {number of points}
  SumX := 0.0;  SumY := 0.0;
  SumX2 := 0.0;  SumY2:=0.0;
  SumXY := 0.0;

  for i := 0 to n - 1 do
  with data[i] do
  begin
    SumX := SumX + (X-data[0].x);
    SumY := SumY + Y;
    SumX2 := SumX2 + (X-data[0].x)*(X-data[0].x);
    SumY2 := SumY2 + Y*Y;
    SumXY := SumXY + (X-data[0].x)*Y;
  end;

  if (n*SumX2=SumX*SumX) or (n*SumY2=SumY*SumY)
  then
  begin
    M:=0;
    B:=0;
  end
  else
  begin
    M:=((n * SumXY) - (SumX * SumY)) / ((n * SumX2) - (SumX * SumX));  {Slope M}
    B:=(sumy-M*sumx)/n;  {Intercept B}
    Sx:=sqrt(Sumx2-sqr(sumx)/n);
    Sy:=Sqrt(Sumy2-sqr(Sumy)/n);
    r:=(Sumxy-Sumx*sumy/n)/(Sx*sy);
    //RSquared:=r*r;
  end;


end;


procedure TMainForm.ResultsGridCompareCells(Sender: TObject; ACol, ARow, BCol,
  BRow: Integer; var Result: integer);
begin
 //  if Assigned(ResultsGrid.OnCompareCells) then
 //   Result:=inherited DoCompareCells(Acol, ARow, Bcol, BRow)
 // else begin
    try
       Result := CompareValue(StrToFloat(ResultsGrid.Cells[ACol,ARow]), StrToFloat(ResultsGrid.Cells[BCol,BRow]));
    Except
       Result:=AnsiCompareText(ResultsGrid.Cells[ACol,ARow], ResultsGrid.Cells[BCol,BRow]);
    end;
       if ResultsGrid.SortOrder=soDescending then
      result:=-result;
  end;

procedure TMainForm.ResultsGridGetCellHint(Sender: TObject; ACol,
  ARow: Integer; var HintText: String);
begin
     Case ACol of
  IDX_GRID_USE_IN_PORTFOLIO: HintText := 'Check to include system in custom portfolio to evaluate.';
  IDX_GRID_RESULT_NUMBER :    HintText := 'The result number for this system';
  IDX_GRID_SYMBOL:               HintText := 'Symbol used to create this system';
  IDX_GRID_PROFIT:               HintText := 'Absolute profit in USD';
  IDX_GRID_PROFIT_PER_TRADE:   HintText := 'Profit per trade in USD';
  IDX_GRID_PROFIT_LONGS:        HintText := 'Number of profitable long trades';
  IDX_GRID_PROFIT_SHORTS:        HintText := 'Number of profitable short trades';
  IDX_GRID_LONG_COUNT:         HintText := 'Total number of long trades';
  IDX_GRID_SHORT_COUNT:       HintText := 'Total number of short trades';
  IDX_GRID_TOTAL_COUNT:        HintText := 'Total trade number';
  IDX_GRID_MAX_DRAWDOWN:       HintText := 'Maximum drawdown as a percentage of the initial balance';
  IDX_GRID_ULCER_INDEX :        HintText := 'Ulcer Index as devised by Peter Martin';
  IDX_GRID_MAX_DRAWDOWN_LENGTH: HintText := 'Maximum period length between balance highs in days';
  IDX_GRID_CONS_LOSS:           HintText := 'Maximum number of consecutive losing trades';
  IDX_GRID_CONS_WIN:           HintText := 'Maximum number of consecutive winning trades';
  IDX_GRID_PROFIT_TO_DD_RATIO:  HintText := 'Absolute profit to maximum draw down ratio (do not confuse with AAR/MaxDD)';
  IDX_GRID_WINNING_PERCENT:    HintText := 'Winning percentage from the total number of trades';
  IDX_GRID_REWARD_TO_RISK :    HintText := 'Average win to loss ratio';
  IDX_GRID_SKEWNESS :            HintText := 'A measure of the extent to which the trade return distribution is skewed relative to a normal distribution';
  IDX_GRID_KURTOSIS :          HintText := 'A measure of how peaked or "fat tailed" a statistical distribution is';
  IDX_GRID_PROFIT_FACTOR :      HintText := 'Ratio between gross profit and gross loss';
  IDX_GRID_STD_DEV :            HintText := 'Standard deviation of all trades';
  IDX_GRID_STD_DEV_BREACH:     HintText := 'Maximum level of multiples of the standard deviation of residuals of the linear regression that have been breached by the balance curve';
  IDX_GRID_TOTAL_ME :           HintText := 'Total sum of all long and short mathematical expectancy values';
  IDX_GRID_LINEAR_FIT_R2:        HintText := 'Square of the correlation coefficient for the calculated linear regression';
  IDX_GRID_SQN:                  HintText := 'System Quality Number as defined by Van Tharp ';
  IDX_GRID_MODIFIED_SHARPE_RATIO:HintText := 'Absolute profit over standard deviation';
  IDX_GRID_CUSTOM_CRITERIA:      HintText := 'Custom criteria defined by the user (see menu)';
  IDX_GRID_OUT_OF_SAMPLE_PROFIT :HintText := 'Absolute profit of the out of sample period';
  IDX_GRID_OSP_PER_TRADE:        HintText := 'Absolute profit per trade for the out of sample period';
  IDX_GRID_DAYS_OUT:             HintText := 'Number of days that the system remained out of the market';
  end;
end;

procedure TMainForm.TabSheet1Exit(Sender: TObject);
begin

end;

procedure TMainForm.TabSheet1Show(Sender: TObject);
begin
end;

//end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  isCancel := true;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  ChartOHLC.Visible := false;
  Button2.Visible := false;
  LabelCheck.Visible := false;
  ohlcCheck.Visible := false;
end;

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  configFile: TStringList;
  i: integer;
begin

  DefaultFormatSettings.ShortDateFormat 	 := 'yyyy.mm.dd' ;
  DefaultFormatSettings.DateSeparator 	         := '.' ;
  DefaultFormatSettings.DecimalSeparator 	 := '.' ;

  SetCurrentDir(mainProgramFolder);

  configFile := TStringList.Create;


   for i := 1 to SimulationForm2.OptionsGrid.RowCount-1 do
   configFile.Add(SimulationForm2.OptionsGrid.Cells[1,i]);

   for i := 1 to FiltersForm.FiltersGrid.RowCount-1  do
   begin
   configFile.Add(FiltersForm.FiltersGrid.Cells[1,i]);
   configFile.Add(FiltersForm.FiltersGrid.Cells[2,i]);
   configFile.Add(FiltersForm.FiltersGrid.Cells[3,i]);
   configFile.Add(FiltersForm.FiltersGrid.Cells[4,i]);
   end;

   configFile.Add(CustomFilterForm.CustomFormulaEdit.Text);
   configFile.Add(DateTimeToStr(SimulationForm2.BeginInSampleCalendar.Date));
   configFile.Add(DateTimeToStr(SimulationForm2.EndInSampleCalendar.Date));
   configFile.Add(DateTimeToStr(SimulationForm2.EndOutOfSampleCalendar.Date));
   configFile.Add(IntToStr(SimulationForm2.OptTargetComboBox.ItemIndex));
   configFile.Add(BoolToStr(SimulationForm2.UseSLCheck.Checked));
   configFile.Add(BoolToStr(SimulationForm2.UseTPCheck.Checked));
   configFile.Add(BoolToStr(SimulationForm2.UseHourFilter.Checked));
   configFile.Add(BoolToStr(SimulationForm2.UseDayFilter.Checked));
   configFile.Add(BoolToStr(SimulationForm2.LROriginCheck.Checked));
   configFile.Add(BoolToStr(SimulationForm2.UseFixedSLTP.Checked));
   configFile.Add(BoolToStr(SimulationForm2.UseFixedHour.Checked));

   for i:= 0 to ResultsGrid.ColCount-1 do
   configFile.Add(BoolToStr(ResultsGrid.Columns.Items[i].Visible));

   configFile.Add(BoolToStr(FiltersForm.isLastYearProfitCheck.Checked));

   configFile.SaveToFile('config.ini');

   configFile.Free;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin

end;

procedure TMainForm.FormShow(Sender: TObject);
begin
   MainForm.Enabled := false ;
end;

procedure TMainForm.LabelCheckChange(Sender: TObject);
begin
  if LabelCheck.Checked then
  begin
     GraphOpenTrades.Marks.Visible:= true;
     GraphCloseTrades.Marks.Visible:= true;
  end;

  if LabelCheck.Checked = false then
  begin
     GraphOpenTrades.Marks.Visible:= false;
     GraphCloseTrades.Marks.Visible:= false;
  end;
end;

procedure TMainForm.MenuItem11Click(Sender: TObject);
begin


  Case simulationType of
    SIMULATION_TYPE_INDICATORS    : ShowIndicatorPatternDecomposition;
  else ShowMessage('no valid simulation type selected');
  end;


end;

procedure TMainForm.MenuItem12Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem13Click(Sender: TObject);
begin

     if SaveDialog1.Execute then
      ResultsGrid.SaveToCSVFile(SaveDialog1.FileName);
end;

procedure TMainForm.MenuItem16Click(Sender: TObject);
var
  i: integer;
begin

  if CheckBeforeSimulation = false then Exit;
  //SimulationForm.EndOutOfSampleCalendar.Date := now;

  // match everything between normal and ghost forms
  for i := 1 to SimulationForm2.OptionsGrid.RowCount-1 do
   begin
   SimulationForm.OptionsGrid.Cells[1,i] := SimulationForm2.OptionsGrid.Cells[1,i];
   end;

  if isDataLoaded = false then
  Exit;

  Case simulationType of
    SIMULATION_TYPE_INDICATORS    : runIndiSimulationFixedQuota(false);
  else ShowMessage('no valid simulation type selected');
  end;

end;

procedure TMainForm.MenuItem17Click(Sender: TObject);
begin

  if CheckBeforeSimulation = false then Exit;

  //SimulationForm.EndOutOfSampleCalendar.Date := now;

  if isDataLoaded = false then
  Exit;

  Case simulationType of
    SIMULATION_TYPE_INDICATORS    : runIndiSimulationFixedQuota(true);
  else ShowMessage('no valid simulation type selected');
  end;

end;

procedure TMainForm.MenuItem18Click(Sender: TObject);
begin
  FiltersForm.Visible := true ;
end;

procedure TMainForm.MenuItem19Click(Sender: TObject);
begin
  CustomFilterForm.Visible := true;
end;

procedure TMainForm.MenuItem20Click(Sender: TObject);
begin
  OpenURL('http://newsite.asirikuy.com');
  ShowMessage('OpenKantu, an open source price-action based system generator made by Daniel Fernandez. Copyright Asirikuy 2013-2014. Visit Asirikuy.com for more information');
end;


procedure TMainForm.MenuItem23Click(Sender: TObject);
begin
  ExportToMQL4;
end;

procedure TMainForm.MenuItem24Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  TradeGrid.SaveToCSVFile(SaveDialog1.FileName);
end;


procedure TMainForm.MenuItem27Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  Chart1.SaveToBitmapFile(SaveDialog1.FileName);
end;

procedure TMainForm.MenuItem28Click(Sender: TObject);
var
  i: integer;
begin

  if CheckBeforeSimulation = false then Exit;

  if isDataLoaded = false then
  Exit;

  for i := 1 to SimulationForm2.OptionsGrid.RowCount-1 do
   begin
   SimulationForm.OptionsGrid.Cells[1,i] := SimulationForm2.OptionsGrid.Cells[1,i];
   end;

  Case simulationType of
    SIMULATION_TYPE_INDICATORS    : runIndicatorSimulationFixedQuotaMultipleSymbols;
  else ShowMessage('no valid simulation type selected');
  end;

end;

procedure TMainForm.MenuItem29Click(Sender: TObject);
begin
   if MenuItem29.Checked = false then
   begin
      MenuItem29.Checked := true;
      Exit;
   end;
   if MenuItem29.Checked = true then
   begin
      MenuItem29.Checked := false;
      Exit;
   end;
end;

procedure TMainForm.MenuItem30Click(Sender: TObject);
begin

  Case simulationType of
    SIMULATION_TYPE_INDICATORS    : ShowIndicatorPatternPortfolioResult;
  else ShowMessage('no valid simulation type selected');
  end;

end;

procedure TMainForm.MenuItem35Click(Sender: TObject);
begin
  SingleSystem.Visible := true;
end;

procedure TMainForm.MenuItem38Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem3Click(Sender: TObject);
begin
  SimulationForm2.Visible := true;
end;

procedure TMainForm.ExportToMQL4;
var
  i: integer;
  Code_MQL4: TStringList;
  template_MQL4: TStringList;
  selectedPattern: integer;
  priceEntryPattern: TIndicatorPattern;
  maxShiftUsed: integer;

  begin

     selectedPattern :=  StrToInt(selectedPatternLabel.Caption);

     priceEntryPattern := indicatorEntryPatterns[selectedPattern];

     maxShiftUsed :=0;

     for i:=0 to Length(priceEntryPattern.tradingRules)-1 do
     begin
          if priceEntryPattern.tradingRules[i][IDX_FIRST_INDICATOR_SHIFT]+1 > maxShiftUsed then
          maxShiftUsed := priceEntryPattern.tradingRules[i][IDX_FIRST_INDICATOR_SHIFT]+1;

          if priceEntryPattern.tradingRules[i][IDX_SECOND_INDICATOR_SHIFT]+1 > maxShiftUsed then
          maxShiftUsed := priceEntryPattern.tradingRules[i][IDX_SECOND_INDICATOR_SHIFT]+1;
     end;

     template_MQL4 := TStringList.Create;
     Code_MQL4     := TStringList.Create;

     if SaveDialogMQL4.Execute then
     begin

          SetCurrentDir(mainProgramFolder);
          template_MQL4.LoadFromFile('kantu_template.mq4');

          for i := 0 to template_MQL4.Count - 1 do
          begin

               if (((template_MQL4.Strings[i] <> 'extern double TAKE_PROFIT         = 0;') or (SimulationForm.UseTPCheck.Checked = False)) and
                   ((template_MQL4.Strings[i] <> 'extern double STOP_LOSS           = 0;') or (SimulationForm.UseSLCheck.Checked = False))) then
               Code_MQL4.Add(template_MQL4.Strings[i]);

                if (template_MQL4.Strings[i] = '//addOpenKantuVersion') then
                Code_MQL4.Add('#define COMPONENT_VERSION     "KT_v'+KANTU_VERSION+'"');

                if (template_MQL4.Strings[i] = '//insertInstanceID') then
                Code_MQL4.Add('extern int    INSTANCE_ID         = ' +IntToStr(RandomRange(12345, 12345+25000))+ ' ;');

                if (template_MQL4.Strings[i] = '//defineMaxShiftNeeded') then
               Code_MQL4.Add('int g_maxShift = '+IntToStr(maxShiftUsed) + ' ;');

               if (template_MQL4.Strings[i] = '// insertDayFilter') and (SimulationForm.UseDayFilter.Checked) then
               Code_MQL4.Add('if(DayOfWeek() != ' + IntToStr(priceEntryPattern.dayFilter) + '){return(PATTERN_NONE);}');

               if (template_MQL4.Strings[i] = 'extern double TAKE_PROFIT         = 0;') and (SimulationForm.UseTPCheck.Checked) then
               Code_MQL4.Add('extern double TAKE_PROFIT         = ' + FloatToStr(priceEntryPattern.TP) + ';');

               if (template_MQL4.Strings[i] = 'extern double STOP_LOSS           = 0;') and (SimulationForm.UseSLCheck.Checked) then
               Code_MQL4.Add('extern double STOP_LOSS           = ' + FloatToStr(priceEntryPattern.SL) + ';');

               if (template_MQL4.Strings[i] = '// insertHourFilter') and (SimulationForm.UseHourFilter.Checked) then
               Code_MQL4.Add('if(Hour() != ' + IntToStr(priceEntryPattern.hourFilter) + '){return(PATTERN_NONE);}') ;

               if template_MQL4.Strings[i] = '//insertLongEntryLogic' then
               pricePatternToMQL4(Code_MQL4, priceEntryPattern, BUY);

               if template_MQL4.Strings[i] = '//insertShortEntryLogic' then
               pricePatternToMQL4(Code_MQL4, priceEntryPattern, SELL);

               if (template_MQL4.Strings[i] = '//noExitPatternInsertReturn') then
               Code_MQL4.Add('return(PATTERN_NONE);');
          end;

          Code_MQL4.SaveToFile(SaveDialogMQL4.FileName);
     end;

     template_MQL4.Free;
     Code_MQL4.Free;

end;



procedure TMainForm.pricePatternToMQL4(var Code_MQL4: TStringList; pricePattern: TIndicatorPattern; logic: integer);
var
  i, j: integer;
  directionString: string;
  logicType: integer;
  typeString1, typeString2, firstShift, secondShift: string;
begin


         for j:= 0 to Length(pricePattern.tradingRules)-1 do
         begin

         firstShift      := FloatToStr(pricePattern.tradingRules[j][IDX_FIRST_INDICATOR_SHIFT]+1);
         secondShift     := FloatToStr(pricePattern.tradingRules[j][IDX_SECOND_INDICATOR_SHIFT]+1);

         if (Code_MQL4.Strings[Code_MQL4.Count-1] <> '&&')  and (Code_MQL4.Strings[Code_MQL4.Count-1][1] <> '/') then
         begin
            Code_MQL4.Add('&&');
         end;

         if (logic = SHORT_EXIT) or (logic = LONG_ENTRY) then
         begin

       Case pricePattern.tradingRules[j][IDX_FIRST_INDICATOR] of
       0 : typeString1 := 'Open';
       1 : typeString1 := 'High';
       2 : typeString1 := 'Low';
       3 : typeString1 := 'Close';
       end;

       Case pricePattern.tradingRules[j][IDX_SECOND_INDICATOR] of
       0 : typeString2 := 'Open';
       1 : typeString2 := 'High';
       2 : typeString2 := 'Low';
       3 : typeString2 := 'Close';
       end;

       if (pricePattern.tradingRules[j][IDX_FIRST_INDICATOR]<> 4) and (pricePattern.tradingRules[j][IDX_FIRST_INDICATOR] <> 5) then
       Code_MQL4.Add(typeString1 +'[' + firstShift + ']' + ' > ' + typeString2 +'[' + secondShift + ']') else
       Code_MQL4.Add(typeString1  + ' > ' + typeString2) ;

       end;

    if (logic = LONG_EXIT) or (logic = SHORT_ENTRY) then
    begin

       Case pricePattern.tradingRules[j][IDX_FIRST_INDICATOR] of
       0 : typeString1 := 'Open';
       1 : typeString1 := 'Low';
       2 : typeString1 := 'High';
       3 : typeString1 := 'Close';
       end;

       Case pricePattern.tradingRules[j][IDX_SECOND_INDICATOR] of
       0 : typeString2 := 'Open';
       1 : typeString2 := 'Low';
       2 : typeString2 := 'High';
       3 : typeString2 := 'Close';
       end;

       if (pricePattern.tradingRules[j][IDX_FIRST_INDICATOR] <> 4) and (pricePattern.tradingRules[j][IDX_FIRST_INDICATOR] <> 5) then
       Code_MQL4.Add(typeString1 +'[' + firstShift + ']' + ' < ' + typeString2 +'[' + secondShift + ']') else
       Code_MQL4.Add(typeString1  + ' > ' + typeString2) ;

    end;
         end;

end;

procedure TMainForm.addPricePatternLogic(var F4_Code: TStringList; pricePattern: TIndicatorPattern; logic: integer; useLibrary: boolean; strategyNumber: integer);
var
  i, j, logicType: integer;
  firstIndicator, secondIndicator, firstShift, secondShift: string;
  typeString1, typeString2: string;
begin

  if SimulationForm.UseSLCheck.Checked then
  F4_Code.Add('// pattern SL= ' + FloatToStr(pricepattern.SL));

  if SimulationForm.UseTPCheck.Checked then
  F4_Code.Add('// pattern TP= ' + FloatToStr(pricepattern.TP));

   F4_Code.Add('if (');

   case logic of
   LONG_EXIT  : F4_Code.Add('(pParams->openOrdersCount[BUY] != 0) && ');
   SHORT_EXIT : F4_Code.Add('(pParams->openOrdersCount[SELL] != 0) && ');
   end;

   if (SimulationForm.UseDayFilter.Checked) then
   F4_Code.Add('(dayOfWeek() == ' + IntToStr(pricePattern.dayFilter) + ') &&') ;

   if (SimulationForm.UseHourFilter.Checked) then
   F4_Code.Add('(hour() == ' + IntToStr(pricePattern.hourFilter) + ') &&');

    F4_Code.Add('(tradingStrategyUsed == ' + IntToStr(strategyNumber) + ')');

    for j:= 0 to Length(pricePattern.tradingRules)-1 do
    begin

    firstIndicator  := FloatToStr(pricePattern.tradingRules[j][IDX_FIRST_INDICATOR]);
    secondIndicator := FloatToStr(pricePattern.tradingRules[j][IDX_SECOND_INDICATOR]);
    firstShift      := FloatToStr(pricePattern.tradingRules[j][IDX_FIRST_INDICATOR_SHIFT]+1);
    secondShift     := FloatToStr(pricePattern.tradingRules[j][IDX_SECOND_INDICATOR_SHIFT]+1);

    F4_Code.Add('&&');

    if (logic = SHORT_EXIT) or (logic = LONG_ENTRY) then
    begin

       Case pricePattern.tradingRules[j][IDX_FIRST_INDICATOR] of
       0 : typeString1 := 'cOpen';
       1 : typeString1 := 'high';
       2 : typeString1 := 'low';
       3 : typeString1 := 'cClose';
       end;

       Case pricePattern.tradingRules[j][IDX_SECOND_INDICATOR] of
       0 : typeString2 := 'cOpen';
       1 : typeString2 := 'high';
       2 : typeString2 := 'low';
       3 : typeString2 := 'cClose';
       end;

       F4_Code.Add(typeString1 +'(' + firstShift + ')' + ' > ' + typeString2 +'(' + secondShift + ')');

    end;

    if (logic = LONG_EXIT) or (logic = SHORT_ENTRY) then
    begin

       Case pricePattern.tradingRules[j][IDX_FIRST_INDICATOR] of
       0 : typeString1 := 'cOpen';
       1 : typeString1 := 'low';
       2 : typeString1 := 'high';
       3 : typeString1 := 'cClose';
       end;

       Case pricePattern.tradingRules[j][IDX_SECOND_INDICATOR] of
       0 : typeString2 := 'cOpen';
       1 : typeString2 := 'low';
       2 : typeString2 := 'high';
       3 : typeString2 := 'cClose';
       end;

       if (pricePattern.tradingRules[j][IDX_FIRST_INDICATOR] <> 4) and (pricePattern.tradingRules[j][IDX_FIRST_INDICATOR] <> 5) then
       F4_Code.Add(typeString1 +'(' + firstShift + ')' + ' < ' + typeString2 +'(' + secondShift + ')') else
       F4_Code.Add(typeString1 +'(' + firstShift + ')' + ' > ' + typeString2 +'(' + secondShift + ')')

    end;

    end;

  F4_Code.Add(')');

  F4_Code.Add('{');

  if (useLibrary = false) then
  begin
       case logic of
       LONG_ENTRY : F4_Code.Add('openOrUpdateLongTrade(pParams, PRIMARY_RATES, stopLoss, takeProfit, USE_INTERNAL_SL, USE_INTERNAL_TP);');
       SHORT_ENTRY: F4_Code.Add('openOrUpdateShortTrade(pParams, PRIMARY_RATES, stopLoss, takeProfit, USE_INTERNAL_SL, USE_INTERNAL_TP);');
       LONG_EXIT  : F4_Code.Add('returnCode = closeLongTrade(pParams);');
       SHORT_EXIT : F4_Code.Add('returnCode = closeShortTrade(pParams);');
       end;
  end;

if (useLibrary) then F4_Code.Add('return TRUE;');

  F4_Code.Add('}');

  F4_Code.Add(' ');

end;

end.

