-------------------
-- Meta Script discord : https://discord.gg/UaQXJndGV2
-- Author discord : Davetsiz#0606
-------------------

addEvent("PatlamaOlustur", true)
addEventHandler("PatlamaOlustur", root, function(x,z,patlamaSekil)
    if getPlayerMoney(source) > 1000 then
        local y = 1
        local oYhavan = getElementData(source,"havan_sahip")
        local hx,hy,hz = getElementPosition(oYhavan)
        local hxx,hyy,hzz =  getElementRotation(oYhavan)
        local arVector = Vector3(hx,hy,hz)
        local artorvector = Vector3(0,0,hzz)
        local arMatrix = Matrix(arVector,artorvector)
        local efPos = arVector+arMatrix.up*-2
        local ex,ey,ez = efPos.x,efPos.y,efPos.z
        local rx,ry,rz = hxx,hyy,hzz
        local ox, oy, oz = getElementPosition(source)
        local oxx, oyy, ozz = getElementRotation(source)
        local oyVector = Vector3(ox,oy,oz)
        local rotVector = Vector3(0,0,ozz)
        local arti = Vector3(0,0,90)
        local sonuc = rotVector + arti
        local oyMatrix = Matrix(oyVector,rotVector)
        local oyPos = oyVector+oyMatrix.forward*x
        local nx,ny,nz = oyPos.x,oyPos.y,oyPos.z
        local oyVectorn = Vector3(nx,ny,nz)
        local oyMatrixn = Matrix(oyVectorn,rotVector)
        local oyPosz = oyVector+oyMatrixn.up*z
        tx = nx 
        ty = ny
        tz = oyPosz.z
        triggerClientEvent("ates_efekt",root,ex,ey,ez,oxx+30,oyy,ozz)
        local yukari_fuze = createObject(1636,ex,ey,ez+0.5,oxx+50,oyy,ozz)
        moveObject(yukari_fuze,1500,tx,ty,tz+30)
        setTimer(function (fuz,x,y,z,patlamaSekil,source)
            destroyElement(fuz)
            setTimer(function(x,y,z,patlamaSekil,source,oyuncu)
                local ox, oy, oz = getElementPosition(source)
                local oxx, oyy, ozz = getElementRotation(source)
                local oyVector = Vector3(ox,oy,oz)
                local rotVector = Vector3(0,0,ozz)
                local arti = Vector3(0,0,90)
                local sonuc = rotVector + arti
                local oyMatrix = Matrix(oyVector,rotVector)
                local oyPos = oyVector+oyMatrix.forward*x
                local nx,ny,nz = oyPos.x,oyPos.y,oyPos.z
                local oyVectorn = Vector3(nx,ny,nz)
                local oyMatrixn = Matrix(oyVectorn,rotVector)
                local oyPosz = oyVector+oyMatrixn.up*z
                x = nx 
                y = ny
                z = oyPosz.z
                                
                fuze = createObject (1636,x,y,z+30, 990,0,0)--3790
                triggerClientEvent("ses_efekt",root,tonumber(x),tonumber(y),tonumber(z))
                moveObject(fuze,1200,x,y,z-30)
                setTimer(function(fuze,x,y,z,patlamaSekil,oyuncu)
                    destroyElement(fuze)
                    createExplosion(x,y,z,tonumber(patlamaSekil) or 0,oyuncu)
                end,1300,1,fuze,x,y,z,patlamaSekil,oyuncu)

                end,900,1,x,y,z,patlamaSekil,source,oyuncu)
        end,1000,1,yukari_fuze,x,y,z,patlamaSekil,source)
        takePlayerMoney(source,1000)
    else
        outputChatBox("#AA00FF[Meta Script] #FFFFFFRoket atmak için yeterli paran yok.",source,255,255,255,true)
    end
end)
--3790 fuze obje
function kuruluyor(oyuncu)
    if getElementData(oyuncu,"havan_sahip") then 
        havanVarsaKaldir(oyuncu) --yeni havan kurduğunda eskisini kaldır
    end

    local ox, oy, oz = getElementPosition(oyuncu)
    local oxx, oyy, ozz = getElementRotation(oyuncu)
    local posVector = Vector3(ox,oy,oz-1)
    local rotVector = Vector3(0,0,ozz)
    local arti = Vector3(0,0,90)
    local sonuc = rotVector + arti
    local vehMatrix = Matrix(posVector,rotVector)
    local vehPos = posVector+vehMatrix.forward*1
    local oYhavan = createObject (2691,vehPos,sonuc)-- 3884
 
    --Uctan cıkan fuze
    --Ucfuze = createObject (1636,arVector,artorvector)--3790

    setElementData(oyuncu,"havan_sahip",oYhavan)
    triggerClientEvent("paneliac",oyuncu)
end


function havanKur(thePlayer,theVehicle,sourcePlayer)
    local theVehicle = getPedOccupiedVehicle(thePlayer)
    if theVehicle then return end
    if isPedWearingJetpack(thePlayer) then return end
    if isElementInWater(thePlayer) then return end
    if isPedOnGround(thePlayer) then else return end
    setPedAnimation(thePlayer,"BOMBER","BOM_Plant_Loop",3000,true,false,false,false)
    kuruluyor(thePlayer)
end
addCommandHandler("havankur", havanKur)

function havanVarsaKaldir(oyuncu)
    local havan = getElementData(oyuncu,"havan_sahip")
    if havan then
        destroyElement(havan)
        removeElementData(oyuncu,"havan_sahip")
    end
end


function havanKaldir(oyuncu)
    triggerClientEvent("paneliKapat",oyuncu)
    local havan = getElementData(oyuncu,"havan_sahip")
    if havan then
        destroyElement(havan)
        outputChatBox("#AA00FF[Meta Script] #FFFFFFOluşturduğun havan kaldırıldı.",oyuncu,255,255,255,true)
        removeElementData(oyuncu,"havan_sahip")
    end
end
addCommandHandler("havankaldir",havanKaldir)


function oyundan_cikma()
    havanKaldir(source)
end
addEventHandler("onPlayerQuit",root,oyundan_cikma)

function oyuncu_olme()
    havanKaldir(source)
end
addEventHandler("onPlayerWasted",root,oyuncu_olme)

function oyuncu_arac_binme()
    havanKaldir(source)
end
addEventHandler("onPlayerVehicleEnter",root,oyuncu_arac_binme)

