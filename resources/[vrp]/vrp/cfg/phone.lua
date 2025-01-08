local cfg = {}

cfg.services = {
  
  ["Taxi"] = {
    blipid = 523,
    blipcolor = 46,
    alert_time = 180,
    alert_notify = "Info: ~y~Apel Taxi: ~w~",
    notify = "Succes: ~w~Ai dat comanda la ~y~Taxi.",
    answer_notify = "Succes: ~w~Comanda ta la ~y~Taxi ~w~a fost acceptata."
  },
  ["Hitman"] = {
    blipid = 119,
    blipcolor = 49,
    alert_time = 180,
    alert_notify = "Info: ~r~Apel Hitman: ~w~",
    notify = "Succes: ~w~Ai dat comanda la ~r~Hitman.",
    answer_notify = "Succes: ~w~Comanda ta la ~r~Hitman ~w~a fost acceptata."
  },
  ["Traficant de Arme"] = {
    blipid = 110,
    blipcolor = 68,
    alert_time = 180,
    alert_permission = "strange.armele",
    alert_notify = "Info: ~b~Apel Traficant: ~w~",
    notify = "Succes: ~w~Ai dat comanda la ~b~Traficant de Arme.",
    answer_notify = "Succes: ~w~Comanda ta la ~b~Traficant de Arme ~w~a fost acceptata."
  },
  ["Mecanic"] = {
    blipid = 402,
    blipcolor = 17,
    alert_time = 180,
    alert_permission = "mecanic.service",
    alert_notify = "Info: ~o~Apel Mecanic: ~w~",
    notify = "Succes: ~w~Ai dat comanda la ~o~Mecanic.",
    answer_notify = "Succes: ~w~Comanda ta la ~o~Mecanic ~w~a fost acceptata."
  }
}

return cfg