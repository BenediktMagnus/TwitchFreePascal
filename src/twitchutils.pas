Unit TwitchUtils;

{$mode objfpc}{$H+}

interface

uses
  Generics.Collections;

type
  generic TSynchronisedEventList<AObjectType> = class
  type
    TObjectTypeThreadList = specialize TThreadList<AObjectType>;
    TObjectTypeList = specialize TList<AObjectType>;
    TObjectTypeProcedure = procedure (const AObject: AObjectType) of object;
  protected
    FProcedure: TObjectTypeProcedure;
    FSynchronisedList: TObjectTypeThreadList;
    DefaultValue: AObjectType;
  public
    constructor Create; overload; virtual;
    constructor Create (AProcedure: TObjectTypeProcedure); overload; virtual;
    destructor Destroy; override;
  public
    procedure SetProcedure (AProcedure: TObjectTypeProcedure);
    procedure AddObject (AObject: AObjectType);
    function GetNextObject: AObjectType;
    function GetObjectList: TObjectTypeList;
    procedure CallAll;
    procedure CallNext;
  public
    property Call: TObjectTypeProcedure read FProcedure write FProcedure;
  end;

implementation

//////////////////////////
//Constructor/Destructor//
//////////////////////////

constructor TSynchronisedEventList.Create;
begin
  FSynchronisedList := TObjectTypeThreadList.Create;
end;

constructor TSynchronisedEventList.Create (AProcedure: TObjectTypeProcedure);
begin
  Create;

  FProcedure := AProcedure;
end;

destructor TSynchronisedEventList.Destroy;
begin
  FSynchronisedList.Free;

  inherited;
end;

//////////
//Public//
//////////

procedure TSynchronisedEventList.SetProcedure (AProcedure: TObjectTypeProcedure);
begin
  FProcedure := AProcedure;
end;

procedure TSynchronisedEventList.AddObject (AObject: AObjectType);
begin
  if Assigned(FProcedure) then
    FSynchronisedList.Add(AObject);
end;

function TSynchronisedEventList.GetNextObject: AObjectType;
var
  List: TObjectTypeList;
begin
  Result := DefaultValue;

  List := FSynchronisedList.LockList;
  try
    if List.Count > 0 then
      Result := List[0];
    List.Delete(0);
  finally
    FSynchronisedList.UnlockList;
  end;
end;

function TSynchronisedEventList.GetObjectList: TObjectTypeList;
var
  List: TObjectTypeList;
begin
  Result := TObjectTypeList.Create;

  List := FSynchronisedList.LockList;
  try
    Result.AddRange(List);
    List.Clear;
  finally
    FSynchronisedList.UnlockList;
  end;
end;

procedure TSynchronisedEventList.CallAll;
var
  LObject: AObjectType;
begin
  if Assigned(FProcedure) then
    for LObject in GetObjectList do
      FProcedure(LObject);
end;

procedure TSynchronisedEventList.CallNext;
begin
  if Assigned(FProcedure) then
    FProcedure(GetNextObject);
end;

end.
