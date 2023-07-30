variable "TAG" {
  default = "dev-v3.3.1-buildx"
}

group "default" {
  targets = ["base", "go", "nodejs", "python"]
}

target "base" {
  args = {
    HTTPS_PROXY = "http://172.31.189.234:1081"
  }
  context = "./base"
  dockerfile = "buildx/Dockerfile"
  platforms = ["linux/amd64"]
  tags = ["docker.io/2030047311/builder-base:${TAG}"]
}

target "go" {
  args = {
    HTTPS_PROXY = "http://172.31.189.234:1081"
  }
  context = "./go"
  dockerfile = "buildx/Dockerfile"
  platforms = ["linux/amd64"]
  tags = ["docker.io/2030047311/builder-go:${TAG}"]
}

target "nodejs" {
  args = {
    HTTPS_PROXY = "http://172.31.189.234:1081"
  }
  context = "./nodejs"
  dockerfile = "buildx/Dockerfile"
  platforms = ["linux/amd64"]
  tags = ["docker.io/2030047311/builder-nodejs:${TAG}"]
}

target "python" {
  args = {
    HTTPS_PROXY = "http://172.31.189.234:1081"
  }
  context = "./python"
  dockerfile = "buildx/Dockerfile"
  platforms = ["linux/amd64"]
  tags = ["docker.io/2030047311/builder-python:${TAG}"]
}
