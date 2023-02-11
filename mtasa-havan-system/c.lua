-------------------
-- Meta Script discord : https://discord.gg/UaQXJndGV2
-- Author discord : Davetsiz#0606
-------------------
panel = guiCreateWindow(500, 300, 400, 150, "", false)
guiSetVisible(panel,false)
guiWindowSetSizable(panel, false)

xKonumu = guiCreateScrollBar(9, 22, 110, 22, true, false, panel)
zKonumu = guiCreateScrollBar(140,22, 110, 22, true, false, panel)
patlamaSekilEdit = guiCreateEdit(270, 22, 110, 22, "Patlama Şekil 1-12", false, panel)
button = guiCreateButton(10,70, 382, 30, "Ateşle", false, panel)    
closeButton = guiCreateButton(10,105, 382, 30, "Paneli Kapat", false, panel)  

label = guiCreateLabel(30, 45, 110, 20, "Atış menzili", false, panel)
guiSetFont(label, "default-bold-small")
guiLabelSetColor(label, 255, 255, 255)    

label2 = guiCreateLabel(150, 45, 110, 20, "Atış yüksekliği", false, panel)
guiSetFont(label2, "default-bold-small")
guiLabelSetColor(label2, 255, 255, 255) 

local button_spam = 1500
addEventHandler("onClientGUIClick", root, function()
    if (getTickCount() - button_spam <= 1500) then return end
    if source == button then
        x = guiScrollBarGetScrollPosition(xKonumu) 
        z = guiScrollBarGetScrollPosition(zKonumu) 
        if x == 0 then x = 5 end
        if y == 0 then y = 5 end
        if z == 0 then z = 1 end
        patlamaSekil = guiGetText(patlamaSekilEdit)
        triggerServerEvent("PatlamaOlustur", localPlayer, x, z,patlamaSekil)
        button_spam = getTickCount()
    elseif source == closeButton then 
        guiSetVisible(panel,false)
        showCursor(false)
    end
end)


addEvent("ates_efekt",true)
addEventHandler("ates_efekt",localPlayer,function(x,y,z,rx,ry,rz)
    efekt = createEffect("tank_fire",x,y,z+2.65,rx-50,ry,rz,0,true)
    setEffectSpeed(efekt,0.8)
    playSound3D("havanSes.mp3",x,y,z)
end)

addEvent("ses_efekt",true)
addEventHandler("ses_efekt",localPlayer,function(x,y,z)
    playSound3D("havanSes.mp3",x,y,z)
end)


addEvent("paneliac",true)
addEventHandler("paneliac",localPlayer,function()
    guiSetVisible(panel,true)
    showCursor(true)
end)

addEvent("paneliKapat",true)
addEventHandler("paneliKapat",localPlayer,function()
    if ( guiGetVisible ( panel ) == true ) then              
            guiSetVisible ( panel, false )
            showCursor(false) 
    else              
        --    guiSetVisible ( panel, true ) 
        --    showCursor(true) 
    end
end)



--Editboxa sadece sayı girme

addEventHandler( "onClientGUIChanged", patlamaSekilEdit, function() 
    local currText = guiGetText( source ) 
    local newText = string.gsub( currText, '[^0-9-+]', '' ) 
    if newText ~= currText then 
      guiSetText( source, newText ) 
    end 
end, false ) 

--Tıkladıgında Editboxdaki yazıyı silme
addEventHandler("onClientGUIClick", root, function()
    if source == patlamaSekilEdit then
        guiSetText(patlamaSekilEdit,"")
    end
end)

------------
----OBJE----
------------
txd = engineLoadTXD ( "obje/minigx.txd" )
engineImportTXD ( txd, 2691 )
dff = engineLoadDFF ( "obje/minigun_base.dff" )
engineReplaceModel ( dff, 2691 )
engineSetModelLODDistance(2691, 9000)
