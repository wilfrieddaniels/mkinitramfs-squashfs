#
# Copyright (C) Patryk Jaworski <regalis@regalis.com.pl>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
# 
#
DESTDIR?=pkg
DESTDIR:=$(patsubst %/,%,$(DESTDIR))

install: $(DESTDIR)
	install -m 644 -D src/hooks/squashfs $(DESTDIR)/usr/lib/initcpio/hooks/squashfs
	install -m 644 -D src/install/squashfs $(DESTDIR)/usr/lib/initcpio/install/squashfs
	install -m 755 -D src/sqsh-shutdown $(DESTDIR)/usr/lib/initcpio/sqsh-shutdown
	install -m 644 -D src/install/sqsh-shutdown $(DESTDIR)/usr/lib/initcpio/install/sqsh-shutdown
	install -m 644 -D src/systemd/mkinitcpio-generate-shutdown-ramfs-sqsh.service $(DESTDIR)/usr/lib/systemd/system/mkinitcpio-generate-shutdown-ramfs-sqsh.service
	install -d $(DESTDIR)/usr/lib/systemd/system/shutdown.target.wants
	ln -s ../mkinitcpio-generate-shutdown-ramfs-sqsh.service \
        $(DESTDIR)/usr/lib/systemd/system/shutdown.target.wants/mkinitcpio-generate-shutdown-ramfs-sqsh.service 

uninstall:
	rm $(DESTDIR)/usr/lib/initcpio/hooks/squashfs
	rm $(DESTDIR)/usr/lib/initcpio/install/squashfs
	rm $(DESTDIR)/usr/lib/initcpio/sqsh-shutdown
	rm $(DESTDIR)/usr/lib/initcpio/install/sqsh-shutdown
	rm $(DESTDIR)/usr/lib/systemd/system/mkinitcpio-generate-shutdown-ramfs-sqsh.service
	rm $(DESTDIR)/usr/lib/systemd/system/shutdown.target.wants/mkinitcpio-generate-shutdown-ramfs-sqsh.service 

$(DESTDIR):
	mkdir $@

$(DESTDIR)/%:
	@echo "Installing $@"

.PHONY: install uninstall package
