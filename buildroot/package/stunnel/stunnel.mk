################################################################################
#
# stunnel
#
################################################################################

STUNNEL_VERSION = 5.09
STUNNEL_SITE = http://www.usenix.org.uk/mirrors/stunnel/archive/5.x
STUNNEL_DEPENDENCIES = openssl
STUNNEL_CONF_OPTS = --with-ssl=$(STAGING_DIR)/usr --with-threads=fork \
	--disable-libwrap
STUNNEL_LICENSE = GPLv2+
STUNNEL_LICENSE_FILES = COPYING COPYRIGHT.GPL

ifeq ($(BR2_INIT_SYSTEMD),y)
STUNNEL_DEPENDENCIES += systemd
else
STUNNEL_CONF_OPTS += --disable-systemd
endif

define STUNNEL_INSTALL_CONF
	$(INSTALL) -m 0644 -D $(@D)/tools/stunnel.conf \
		$(TARGET_DIR)/etc/stunnel/stunnel.conf
	rm -f $(TARGET_DIR)/etc/stunnel/stunnel.conf-sample
endef

STUNNEL_POST_INSTALL_TARGET_HOOKS += STUNNEL_INSTALL_CONF

define STUNNEL_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/stunnel/S50stunnel $(TARGET_DIR)/etc/init.d/S50stunnel
endef

$(eval $(autotools-package))
