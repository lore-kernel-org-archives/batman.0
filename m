Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 02 Oct 2013 18:34:15 +0200
Message-ID: <2038458.nCDZnQrXiI@sven-desktop>
In-Reply-To: <20131002131915.GB24077@pandem0nium>
References: <1380659032-14488-1-git-send-email-andrew@lunn.ch>
 <1380659032-14488-2-git-send-email-andrew@lunn.ch>
 <20131002131915.GB24077@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1559857.hEY13SokyN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv1] alfred: Add support for passing
	location information over alfred.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>, "Janne.Paatero@ruag.com" <Janne.Paatero@ruag.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1559857.hEY13SokyN
Content-Type: multipart/mixed; boundary="nextPart4531969.LZjOllCXli"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart4531969.LZjOllCXli
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 02 October 2013 06:19:15 Simon Wunderlich wrote:
> > +# alfred build
> > +BINARY_NAME = alfred-gpsd
> > +OBJ = alfred-gpsd.o
> > +
> > +# alfred flags and options
> > +CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
> > +LDLIBS += -lgps
> 
> I have no idea if we need some special handling for this to let it work
> for crosscompiling, OpenWRT etc?

Please use pkg-config for things like this. An example Makefile is attached.

@Simon: Please fix your e-mail adress inside the README file.

Kind regards,
	Sven
--nextPart4531969.LZjOllCXli
Content-Disposition: attachment; filename="Makefile"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-makefile; charset="UTF-8"; name="Makefile"

#!/usr/bin/make -f
# -*- makefile -*-
#
# Copyright (C) 2013 B.A.T.M.A.N. contributors
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of version 2 of the GNU General Public
# License as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA
#

# alfred build
BINARY_NAME = alfred-gpsd
OBJ = alfred-gpsd.o

# alfred flags and options
CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP

# disable verbose output
ifneq ($(findstring $(MAKEFLAGS),s),s)
ifndef V
	Q_CC = @echo '   ' CC $@;
	Q_LD = @echo '   ' LD $@;
	export Q_CC
	export Q_LD
endif
endif

ifeq ($(origin PKG_CONFIG), undefined)
  PKG_CONFIG = pkg-config
  ifeq ($(shell which $(PKG_CONFIG) 2>/dev/null),)
    $(error $(PKG_CONFIG) not found)
  endif
endif

ifeq ($(origin LIBGPS_CFLAGS) $(origin LIBGPS_LDLIBS), undefined undefined)
  LIBGPS_NAME ?= libgps
  ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBGPS_NAME) 2>/dev/null),)
    $(error No $(LIBGPS_NAME) development libraries found!)
  endif
  LIBGPS_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(LIBGPS_NAME))
  LIBGPS_LDLIBS +=  $(shell $(PKG_CONFIG) --libs $(LIBGPS_NAME))
endif
CFLAGS += $(LIBGPS_CFLAGS)
LDLIBS += $(LIBGPS_LDLIBS)

# standard build tools
CC ?= gcc
RM ?= rm -f
INSTALL ?= install
MKDIR ?= mkdir -p
COMPILE.c = $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
LINK.o = $(Q_LD)$(CC) $(CFLAGS) $(LDFLAGS) $(TARGET_ARCH)

# standard install paths
PREFIX = /usr/local
SBINDIR = $(PREFIX)/sbin

# try to generate revision
REVISION= $(shell	if [ -d ../.git ]; then \
				echo $$(git describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
			fi)
ifneq ($(REVISION),)
CPPFLAGS += -DSOURCE_VERSION=\"$(REVISION)\"
endif

# default target
all: $(BINARY_NAME)

# standard build rules
.SUFFIXES: .o .c
.c.o:
	$(COMPILE.c) -o $@ $<

$(BINARY_NAME): $(OBJ)
	$(LINK.o) $^ $(LDLIBS) -o $@

clean:
	$(RM) $(BINARY_NAME) $(OBJ) $(DEP)

install: $(BINARY_NAME)
	$(MKDIR) $(DESTDIR)$(SBINDIR)
	$(INSTALL) -m 0755 $(BINARY_NAME) $(DESTDIR)$(SBINDIR)

# load dependencies
DEP = $(OBJ:.o=.d)
-include $(DEP)

.PHONY: all clean install

--nextPart4531969.LZjOllCXli--

--nextPart1559857.hEY13SokyN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAABCgAGBQJSTEsHAAoJEF2HCgfBJntGpxQP/2As6+jhH6slD+YvXVuPISiR
btrOXEj9tqIob8DaqLatFXWs5RaoCrVq9GLXOxjbtxmrr31HH+4/GdDEfpN3HEfo
enGeF39liWv0umnt0HAuULBLoncQZB3JZV/F0Hx5U56wagesDlqIVj9M43oXIImA
nZNB6zy/34G+oy0ykVwTLReY1mTTDMnT0HLIXYRuD/RSqvUbpd7P02kh88oVAfMR
qPbmwyu7wnPueGDBR1s4SuPQiM+etQxZwmHMmlmlby+Qa39FKNci48DBFP24I5qb
Mp4JbujC9uxCVOzNiSiWCtfJ9Rn2D9l2Lqmc7LHdfkfNf94Rd4EDenMPLiZNlxhe
//CMvwU4572qtkiIr6FZmsD8bpEd7f6ss2Y3TixSFTbKelZj4d7eP3U5TtaNdd1k
fEtgxl5dVCEehKl3oImW4jyOwdySoWpJvHUKy4ZpzVigPP47v5kgIN0EJ8GmsjHY
G5EqaZ744RJMOHMKssEcKYga4ZZYabQJ7pxjAjImWjvizovxCmyJNfcea5KG9Fan
k998uSQGBxM04O5z4CUJT0ShBEaqNk+QtXU+VPS1u2PlcwLGCPt70WkwThDTquvE
bV/VEUzKBlUrbr1LhR46chGN7o8joZUAyG3zCWWIJDjfRpP44SNXxoh0lTuA2JPy
lytBbIiEqOAcx/WDS54B
=OPfY
-----END PGP SIGNATURE-----

--nextPart1559857.hEY13SokyN--

