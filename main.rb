#importing rub2d module
require 'ruby2d'

# not permitting resizing of window
set resizable:false

# getting default window height and width for scaling background image
x = Window.width
y = Window.height


#Defining background music 
music = Music.new('./assets/music/music.mp3')

#setting tittle
set title: "RunMan-Game"

#setting background Image
Image.new('./assets/background/background.jpg',x:0,y:0,width:x,height:y,z:1)

#defining player movement speed [initially zero]
@speed = 0

#displaying welcome texts
text1 =Text.new('Hello! Welcome champ',z:3,
    font: '.\assets\fonts\Rubik_Scribble\RubikScribble-Regular.ttf',
    style: 'bold',
    size: 40,
    color: 'black',
    x:100,
    y:50
)

text2 = Text.new('Your Game Starts in 3 seconds',z:3,
    font: '.\assets\fonts\Rubik_Scribble\RubikScribble-Regular.ttf',
    style: 'bold',
    size: 30,
    color: 'black',
    x:100,
    y:100
)

time = Time.now

# defining sprites for different game objects
coin = Sprite.new('D:\projects\RunMan-Game-Ruby2d\assets\for_sprites\coin.png',clip_width:84,time:300,loop:true)
boom = Sprite.new('D:\projects\RunMan-Game-Ruby2d\assets\for_sprites\boom.png',clip_width:127,time:75,loop:false)
hero = Sprite.new('D:\projects\RunMan-Game-Ruby2d\assets\for_sprites\hero.png',clip_width:78,width:78,height:99,time:250,
animations:{
    walk:1..2,
    climb:3..4,
    cheer:5..6
},x:x-100,y:y-233,z:2
)
done = true
# creating infinite loop
update do
    #removing welcome text
    if Time.now-time >= 3 
        text1.remove
        text2.remove
        music.play

        if done
            #generating cordinates for coin
            coin_x = rand(0..Window.width)
            coin_y = 0
            coin.z = 2
            coin.x = coin_x
            coin.y = coin_y
            #playing coin sprite
            coin.play()
            done = false
        end
        coin.y=coin.y+1
        if coin.y>Window.height
            done = true
        end
        # begining to control player  movements
        #moving player
        on :key_down do |event|
            case event.key
                when 'left'
                    hero.play animation: :walk,loop:true, flip: :horizontal
                    @speed=0.1
                    hero.x -= @speed
                when 'right'
                    hero.play animation: :walk,loop:true
                    @speed=0.1
                    hero.x += @speed 
                when 'c'
                    hero.play animation: :cheer,loop:false
            end
        end
    end
    
    #controlling player speed from getting high
    if @speed > 0.2 then @speed = 0 end

    #ensuring player does not move out of window
    if hero.x <= 3 then hero.x = 3 end
    if hero.x >=557 then hero.x = 557 end

    #game over sequence
    if (hero.x == coin.x) and (hero.y == coin.y)
        boom.play
        set background: 'black'
        text3.z = 5
        music.pause
        text3 =Text.new('Game Over',z:0,
            font: '.\assets\fonts\Rubik_Scribble\RubikScribble-Regular.ttf',
            style: 'bold',
            size: 80,
            color: 'black',
            x:100,
            y:100
        )
    end

end
show