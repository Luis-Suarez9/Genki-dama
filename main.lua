function newObject(imageName)
    object = {}
    object.x = 400
    object.y = 400
    object.rotation = 0
    object.xScale = 0.5
    object.yScale = 0.5
    object.image = love.graphics.newImage(imageName)
    object.width = object.image:getWidth()
    object.height = object.image:getHeight()
    object.xOrigin = object.width /2
    object.yOrigin = object.height /2
    object.red = 1
    object.green = 1
    object.blue = 1
    object.alpha = 1
    return object
end

function drawObject(pic)
    love.graphics.setColor(pic.red, pic.green, pic.blue, pic.alpha)
    love.graphics.draw(pic.image, pic.x, pic.y, pic.rotation, pic.xScale, pic.yScale, pic.xOrigin, pic.yOrigin)
end

function love.load()
    errorCount = 0
    time = 0 -- for sin graph
    textList = {}
    genkiList = {}
    grassList = {}
    overallSetup()
end

function grassSet()
    grass = newObject("grass.png")
    grass.xScale = 0.01
    grass.yScale = 0.01
    grass.alpha = 0
    grass.x = math.random(0, 780)
    grass.y = math.random(300, 600)
end

function overallSetup()
    wavFile()
    errorPicSet()
    genkiSetup()
    genkiParticleSet()
    gokuholdSet()
    -- planetSet()
    gokuThrowSet()
    grassSet()
    BeerusSet()
    background()
    setupDebug()
end

-- function planetSet()
--     planet = newObject("planet.png")
--     planet.x = 180
--     planet.y = 220
--     planet.alpha = 1
--     -- planet.xScale = 1
--     -- planet.yScale = 1
-- end

function genkiParticleSet()
    genkiParticle = newObject("genkiP.png")
    genkiParticle.x = 100
    genkiParticle.y = 100
    genkiParticle.xScale = 0.05
    genkiParticle.yScale = 0.05
    genkiParticle.alpha = 0
end

function background()
    background1 = newObject("background1.png")
    background2 = newObject("background2.png")
    background1.alpha = 1 
    background1.xScale = 2
    background1.yScale = 2
    background2.xScale = 2
    background2.yScale = 3.2
    background2.alpha = 0
end

function wavFile()
    genkis = love.audio.newSource("genkidama.wav", "static")
    errorSound = love.audio.newSource("errorSound.wav", "static")
end

function genkiSetup()
    genki = newObject("genki.png")
    genki.xScale = 0.042
    genki.yScale = 0.042
    genki.x = 650
    genki.y = 69
    genki.alpha = 0
end

function errorPicSet()
    errorp = newObject("error.png")
    errorp.xScale = 1
    errorp.yScale = 1.45
    errorp.alpha = 0
end

function gokuholdSet()
    gokuHold = newObject("gokuHold.png")
    gokuHold.x = 900
    gokuHold.y = 300
    gokuHold.xScale = 0.2
    gokuHold.yScale = 0.2
end


function gokuThrowSet()
    gokuThrow = newObject("gokuthrow.png")
    gokuThrow.xScale = 0.4
    gokuThrow.yScale = 0.4
    gokuThrow.x = 700
    gokuThrow.y = 250
    gokuThrow.alpha = 0
end

function BeerusSet()
    Beerus = newObject("Beerus.png")
    Beerus.xScale = 0.5
    Beerus.yScale = 0.5
    Beerus.x = -100
    Beerus.y = 500
    Hakai = newObject("Hakai.png")
    Hakai.x = 180
    Hakai.y = 450
    Hakai.xScale = 0.1
    Hakai.yScale = 0.1
    Hakai.alpha = 0
    AuraB = newObject("AuraB.png")
    AuraB.x = 160
    AuraB.y = 450
    AuraB.xScale = 0.5
    AuraB.yScale = 0.5
    AuraB.alpha = 0
end

function love.draw()
    drawDebug()
    drawObject(background1)
    drawObject(background2)
    for index = 1, #genkiList do
        genkiParticle = genkiList[index]
        drawObject(genkiParticle)
    end
    drawObject(gokuHold)
    drawObject(gokuThrow)
    drawObject(AuraB)
    drawObject(Beerus)
    -- drawObject(planet)
    drawObject(Hakai)
    drawObject(genki)
    for i = 1, #grassList do
        grass = grassList[i] 
        drawObject(grass)
    end
    drawObject(errorp)
    for index = 1, #textList do 
        oldtext = textList[index]
        love.graphics.print(oldtext, 0 , 20*(index-1))
    end
end

function love.update(dt)
     -- dt is for for sin graph function
     
    if errorp.alpha == 0 and errorCount == 0 then -- before C error message pop up
        genkis:setLooping(true)
        errorSound:setLooping(false)
        love.audio.play(genkis)


        if gokuHold.x > 650 or Beerus.x < 150 then-- goku and beerus comming in to the scene
            gokuHold.x = gokuHold.x - 1
            Beerus.x = Beerus.x + 1
        elseif gokuHold.x <= 650 and Beerus.x >= 150 then 
            gokuHold.x = 650
            Beerus.x = 150
            genki.alpha = 1
            genkiParticle.alpha = 1
            Hakai.alpha = 1
            AuraB.alpha = 1
            AuraB.alpha = AuraB.alpha + math.random(0,1)
            AuraB.alpha = AuraB.alpha - math.random(0,1)

            if genki.xScale < 0.95 then --goku charging genkidama and beerus keep hakai his planet
                genki.xScale = genki.xScale + 0.00027
                genki.yScale = genki.yScale + 0.00027
                if Hakai.y > 220 then --beerus hakai
                    Hakai.x = Hakai.x + 1
                    Hakai.y = Hakai.y -1
                    Hakai.xScale = Hakai.xScale + 0.0008
                    Hakai.yScale = Hakai.yScale + 0.0008
                elseif Hakai.y <= 220 then
                    Hakai.y = 450
                    Hakai.x = 180
                    Hakai.xScale = 0.01
                    Hakai.yScale = 0.01
                end
                

                if genkiParticle.x > 30 then
                    newgenkiParticle = newObject("genkiP.png")
                    newgenkiParticle.alpha = 1
                    newgenkiParticle.x = 0
                    newgenkiParticle.y = math.random(69,100)
                    newgenkiParticle.xScale =  0.1
                    newgenkiParticle.yScale =  0.1
                    genkiList[#genkiList+1] = newgenkiParticle
                end

                for index = #genkiList, 1, -1 do
                    genkiParticle = genkiList[index]
                    genkiParticle.x = genkiParticle.x + 2
                    genkiParticle.xScale = genkiParticle.xScale + 0.0001
                    genkiParticle.yScale = genkiParticle.yScale + 0.0001
                    genkiParticle.alpha = genkiParticle.alpha - 0.001
                    genkiParticle.yScale = genkiParticle.yScale - 0.0001
                    genkiParticle.xScale = genkiParticle.xScale + 0.0001
                    if genkiParticle.x >= 640 and genkiParticle.x <= 660 then
                        table.remove(genkiList, index)
                    end  
                end

                if math.random(1,20) == 2  then
                    newGrass = newObject("grass.png")
                    newGrass.alpha = 1
                    newGrass.xScale = 0.05
                    newGrass.yScale = 0.05
                    newGrass.x = math.random(0, 780)
                    newGrass.y = math.random(300, 600)
                    grassList[#grassList+1] = newGrass
                end

                for index = #grassList,1,-1 do 
                    grass = grassList[index]
                    grass.y = grass.y -2
                    grass.rotation = grass.rotation + math.random(1,6) 
                    grass.rotation = grass.rotation - math.random(1,6)
                    grass.alpha = grass.alpha - 0.0035
                    if grass.alpha == 0 then
                        table.remove(grassList, index)
                    end
                end

            elseif genki.xScale >= 0.95 then 
                gokuHold.alpha = 0
                gokuThrow.alpha= 1 
                AuraB.alpha  = 0
                grass.alpha = 0
                Hakai.alpha = 0
                table.remove(genkiList, index)
                table.remove(grassList, index)

                if genki.x >= 200 then 
                    time = time + dt
                    genki.y = genki.y + 50 * math.sin(2 * math.pi * 2 * time)
                    genki.x = genki.x - 0.8
                    genki.y = genki.y - 0.5
                    genki.xScale = genki.xScale + 0.002
                    genki.yScale = genki.yScale + 0.002
                    Hakai.alpha = 0
                    grass.alpha = 0
                elseif genki.x < 200 then
                    genki.x = 200
                    genki.xScale = genki.xScale + 0.002
                    genki.yScale = genki.yScale + 0.002
                    Hakai.alpha = 0
                    grass.alpha = 0
                end
                if genki.xScale >= 2.75 then 
                    genki.y = 600
                    genki.xScale = genki.xScale + 0.02
                    genki.yScale = genki.yScale + 0.02
                    genki.xScale = 2.75
                    genki.yScale = 2.75
                    Hakai.alpha = 0
                    grass.alpha = 0
                end
                
            end
        end
        if genki.xScale >= 2.75 then
            errorSound:setLooping(true)
            errorp.alpha = 1 
            genkis:setLooping(false)
            love.audio.stop(genkis)
            love.audio.play(errorSound)
        end

    elseif errorp.alpha == 1 and errorCount < 4 and love.keyboard.isDown("return") == false then  -- error pop up 
            love.timer.sleep(5)
            time = 0
            overallSetup()
    end
end

function addDebug(text)
    debug = text .. "\n" .. debug
    debugcount = debugcount + 1
    if debugcount > 1000 then
        setupDebug()
    end
end

function drawDebug()
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(debug, 0, 0)
end

function setupDebug()
    debugcount = 0
    debug = ""
end

function love.keypressed(key)
    if key == "space" then
        if background1.alpha == 1 and background2.alpha == 0 then -- for background
            background1.alpha = 0
            background2.alpha = 1
        elseif background1.alpha == 0 and background2.alpha == 1 then
            background1.alpha = 1
            background2.alpha = 0
        end  
    end
end