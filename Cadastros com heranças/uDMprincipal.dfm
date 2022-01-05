object DMPrincipal: TDMPrincipal
  OldCreateOrder = False
  Left = 300
  Top = 136
  Height = 150
  Width = 215
  object DBCadastro: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=ISO8859_1')
    LoginPrompt = False
    DefaultTransaction = IBTransaction
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    BeforeConnect = DBCadastroBeforeConnect
    Left = 26
    Top = 10
  end
  object IBTransaction: TIBTransaction
    Active = False
    DefaultDatabase = DBCadastro
    DefaultAction = TACommitRetaining
    AutoStopAction = saNone
    Left = 106
    Top = 10
  end
end
