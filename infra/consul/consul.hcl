# Consul Agent Configuration — AslamSys / Orange Pi 5 Ultra
# Docs: https://developer.hashicorp.com/consul/docs/agent/config

datacenter = "aslam-home"
data_dir   = "/consul/data"
log_level  = "WARN"

server           = true
bootstrap_expect = 1

bind_addr   = "0.0.0.0"
client_addr = "0.0.0.0"

ui_config {
  enabled = true
}

performance {
  raft_multiplier = 1
}

telemetry {
  prometheus_retention_time = "60s"
  disable_hostname          = true
}

# ─── ACL (descomente para produção) ──────────────────────────────────────────
# acl {
#   enabled                  = true
#   default_policy           = "deny"
#   enable_token_persistence = true
# }
