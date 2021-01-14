object fmCAD2Excel: TfmCAD2Excel
  Left = 375
  Top = 253
  Caption = 'CAD to Excel'
  ClientHeight = 286
  ClientWidth = 777
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox7: TGroupBox
    Left = 8
    Top = 8
    Width = 257
    Height = 265
    Hint = 'Options'
    Caption = 'Option :'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    object Label31: TLabel
      Left = 14
      Top = 33
      Width = 123
      Height = 22
      AutoSize = False
      Caption = 'Pick up text method:'
    end
    object Label33: TLabel
      Left = 14
      Top = 71
      Width = 139
      Height = 22
      AutoSize = False
      Caption = 'Command in CAD:'
    end
    object Label26: TLabel
      Left = 14
      Top = 111
      Width = 139
      Height = 22
      AutoSize = False
      Caption = 'Save Excel file to:'
    end
    object Edit19: TEdit
      Left = 160
      Top = 70
      Width = 81
      Height = 25
      AutoSize = False
      Enabled = False
      TabOrder = 1
      Text = 'liming'
    end
    object ComboBox11: TComboBox
      Left = 160
      Top = 32
      Width = 81
      Height = 21
      Style = csOwnerDrawFixed
      ItemHeight = 15
      ItemIndex = 0
      TabOrder = 0
      Text = 'By layer'
      Items.Strings = (
        'By layer'
        'By Select'
        'By Select 2')
    end
    object Button1: TButton
      Left = 64
      Top = 216
      Width = 105
      Height = 33
      Caption = 'Generator'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Edit20: TEdit
      Left = 160
      Top = 110
      Width = 81
      Height = 25
      AutoSize = False
      Enabled = False
      TabOrder = 3
      Text = 'D:\'
    end
  end
  object GroupBox8: TGroupBox
    Left = 282
    Top = 8
    Width = 497
    Height = 265
    Hint = 'How to use this function?'
    Caption = 'Instructions:'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    object Memo5: TMemo
      Left = 2
      Top = 208
      Width = 473
      Height = 17
      Lines.Strings = (
        '(defun c:liming ( / &tex &ss %fir ~fir %lay #si #sn )'
        '  (if (null vlax-dump-object) (vl-load-com) )'
        '  (if (setq &tex (entsel "\nSelect text in this layer: "))'
        
          '   (if (= (vla-get-objectname (setq &tex (vlax-ename->vla-object' +
          ' (car &tex)))) '
        '"AcDbText")'
        '    (progn'
        
          '     (setq %fir (strcat "D://" (vl-filename-base (getvar "dwgnam' +
          'e")) ".xls") ~fir (open %fir '
        '"w"))'
        
          '     (setq %lay (vla-get-layer &tex) &ss (ssget "X" (list (cons ' +
          '0 "TEXT") (cons 8 %lay))))'
        '     (repeat (setq #si 0 #sn (sslength &ss))'
        
          '      (write-line (vla-get-textstring (vlax-ename->vla-object (s' +
          'sname &ss #si))) ~fir)'
        '      (setq #si (1+ #si))'
        '     )'
        '     (close ~fir) (vlax-release-object &tex)'
        
          '     (princ (strcat "\nExport layer: [" %lay "] " (itoa #sn) " t' +
          'ext to " %fir ", by Liming"))'
        '     (command "_sh" "explorer D:")'
        '    )'
        '    (princ "\nSelected is not text. by Liming")'
        '   )'
        '   (princ "\nNothing selected. by Liming")'
        '  )'
        '  (princ)'
        ')')
      TabOrder = 0
      Visible = False
    end
    object Memo6: TMemo
      Left = 2
      Top = 224
      Width = 473
      Height = 17
      Lines.Strings = (
        
          '(defun C:liming ( / n ss &kw L ff %k %k1 %k2 %k3 %k4 %k5 %k6);??' +
          '?????'
        ' (setvar "cmdecho" 0) ;;????'
        ' (setvar "blipmode" 0);;?????'
        ' (vl-load-com)        ;;??vlax????'
        ' (setq n 0 ss '#39'())    ;;??????'
        ' (princ "\nPlease select text")'
        ' (setq &kw (ssget '#39'((0 . "TEXT,MTEXT"))));????'
        ' (if (/= &kw nil);;????????'
        '  (progn'
        '   (setq L (sslength &kw)'
        '         ff (open "D://cad2excel.xls" "w");????'
        '   );;'
        '   (repeat L'
        '    (setq &kw1 (entget (ssname &kw n))'
        '          %k1 (cdr (assoc 10 &kw1))  ;;??????'
        '          %k2 (cdr (assoc 1 &kw1))   ;;??????'
        '          ss (cons (list %k1 %k2) ss);;?????'
        '          n (+ n 1)'
        '    )'
        '   )'
        
          '   (setq ss (vl-sort ss (function (lambda (x y)(< (fix (caar x))' +
          ' (fix (caar y)))))));;X????'
        '??'
        
          '   (setq ss (vl-sort ss (function (lambda (x y)(> (fix (cadar x)' +
          ') (fix (cadar y)))))));;Y???'
        '???'
        '   (setq &kw1 (nth 0 ss)'
        '         %k1 (caar &kw1);;???????????'
        '         %k2 (cadar &kw1);;???????????'
        '         %k3 (cadr &kw1);;?????'
        '         n 1'
        '   )'
        '   (repeat (- L 1)'
        '    (setq &kw2 (nth n ss)'
        '          %k4 (caar &kw2)'
        '          %k5 (cadar &kw2)'
        '          %k6 (cadr &kw2)'
        '          %k (- %k2 %k5)'
        '          n (+ n 1)'
        '    )'
        '    (if (> %k 20)'
        '     (progn'
        '      (princ %k3 ff)'
        '      (princ "\n" ff);;???????'
        '      (setq %k1 %k4 %k2 %k5 %k3 %k6)'
        '     )'
        '    )'
        '    (if (and (<= %k 20) (< %k1 %k4))'
        '     (progn'
        '      (princ %k3 ff)'
        '      (princ "\t" ff);;??????;?????'
        '      (setq %k1 %k4 %k2 %k5 %k3 %k6)'
        '     )'
        '    )'
        '    (if (and (<= %k 20) (> %k1 %k4))'
        '     (progn'
        '      (princ %k6 ff)'
        '      (princ "\t" ff)'
        '     )'
        '    )'
        '   )'
        '   (princ %k3 ff)'
        '   (close ff);;????'
        '   (princ (strcat "\nOperation finish."))'
        '  )'
        ' )'
        ' (prin1);;??'
        ');;????????,???(.lsp)???(wz.lsp);???autocad?????'
        '?')
      TabOrder = 1
      Visible = False
    end
    object Memo7: TMemo
      Left = 2
      Top = 240
      Width = 473
      Height = 17
      Lines.Strings = (
        
          '(defun c:liming ( / &ss %fir ~fir @tex #si #sn &tex %lay %tex @c' +
          'l %ctx )'
        '  (vl-load-com) (princ "\n???????????")'
        '  (if (setq &ss (ssget (list (cons 0 "TEXT"))))'
        '   (progn'
        
          '    (setq %fir (strcat "D://" (vl-filename-base (getvar "dwgname' +
          '")) ".xls") ~fir (open %fir '
        '"w"))'
        '    (repeat (setq @tex '#39'() #si 0 #sn (sslength &ss))'
        
          '     (setq &tex (vlax-ename->vla-object (ssname &ss #si)) #si (1' +
          '+ #si))'
        
          '     (setq %lay (vla-get-layer &tex) %tex (vla-get-textstring &t' +
          'ex))'
        '     (if (setq @cl (assoc %lay @tex))'
        '      (setq @tex (subst (append @cl (list %tex)) @cl @tex))'
        '      (setq @tex (cons (list %lay %tex) @tex))'
        '     )'
        '    )'
        
          '    (setq @tex (vl-sort @tex (function (lambda (a b) (> (length ' +
          'a) (length b))))))'
        '    (setq #si 0 #sn (length (car @tex)))'
        
          '    (setq @tex (vl-sort @tex (function (lambda (a b) (< (car a) ' +
          '(car b))))))'
        '    (repeat #sn'
        '     (setq %tex "")'
        '     (foreach @tx @tex'
        '      (if (null (setq %ctx (nth #si @tx))) (setq %ctx "") )'
        '      (if (/= %tex "")'
        '       (setq %tex (strcat %tex "," %ctx))'
        '       (setq %tex %ctx)'
        '      )'
        '     )'
        '     (write-line %tex ~fir) (setq #si (1+ #si))'
        '    )'
        '    (close ~fir) (vlax-release-object &tex)'
        
          '    (princ (strcat "\n???? " (itoa (sslength &ss)) "?????? " %fi' +
          'r " ?."))'
        '   )'
        '   (princ "\n???????,??.")'
        '  )'
        '  (princ)'
        ')')
      TabOrder = 2
      Visible = False
    end
    object Memo8: TMemo
      Left = 8
      Top = 24
      Width = 473
      Height = 233
      BorderStyle = bsNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      Lines.Strings = (
        
          'This function is to pick up text from CAD drawing and export to ' +
          'Excel file.'
        ''
        '1. Generate AutoLISP Application source file (.lsp) from left.'
        ''
        
          '2. Open your AutoCAD drawing, and type command '#39'AP'#39' and select t' +
          'his .lsp file '
        'to load this function to CAD.'
        ''
        
          '3. AutoCAD should add this function already, type command '#39'limin' +
          'g'#39' to use this '
        'function.'
        ''
        
          '4. After type '#39'liming'#39' select a text in your CAD drawing, applic' +
          'ation will generate '
        'one excel file in disk '#39'D:'#39' and will open this file locaiton.')
      ParentColor = True
      ParentFont = False
      TabOrder = 3
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 762
    Top = 65520
  end
end