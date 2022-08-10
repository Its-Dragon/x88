--[[

    Project: x88 Menu
    Author: Dragon
    LUA API: Primordial

]]

local font = render.create_font("Tahoma", 14, 700);

local real = nil
local lby = nil
local kills = nil
local deaths = nil
local kd = nil
local ping = nil

local function create_move(cmd)
    local local_player = entity_list.get_local_player();

    if engine.is_in_game() then
        real = engine.get_view_angles();
        lby = local_player:get_prop("m_flLowerBodyYawTarget");
    end
end

local function welcome()
    local local_player = entity_list.get_local_player();

    if engine.is_in_game() then
        kills = local_player:get_prop("m_iKills");
        deaths = local_player:get_prop("m_iDeaths");
        ping = local_player:get_prop("m_iPing");
        kd = kills / deaths;
    elseif kills == nil or deaths == nil or ping == nil then
        kills, deaths, ping, kd = "0", "0", "0", "0";
    end
    
    render.text(font, "x88Cheats", vec2_t(5, 35), color_t(192, 108, 129));
    render.text(font, "Hello " .. user.name .. " :)", vec2_t(300, 7), color_t(252, 211, 3));

    render.text(font, "Real: " .. math.floor(real * 100) / 100, vec2_t(300, 37), color_t(255, 255, 255));
    render.text(font, "LBY: " .. math.floor(lby * 100) / 100, vec2_t(410, 37), color_t(255, 255, 255));
    render.text(font, "Diff: " .. math.floor((real - lby) * 100) / 100, vec2_t(500, 37), color_t(255, 255, 255));
    render.text(font, "Kills: " .. kills, vec2_t(500, 150), color_t(255, 255, 255));
    render.text(font, "Deaths: " .. deaths, vec2_t(520, 165), color_t(255, 255, 255));
    render.text(font, "KD: " .. math.floor(kd * 100) / 100, vec2_t(500, 180), color_t(85 * kd, 100 * kd, 0 * kd));
    render.text(font, "Ping: " .. ping, vec2_t(500, 195), color_t(255, 255, 255))
end

local function main()
    -- Going to make this all automated var grabbing when I actually can test myself :)
    welcome()
end

callbacks.add(e_callbacks.DRAW_WATERMARK, main);
callbacks.add(e_callbacks.SETUP_COMMAND, create_move);