VPRSN = 0;
FPRSN = 0;
FNRSN = 0;
RSN = 0;
SENSRSN = 0;
PREDIRSN = 0;

VPSYBR = 0;
FPSYBR = 0;
FNSYBR = 0;
SYBR = 0;
SENSSYBR = 0;
PREDISYBR = 0;

VPALAUR = 0;
FPALAUR = 0;
FNALAUR = 0;
ALAUR = 0;
SENSALAUR = 0;
PREDIALAUR = 0;

VPSAFIB = 0;
FPAFIB = 0;
FNAAFIB = 0;
AFIB = 0;
SENSAFIB = 0;
PREDIAFIB = 0;

VPTV = 0;
FPTV = 0;
FNTV = 0;
TV = 0;
SENSTV = 0;
PREDITV = 0;

VPFV = 0;
FPFV = 0;
FNFV = 0;
FV = 0;
SENSFV = 0;
PREDIFV = 0;

VPOARR = 0;
FPOARR = 0;
FNOARR = 0;
OARR = 0;
SENSOARR = 0;
PREDIOARR = 0;
for i=1:size(arritmiasAlgoritmo,1)
    if(isequal(arritmiasAlgoritmo(i,3), "Ritmo Sinusal Normal"))
        RSN = RSN + 1;
        VPRSN = VPRSN + str2double(arritmiasAlgoritmo(i,8));
        FPRSN = FPRSN + str2double(arritmiasAlgoritmo(i,9));
        FNRSN = FNRSN + str2double(arritmiasAlgoritmo(i,10));
        SENSRSN = SENSRSN + str2double(arritmiasAlgoritmo(i,11));
        PREDIRSN = PREDIRSN + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "Bradicardia Sinusal"))
        VPSYBR = VPSYBR + str2double(arritmiasAlgoritmo(i,8));
        FPSYBR = FPSYBR + str2double(arritmiasAlgoritmo(i,9));
        FNSYBR = FNSYBR + str2double(arritmiasAlgoritmo(i,10));
        SYBR = SYBR + 1;
        SENSSYBR = SENSSYBR + str2double(arritmiasAlgoritmo(i,11));
        PREDISYBR = PREDISYBR + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "Aleteo Auricular"))
        VPALAUR = VPALAUR + str2double(arritmiasAlgoritmo(i,8));
        FPALAUR = FPALAUR + str2double(arritmiasAlgoritmo(i,9));
        FNALAUR = FNALAUR + str2double(arritmiasAlgoritmo(i,10));
        ALAUR = ALAUR + 1;
        SENSALAUR = SENSALAUR + str2double(arritmiasAlgoritmo(i,11));
        PREDIALAUR = PREDIALAUR + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "Fibrilacion Auricular"))
        VPSAFIB = VPSAFIB + str2double(arritmiasAlgoritmo(i,8));
        FPAFIB = FPAFIB + str2double(arritmiasAlgoritmo(i,9));
        FNAAFIB = FNAAFIB + str2double(arritmiasAlgoritmo(i,10));
        AFIB = AFIB + 1;
        SENSAFIB = SENSAFIB + str2double(arritmiasAlgoritmo(i,11));
        PREDIAFIB = PREDIAFIB + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "Taquicardia ventricular"))
        VPTV = VPTV + str2double(arritmiasAlgoritmo(i,8));
        FPTV = FPTV + str2double(arritmiasAlgoritmo(i,9));
        FNTV = FNTV + str2double(arritmiasAlgoritmo(i,10));
        TV = TV + 1;
        SENSTV = SENSTV + str2double(arritmiasAlgoritmo(i,11));
        PREDITV = PREDITV + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "Flutter ventricular"))
        VPFV = VPFV + str2double(arritmiasAlgoritmo(i,8));
        FPFV = FPTV + str2double(arritmiasAlgoritmo(i,9));
        FNFV = FNFV + str2double(arritmiasAlgoritmo(i,10));
        FV = FV + 1;
        SENSFV = SENSFV + str2double(arritmiasAlgoritmo(i,11));
        PREDIFV = PREDIFV + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "OtraArritmia"))
        VPOARR = VPOARR + str2double(arritmiasAlgoritmo(i,8));
        FPOARR = FPOARR + str2double(arritmiasAlgoritmo(i,9));
        FNOARR = FNOARR + str2double(arritmiasAlgoritmo(i,10));
        OARR = OARR + 1;
        SENSOARR = SENSOARR + str2double(arritmiasAlgoritmo(i,11));
        PREDIOARR = PREDIOARR + str2double(arritmiasAlgoritmo(i,12));
    end
end
PREDIRSN = PREDIRSN/RSN;
SENSRSN = SENSRSN/RSN;

SENSSYBR = SENSSYBR/SYBR;
PREDISYBR = PREDISYBR/SYBR;

SENSALAUR = SENSALAUR/ALAUR;
PREDIALAUR = PREDIALAUR/ALAUR;

SENSAFIB = SENSAFIB/AFIB;
PREDIAFIB = PREDIAFIB/AFIB;

SENSTV = SENSTV/TV;
PREDITV = PREDITV/TV;

SENSFV = SENSFV/FV;
PREDIFV = PREDIFV/FV;

SENSOARR = SENSOARR/OARR;
PREDIOARR = PREDIOARR/OARR;

globalArritmiasAlgoritmo=[];

if(~isempty(SENSRSN) && ~isnan(SENSRSN))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Ritmo Sinusal Normal" VPRSN FPRSN FNRSN SENSRSN PREDIRSN];
end

if(~isempty(SENSSYBR) && ~isnan(SENSSYBR))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Bradicardia Sinusal" VPSYBR FPSYBR FNSYBR SENSSYBR PREDISYBR];
end

if(~isempty(SENSALAUR) && ~isnan(SENSALAUR))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Aleteo Auricular" VPALAUR FPALAUR FNALAUR SENSALAUR PREDIALAUR];
end

if(~isempty(SENSAFIB) && ~isnan(SENSAFIB))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Fibrilacion Auricular" VPSAFIB FPAFIB FNAAFIB SENSAFIB PREDIAFIB];
end

if(~isempty(SENSTV) && ~isnan(SENSTV))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Taquicardia ventricular" VPTV FPTV FNTV SENSTV PREDITV];
end

if(~isempty(SENSFV) && ~isnan(SENSFV))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Flutter ventricular" VPFV FPFV FNFV SENSFV PREDIFV];
end

if(~isempty(SENSOARR) && ~isnan(SENSOARR))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "OtraArritmia" VPOARR FPOARR FNOARR SENSOARR PREDIOARR];
end