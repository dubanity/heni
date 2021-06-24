--[[
    Discordia API:
    > https://github.com/SinisterRectus/Discordia
    > https://github.com/SinisterRectus/Discordia/wiki/Installing-Discordia

    Luvit:
    > https://luvit.io/
    > https://github.com/luvit/luvit
]]

local discordia = require('discordia')
local json = require('json')
local coro = require('coro-http')
local client = discordia.Client()

function Say(data, messageHandler)
    if data == "pong" then
        messageHandler:reply(tostring(data))
        return
    end
end

client:on("messageCreate", function(message)
    local content = message.content:lower()
    local bot_id = 000000000000000000
    if content == "ping" then
        Say("pong", message)
    end
    if content:sub(1, #"cool") == "cool" then
        local mentioned = message.mentionedUsers
        if #mentioned == 1 then
            message:reply("<@!"..mentioned[1][1].."> is "..math.random(1, 100).."% cool")
        elseif #mentioned == 0 then
            message:reply("<@!"..message.member.id.."> is "..math.random(1, 100).."% cool")
        end
    end
    if content == "remote spy" or content == "remotespy" then -- string patterns lol
        message:reply(io.open("./scripts/remote-spy.txt", "r"):read("*a"))
    end
    if content == "embed" then
        message:reply{
            embed = {
                title = "test";
                color = discordia.Color.fromRGB(160, 165, 245).value;
            };
        }
    end
    if content:sub(1, #"punish") == "punish" then
        local mentioned = message.mentionedUsers
        local member = message.guild:getMember(mentioned[1][1])
        local admin = message.member.name
        message:reply{
            embed = {
                title = "Audit Log";
                fields = {
                    {name = tostring(admin); value = " has issued a punish command on "..tostring(member.username); inline = false}
                };
                color = discordia.Color.fromRGB(200, 0, 0).value;
            };
        }
    end
end)

client:run("Bot "..io.open("./auth.txt", "r"):read())