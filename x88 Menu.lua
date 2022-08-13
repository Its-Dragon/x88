--[[

    Project: x88Cheats Menu
    Author: Dragon
    LUA API: Primordial

]]

local font = render.create_font("Tahoma", 14, 700);

local local_player = entity_list.get_local_player();
local player_index = entity_list.get_local_player():get_index()

local kills = nil
local deaths = nil
local ping = nil
local kd = nil

local function create_move(cmd)
    local local_player = entity_list.get_local_player();

    if engine.is_in_game() then
        real = engine.get_view_angles(x, y, z);
        lby = local_player:get_prop("m_flLowerBodyYawTarget");
    end
end

local function welcome()
    if engine.is_in_game() then
        kills = player_resource.get_prop("m_iKills", player_index);
        deaths = player_resource.get_prop("m_iDeaths", player_index);
        ping = player_resource.get_prop("m_iPing", player_index);
        kd = kills / deaths;
    end

    if kills == nil or deaths == nil or kd == nil or ping == nil then
        kills = 0
        deaths = 0
        kd = 0
        ping = 0
    end

    render.text(font, "x88Cheats", vec2_t(5, 35), color_t(192, 108, 129));
    render.text(font, "Hello " .. user.name .. " :)", vec2_t(300, 7), color_t(252, 211, 3));

    render.text(font, "Real: " .. math.floor(real.y * 100) / 100, vec2_t(300, 37), color_t(255, 255, 255));
    render.text(font, "LBY: " .. math.floor(lby * 100) / 100, vec2_t(410, 37), color_t(255, 255, 255));
    render.text(font, "Diff: " .. math.floor((real.y - lby) * 100) / 100, vec2_t(500, 37), color_t(255, 255, 255));
    render.text(font, "Kills: " .. kills, vec2_t(500, 150), color_t(255, 255, 255));
    render.text(font, "Deaths: " .. deaths, vec2_t(520, 165), color_t(255, 255, 255));
    render.text(font, "KD: " .. math.floor(kd * 100) / 100, vec2_t(500, 180), color_t(255, 255, 255));
    render.text(font, "Ping: " .. ping, vec2_t(500, 195), color_t(255, 255, 255))
end

local function main()
    welcome()
end

callbacks.add(e_callbacks.DRAW_WATERMARK, main);
callbacks.add(e_callbacks.SETUP_COMMAND, create_move);