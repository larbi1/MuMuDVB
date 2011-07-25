# -*-makefile-*-
#
# Copyright (C) 2011 by Ludovic Boue <lboue@resel.fr>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MUMUDVB) += mumudvb

#
# Paths and names
#
MUMUDVB_VERSION	:= 1.6.1
MUMUDVB		:= mumudvb-$(MUMUDVB_VERSION)
MUMUDVB_SUFFIX	:= tar.gz
#MUMUDVB_URL		:= file://home/lboue/Téléchargements/Netstream/firmware/packages/$(MUMUDVB).$(MUMUDVB_SUFFIX)
MUMUDVB_URL		:= http://resel.fr/~lboue/mumudvb-1.6.1.tar.gz
MUMUDVB_SOURCE	:= $(SRCDIR)/$(MUMUDVB).$(MUMUDVB_SUFFIX)
MUMUDVB_DIR		:= $(BUILDDIR)/$(MUMUDVB)
MUMUDVB_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MUMUDVB_SOURCE):
	@$(call targetinfo)
	@$(call get, MUMUDVB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#MUMUDVB_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
MUMUDVB_CONF_TOOL	:= autoconf
#MUMUDVB_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

#$(STATEDIR)/mumudvb.prepare:
#	@$(call targetinfo)
#	@$(call clean, $(MUMUDVB_DIR)/config.cache)
#	cd $(MUMUDVB_DIR) && \
#		$(MUMUDVB_PATH) $(MUMUDVB_ENV) \
#		./configure $(MUMUDVB_CONF_OPT)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/mumudvb.compile:
	@$(call targetinfo)
	@$(call world/compile, MUMUDVB)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mumudvb.install:
	@$(call targetinfo)
	@$(call world/install, MUMUDVB)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mumudvb.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  mumudvb)
	@$(call install_fixup, mumudvb,PACKAGE,mumudvb)
	@$(call install_fixup, mumudvb,PRIORITY,optional)
	@$(call install_fixup, mumudvb,VERSION,$(MUMUDVB_VERSION))
	@$(call install_fixup, mumudvb,SECTION,base)
	@$(call install_fixup, mumudvb,AUTHOR,"Ludovic Boue <lboue@resel.fr>")
	@$(call install_fixup, mumudvb,DEPENDS,)
	@$(call install_fixup, mumudvb,DESCRIPTION,missing)

	@$(call install_copy, mumudvb, 0, 0, 0755, $(MUMUDVB_DIR)/src/mumudvb, /usr/bin/mumudvb)

	@$(call install_finish, mumudvb)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/mumudvb.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, MUMUDVB)

# vim: syntax=make
