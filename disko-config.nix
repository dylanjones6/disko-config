{
  disko.devices = {
    disk = {
      disk0 = {
        type = "disk";
        device = "/dev/TODO";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
		name= "crypted";
		#extraOpenArgs = [ ];
		settings = {
		  keyFile = "/etc/secret.key";
		  allowDiscards = true;
		};
                # additionalKeyFiles = [ "/tmp/anotherkey.key" ] ;
		content = {
                  type = "filesystem";
		  format = "ext4";
		  mountpoint = "/";
		};
	      };
	    };
          }; 
	};
      };
      disk1 = {
	type = "disk";
	device = "/dev/TODO";
	content = {
	  type = "gpt";
	  partitions = {
            mdadm = {
	      size = "100%";
	      content = {
	        type = "mdraid";
		name = "raid1";
	      };
	    };
	  };
	};
      };
      disk2 = {
	type = "disk";
	device = "/dev/TODO";
	content = {
	  type = "gpt";
	  partitions = {
            mdadm = {
	      size = "100%";
	      content = {
	        type = "mdraid";
		name = "raid1";
	      };
	    };
	  };
	};
      };
    };
    mdadm = {
      raid1 = {
	type = "mdadm";
	level = 1;
	content = {
	  type = "luks";
	  name = "crypted";
	  settings.keyFile = "/etc/secret.key";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/data";
	  };
	};
      };
    };
  };
}
