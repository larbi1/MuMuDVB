There are many packages in the wild that are not cross build aware. They fail compiling some files, use wrong include paths or try to link against host libraries. To be sucessful in the embedded world, these types of failures
must be fixed. If required, PTXdist provides such fixes per package. They are organized in patch series and can
be found in the patches/ directory within a subdirectory using the same name as the package itself.

PTXdist uses the utility patch or quilt to apply an existing patch series after extracting the archive. So, every patch
series contains a set of patches and one series file to define the order in which the patches must be applied.

Besides the patches/ directory at the main installation location, PTXdist searches two additional locations for a
patch series for the package in question.