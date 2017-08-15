Object = require 'libraries/classic/classic'

require 'objects/card'
require 'objects/deck'
require 'objects/hand'

-- seed random so we dont get the same cards every game
math.randomseed(os.time())


function play()

    
    -- hands
    player = Hand(false)
    dealer = Hand(true)

    -- make a new deck
    deck = Deck()
    deck:shuffle()

    --deal two cards to dealer and two to player
    player:add(deck:draw())
    dealer:add(deck:draw())
    player:add(deck:draw())
    dealer:add(deck:draw())

    -- print out hands
    os.execute('clear')
    print('Welcome to Blackjack')
    print('Dealer has ' .. dealer:print())
    print('Player has ' .. player:print())
    
    --see if we have blackjack, if not hit or stand
    if player:isBlackjack() then
        print('Blackjack!')
        stand(player)
    else
        showOptions()
    end
end

function showOptions()
    print('Stand [S] or Hit [H]?')
    key = io.read():lower() 
    if key == 'h' then
        hit(player)
    elseif key == 's' then
        stand(player)
    else
        showOptions()
    end
end


function hit(hand)


    if not hand.isDealer then

        player:add(deck:draw())
        print('Player has ' .. player:print())

        if hand:isBust() then
            print('BUST!')
            lose()
        elseif hand:isBlackjack() then
            print('Blackjack!')
            stand(player)
        else
            showOptions()
        end
    else
        print('Dealer hits')
        dealer:add(deck:draw())
        print('Dealer has ' .. dealer:print())

        if hand:isBust() then
            print('Dealer is bust')
            win()
        elseif hand:shouldDealerHit() then
            hit(dealer)
        else
            stand(dealer)
        end
    end
end

function stand(hand)
    if not hand.isDealer then
        dealer.hideHand = false
        print('Dealer has ' .. dealer:print())

        if dealer:shouldDealerHit() then
            hit(dealer)
        else
            stand(dealer)
        end
    else
        print('Dealer stands')
        if dealer:highestValue() > player:highestValue() then
            lose()
        elseif dealer:highestValue() == player:highestValue() then
            draw()
        else
            win()
        end
    end
end

function lose()
    print('You lose')
    playAgain()
end

function win()
    print('You win!')
    playAgain()
end

function draw()
    print('You draw')
    playAgain()
end

function playAgain()
    print('Would you like to play again? [Y] or [N]')
    if io.read():lower() == 'y' then
        play()
    else
        print('Thanks for playing!')
    end
end



play()