# List files recursively: In Unix the best is to use tree

$ tree . | head -n 10
.
├── Applications
│   ├── Chrome\ Apps.localized
│   │   ├── Icon\r
│   │   └── Readium.app
│   │       └── Contents
│   │           ├── Info.plist
│   │           ├── MacOS
│   │           │   └── app_mode_loader
│   │           ├── PkgInfo


# hadoop doesn't have tree, this is a workaround:
$ hadoop fs -ls -R  <hdfs_path>/ | awk '{print $8}' | sed -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'