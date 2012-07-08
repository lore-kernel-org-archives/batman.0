Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 8 Jul 2012 12:09:56 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120708100956.GA10210@pandem0nium>
References: <CAHD-aqKaF4tfsMBQLnyrn4wkqDHQpPjsfCDjhXPzrCbkzM7tsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <CAHD-aqKaF4tfsMBQLnyrn4wkqDHQpPjsfCDjhXPzrCbkzM7tsg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] 2012.2 OGMs over ethernet issue?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Guido,

On Sat, Jul 07, 2012 at 12:37:24AM -0300, Guido Iribarren wrote:
> Hello again nice folks,
> I updated today another segment of the network with just 4 nodes, to
> batman-adv 2012.2 (the one i compiled yesterday with simon patches for
> blaII, marek stability fixes, and debug log enabled , yikes!)
> and i couldn't get batman to work over wired ethernet?? (?)
>=20
> P -(50mts wlan)- D -----(ubnt transparent bridge) 2km -- C
>  \----eth-------------------/
>=20
> Node P and D connected by ethernet on eth0 but close enough that could
> also see each other through adhoc wlan, with bla enabled, correctly
> preferred ethernet connection to communicate between them (iperf
> yielded 92mbps), so far so good.

As seen on the dump, you only use eth0 in batman? Is the Ad-Hoc connection
still active (on wlan0 or wlan-1)?

> now, node D and C, too far away from each other to communicate over
> wlan, but connected by a "loooong eth cable" (mediated by a wds
> transparent bridge) wouldn't find each other batman originator.
> C originator table was empty, and D only showed P.
> I thought the transparent bridge was misbehaving, so I tried in a
> simpler setup using P and D, with the wifi off:
> but after disabling wlan0 (batctl if del wlan0-2) and adding eth0
> (batctl if add eth0) on both nodes, batman could not see each other
> anymore :(
> i thought i was doing something wrong, so i tried in different ways,
> but could not get it to work.
> batctl td eth0 shows both outgoing OGMs from local , and incoming OGMs
> from remote,
> but batctl l only reported outgoing OGMs.
>=20
> http://pastebin.com/7DDUaXu1

Mhm, that's weird indeed. Is eth0 really not included in any other bridge?
It looks like the incoming packets don't reach BATMAN for some reason.

Also have you checked that the WDS bridge works via IP? You could first set
up some IP addresses and ping each other, confirm traffic with tcpdump, and
then activate batman-adv to see if the OGMs go through. So far, it  doesn't
seem like anything from your C node comes through at all.

Cheers,
	Simon

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk/5XHQACgkQrzg/fFk7axa+ewCfcRyHh6HGSkM6hIYRhucVdWal
SbsAnjhDN2rYnw9Uc70+N1HZnD82CfEL
=fcKB
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
