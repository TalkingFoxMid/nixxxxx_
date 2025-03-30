let
  # Add your SSH public key here
  user = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGKTaxq/8pkeergjW+jyAIWw7mowK7UQsppt9//3a7QdKh1RT0JrStKG+TrdHwRTCwiB2N9cVBtZ5ld8LjjsZ4IBU4ATVPos2bw4RnPx8SUVV79V6HTJC8U2QYZJNtRaNUhmcEBIiqRyqUuT/1PbvHTsZ3hOF6+Q8J5n4JAkq8jaeQAJylgAi1aP/UiRV1+gC3xwmkhOw4kzPxd5zz3r8ReMivjvLJrFrBF+ZM3UYBnMybpcxqVTGT+VaSwnEAJ4uooLJtGzfdxpc43vhJsgrbiurLhhlOoiSYAJ1hslJ5H8z+WYASEY4PdZkS0LNsyAlBU3dBB9gj++tpT1jq3pxqpN+oma5/v9Q5CKmkNiyjI7+zW4jeOQ9aBFzBnSjTEEhEv1qIS4HkBNLQ5EZPcGUtmJDhdctMSyK9Y3zHhk7CErKL4EYVKLdvsncfaT+UjR+y31RwYvLsl4QoVXjl2wT8mrRuqpe9yAhztWjCH7K7gtSc7hwA4uoS1Iug5jxdevE= i.bashkarov@macbook-i.bashkarov"; # Replace with your actual SSH public key

  # Add your system's host key - you can find it at /etc/ssh/ssh_host_ed25519_key.pub
  system = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmdJur7lOz4gJ/ZEn0Dag9eJxUbF3xOORhVjNRgIpj5ycLnRO4itY8jQRjF2M1QI+SS8Gm1rxAWOLTFVM7TVX0dTKvq8zkY/87O+JGEORf4SeBU/8rlobCVqKVjnbPhUskLOaJ1QtHwO0RY4rWfV/dgo/iGaoVQ6gwCeD5ZPx69l3caSl2OFFpZz7MLDkmegRKJbkmRbgyHpERbjYSIwMzWzrS6FiuUWiU4WoloxJPFKdNB6f61b0SHYxc56E+ovMYl1xaTDp0j+4k32tJI2YUeC8iHdmldwdpHoT3ioGAYkubDpvC+UYniT8ejcMQTKcg/VXX+Nt8SxI5U8dWGjQ6N+p4vHV3qwTBvvPRrwITx5/6HaioLeb8a/vcX/nA9Ovs0uM8Rlnnc8VD7MwtOi1j3grwLou5UzbC2hopo5mYxDUDvJaUJcNUzMZva3m9oCNU+3k1m09kbTM7cYZut4oZthmxpRz3BVvGnKjVR9IPm37nXU6kPOlFhDpLdTX5/rB+ze78SdnvM4hus+CWQsZqfKZtjcWeAg4yRp0eysOL68Jr8KrH65/j6fpOREy/E1GcOz2pGGPr7A5MWS1bYb/I6yak+aRCjdLa5LCRImKsbXs9gVhfOMQHlSX20P+Swuv+GQgzB0eYiT7ehNooCCwmVAZ54BNhIumEOmaHCLbx0Q== root@nixos"; # Replace with your system's host key
  
  allKeys = [ user system ];
in
{
  "webdav-credentials.age".publicKeys = allKeys;
  "openvpn-config.age".publicKeys = allKeys;
}
