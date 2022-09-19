-- Firmware for microcontroller relays

local m = component.proxy(component.list("modem")())

while true do
    local name, data = computer.pullSignal()
    if (name == "modem_message") then
        local _, _, from, port, _, message = data
        relaySignal(from, port, message)
    end
end

function relaySignal(port, message)
    if not m.isOpen(port) then
        m.open(port)
    end
    m.broadcast(port, message)
end