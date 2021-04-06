project = "example-nodejs"

app "example-nodejs" {
  labels = {
    "service" = "example-nodejs",
    "env"     = "dev"
  }

  runner {
    enable = true

    data_source "git" {
      url  = "https://github.com/briancain/waypoint-kubernetes-nodejs.git"
      path = "."
    }
  }

  build {
    use "pack" {}
    registry {
      use "docker" {
        image = "localhost:5000/example-nodejs"
        tag   = "1"
        local = false
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
      probe {
        initial_delay = 30
      }
    }
  }

  release {
    use "kubernetes" {
    }
  }
}
