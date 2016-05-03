Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 04 May 2016 04:16:23 +0800
Message-ID: <9583103.SiJDGOReDv@voltaire>
In-Reply-To: <20160503122046.GK16990@lunn.ch>
References: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
 <3295917.zMxpBmcd5T@bentobox> <20160503122046.GK16990@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart29271675.UaAF8IR8xs";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Use netlink to replace some of
	debugfs
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: a@unstable.cc

--nextPart29271675.UaAF8IR8xs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 03, 2016 14:20:46 Andrew Lunn wrote:
> On Tue, May 03, 2016 at 09:07:35AM +0200, Sven Eckelmann wrote:
> > [...]
> > 
> > > +ifeq ($(origin LIBNL_GENL_CFLAGS) $(origin LIBNL_GENL_LDLIBS),
> > > undefined undefined) +  LIBNL_GENL_NAME ?= libnl-genl-3.0
> > > +  ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBNL_GENL_NAME)
> > > 2>/dev/null),) +    $(error No $(LIBNL_GENL_NAME) development libraries
> > > found!)
> > > +  endif
> > > +  LIBNL_GENL_CFLAGS += $(shell $(PKG_CONFIG) --cflags
> > > $(LIBNL_GENL_NAME))
> > > +  LIBNL_GENL_LDLIBS += $(shell $(PKG_CONFIG) --libs $(LIBNL_GENL_NAME))
> > > +endif
> > > +CFLAGS += $(LIBNL_GENL_CFLAGS)
> > > +LDLIBS += $(LIBNL_GENL_LDLIBS)
> >
> > 
> >
> > @Simon, @Matthias, @Antonio, @Marek: Should the header file be included in
> > batctl like nl80211.h in iw. Or should we always require the current
> > kernel
> > header files installed to build batctl?
> 
> Once the code is mostly complete and stable, i think a local copy
> would be good. It does seems to be the common way.

A local copy sounds like a sensible choice and common practice.

Cheers,
Marek


--nextPart29271675.UaAF8IR8xs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXKQcXAAoJEFNVTo/uthzAi2EH/jL6lqQ5GpqV6R3MVwiO5itJ
/1Ff/wezRY5gOC7G4aruXnUssiA63qQHFSshVblBZ8YUqMs+fs37LWtjWn1rK1oS
0RS3QM5dXD2Q8qFFd/L5giDpaMS6MNXF2ucs7zZLn0zxVPexrYFZWzh5DI/7d/mX
r9XqLkwNJ/cQYITXhIwxJDW4xknGP2mIpa+Ib5GKgUWmWbiLjcA3K7/ZxsYEpltC
8Vu+8quhiJ4Fp+qrriJP2NFWObOyU5R7KmvF7I1CHYJOctKScRgJII8aELveuGI7
WU5JIHMEEfXmYh3jLOdHo1+XdyO45X+4pcBHuMNV9jKNzEaPXYObzkGO+j9dfx8=
=ZpSk
-----END PGP SIGNATURE-----

--nextPart29271675.UaAF8IR8xs--

