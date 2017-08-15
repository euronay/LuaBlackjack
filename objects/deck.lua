Deck = Object:extend()

function Deck:new()
    self.cards = {}

    for i,suit in ipairs({'hearts', 'diamonds', 'spades', 'clubs'}) do
        for rank=1,13 do
            table.insert(self.cards, Card(rank, suit))
        end
    end
end

function Deck:shuffle()
    for x=1,7 do
        for n=0,52 do
            
            local r = math.random(51)
            
            local c = self.cards[n]
            --print(n .. " " ..r .. " " ..c:shortName())
            self.cards[n], self.cards[r] = self.cards[r], self.cards[n]
            
        end
    end
end

function Deck:draw()
    return table.remove(self.cards)
end

function Deck:print()
    for i,c in ipairs(self.cards) do print(c:shortName()) end
end