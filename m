Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 22 Apr 2015 10:10:19 +0800
Message-ID: <2191260.QcYmMjhaqG@voltaire>
In-Reply-To: <2376739.tkYtSexUdr@voltaire>
References: <1429612929-19765-1-git-send-email-sven@narfation.org>
 <2376739.tkYtSexUdr@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart142968736.BWd7q9gpom";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Document multicast compile
	time option
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart142968736.BWd7q9gpom
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, April 22, 2015 10:08:49 Marek Lindner wrote:
> On Tuesday, April 21, 2015 12:42:09 Sven Eckelmann wrote:
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -59,6 +59,7 @@ BUILD_FLAGS := \
> >
> >         CONFIG_BATMAN_ADV_NC=$(CONFIG_BATMAN_ADV_NC) \
> >         CONFIG_BATMAN_ADV_MCAST=$(CONFIG_BATMAN_ADV_MCAST) \
> >         INSTALL_MOD_DIR=updates/net/batman-adv/
> >
> > +export batman-adv-y += ../../compat.o
> >
> >  
> >  all: config
> >         $(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) modules
> 
> This hunk does not look like it should be part of this patch according to
> the  patch description ?!

Scratch that. You had already sent v2 without the hunk.

Cheers,
Marek

--nextPart142968736.BWd7q9gpom
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNwMLAAoJEFNVTo/uthzAoFEH/1PiDjllyhlDGu1tdjUpfFuA
WbBXzsLsccSFUud2AIFrKYpTnHIeyWyvUqfNvuJHPpLl8+jU28qv4jJbb1Uhp24R
T2nnjCt0VvaHzrppHVgR4mfyIZ6JeqVQPUzQh2KVwLPbbtaiImLHr0TK0b6dWRq0
wdAqSzotDH8PReLQasHRUJF+wm32ajIVUNVQYponZVW4vpJ+Fy9uPrlIeJNcKVGx
RMfgQpJ11DoSWndQnPz5kW/WX11KEhKugt8cqi0Ecbz/5Hl5YtPhXwiEiKt5Yxcy
6A9nhOykoSxus8lGdHncGcdjNKM9CgeCeDdZq13rD/dgjyplKQkZ4rO+H8coW6A=
=Zphr
-----END PGP SIGNATURE-----

--nextPart142968736.BWd7q9gpom--

