Card = Object:extend()

function Card:new(rank, suit)

    -- table of suit names, symbols and colors
    local suits = {
        hearts = {'Hearts', '♥', 'Red'},
        diamonds = {'Diamonds', '♦', 'Red'},
        spades = {'Spades', '♠', 'Green'},
        clubs = {'Clubs', '♣', 'Green' }
    }

    -- table of name, shortname, and points
    local ranks = {
        {'Ace', 'A', 1},
        {'Two', '2', 2},
        {'Three', '3', 3},
        {'Four', '4', 4},
        {'Five', '5', 5},
        {'Six', '6', 6},
        {'Seven', '7', 7},
        {'Eight', '8', 8},
        {'Nine', '9', 9},
        {'Ten', '10', 10},
        {'Jack', 'J', 10},
        {'Queen', 'Q', 10},
        {'King', 'K', 10}
    }

    self.rank = rank
    self.name = ranks[rank][1]
    self.shortname = ranks[rank][2]
    self.points = ranks[rank][3]

    self.suit = suits[suit][1]
    self.symbol = suits[suit][2]
    self.color = suits[suit][3]

end

function Card:shortName()
    if self.color == 'Green' then
        return '[\27[32m' .. self.shortname .. self.symbol .. '\27[0m]'
    else
        return '[\27[31m' .. self.shortname .. self.symbol .. '\27[0m]'
    end
    
end

function Card:__tostring()
    return self.name .. ' of ' .. self.suit
end