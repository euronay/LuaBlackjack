Hand = Object:extend()

function Hand:new(isDealer)
    self.isDealer = isDealer or false
    self.hideHand = isDealer
    self.cards = {}
    self.count = 0
end

function Hand:add(card)
    table.insert(self.cards, card)
    self.count = self.count + 1
end


function Hand:value()
    local value1 = 0
    local value2 = 0
    local numAces = 0
    for i,c in ipairs(self.cards) do
        -- forst ace can count as 11 or 1, subsequent aces can only count as 1
        if c.rank == 1 then
            numAces = numAces + 1
            if numAces == 1 then
                value1 = value1 + 1
                value2 = value2 + 11
            else
                value1 = value1 + 1
                value2 = value2 + 1
            end
        else
            value1 = value1 + c.points
            value2 = value2 + c.points
        end
    end

    if numAces > 0 then
        if value2 > 21 then
            return {value1}
        else
            return {value1, value2}
        end
    else
        return {value1}
    end
end

function Hand:highestValue()
    -- if we have two possible values (with an ace) return the highest
    highestValue = 0
    for i, v in ipairs(self:value()) do
        if v > highestValue then
            highestValue = v
        end
    end
    return highestValue
end

function Hand:isBust()
    -- we will only have one value if we are bust
    return self:value()[1] > 21 
end

function Hand:isBlackjack()
    return self:highestValue() == 21
end

function Hand:shouldDealerHit()
    -- dealer should hit if 17 or under. we need thi highest value if an ace is present
    return self:highestValue() < 17 
end

function Hand:printValue()
    count = 0
    outText = ''
    for i, v in ipairs(self:value()) do
        count = count + 1
        if count == 1 then
            outText = v
        else
            outText = outText .. ' or ' .. v
        end
    end
    return outText
end

function Hand:print()

    if self.hideHand and self.count == 2 then
        return self.cards[1]:shortName() .. '  [  ]' .. ' Value: ' .. self.cards[1].points
    else
        outText = ''
        for i,c in ipairs(self.cards) do
            if i > 1 then
                outText = outText .. '  '
            end
            outText = outText .. c:shortName()
        end
        return outText .. ' Value: ' .. self:printValue()
    end
end

