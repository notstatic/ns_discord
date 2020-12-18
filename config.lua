c = {}

c.discord = false -- true/false  vaaditaanko discordia, jotta palvelimelle pääsee
c.xboxlive = false -- true/false  vaaditaanko xbox liveä, jotta palvelimelle pääsee
c.liveid = false -- true/false  vaaditaanko LiveIDtä, jotta palvelimelle pääsee
c.log = false -- true/false  Logaa pelaajien connectaamisen, ja poistumisen palvelimelta

if c.log == true then
    c.webhook = ""
    c.avatar = 'https://i.imgur.com/bsMQWGJ.png' -- Webhookin avatar päättyy .png, .jpeg tms.
    c.logip = false -- false/true
end