Return-Path: <are@lihas.de>
Date: Wed, 30 Mar 2016 21:55:05 +0200
From: Adrian Reyer <are@lihas.de>
Message-ID: <20160330195505.GA21460@r2d2.s.lihas.de>
Reply-To: b.a.t.m.a.n@lists.open-mesh.org
References: <56F5AF2F.6060904@t-online.de> <34764958.y3lWsCmXTL@prime>
 <20160330135842.GA19985@r2d2.s.lihas.de>
 <2628962.NH5e8Bopbi@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <2628962.NH5e8Bopbi@bentobox>
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 06:08:49PM +0200, Sven Eckelmann wrote:
> I never used fastd. So maybe you can tell me if I summarize it correctly:

Well, fastd is only a sample, though a very much used one within
freifunk.

>  * fastd creates point2point vpn-links and makes all of them accessible v=
ia
>    tapX

yes

>  * fastd only sends broadcast to its direct neighbors (vpn-links)

yes, there is a real broadcast mode, but without loop avoidance, this is
basically never used.

>  * the fastd daemon doesn't set some flag to indicate that it doesn't rea=
lly
>    support broadcasts

yes

>  * you want batman-adv to behave on this tapX exactly like on adhoc (maybe
>    with less re-broadcasts than on adhoc) to keep everything in the same
>    broadcast domain

yes

> And for tinc you most likely have configured mst for broadcasts ("tinc
> handles the forwarding via spanning tree") and don't need batman-adv
> anymore for re-broadcasts.

indeed
Please be aware fastd is only one sample of a vpn solution, there are
many others, and most of them unforseeable to us. The suggested flag
would fit all of them while not disturbing the save, but traffic
consuming default.

Regards,
	Adrian
--=20
LiHAS - Adrian Reyer - Hessenwiesenstra=C3=9Fe 10 - D-70565 Stuttgart
Fon: +49 (7 11) 78 28 50 90 - Fax:  +49 (7 11) 78 28 50 91
Mail: lihas@lihas.de - Web: http://lihas.de
Linux, Netzwerke, Consulting & Support - USt-ID: DE 227 816 626 Stuttgart

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVvwvGXn8862ZCBs9AQI5SQf+Jcc60YcbLAEuovlnnvrOGXlk4EeeTv0f
gZFh2UPg2xbm+jldHclKgzFRuZJoYrqMARH4s114NfEVSgxnSKNQmyK1RNS8BIdQ
65YnAweCdqIX0h239rGlV9UFX1wJBR24rrihknHMr3BVBskwf9NzwfyoBLafO6Dt
z2s283rOEZ+0zhHy6L8ivrL09bIPnUimKw4rNtv2Io8CK7+feSZyEsem0128O8zi
1vySShu199P6kTuvZqDheWlPA71adIEwrCwAsY0PVQDHbTO749x4nFiYzr+QqYG8
6TGM+U3zQxdISCPOlcvnYDh5838C4pKnegx9I1y38kEHqhBd7iNiSQ==
=p7hk
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
