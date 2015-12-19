Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 Dec 2015 10:32:22 +0100
Message-ID: <1831238.xY0O8bfIys@bentobox>
In-Reply-To: <20151219080405.GJ30160@otheros>
References: <1448901241-30844-1-git-send-email-sw@simonwunderlich.de>
 <20151219080405.GJ30160@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8386580.CRxJ9KV3UN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix lockdep splat when
	doing mcast_free
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
Cc: Simon Wunderlich <simon@open-mesh.com>

--nextPart8386580.CRxJ9KV3UN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 19 December 2015 09:04:05 Linus L=FCssing wrote:
> > From: Simon Wunderlich <simon@open-mesh.com>
> >=20
> > While testing, we got something like this:
> >=20
> > WARNING: CPU: 0 PID: 238 at net/batman-adv/multicast.c:142 batadv_m=
cast_mla_tt_retract+0x94/0x205 [batman_adv]()
> > [...]
> > Call Trace:
> > [<ffffffff815fc597>] dump_stack+0x4b/0x64
> > [<ffffffff810b34dc>] warn_slowpath_common+0xbc/0x120
> > [<ffffffffa0024ec5>] ? batadv_mcast_mla_tt_retract+0x94/0x205 [batm=
an_adv]
> > [<ffffffff810b3705>] warn_slowpath_null+0x15/0x20
> > [<ffffffffa0024ec5>] batadv_mcast_mla_tt_retract+0x94/0x205 [batman=
_adv]
> > [<ffffffffa00273fe>] batadv_mcast_free+0x36/0x39 [batman_adv]
> > [<ffffffffa0020c77>] batadv_mesh_free+0x7d/0x13f [batman_adv]
> > [<ffffffffa0036a6b>] batadv_softif_free+0x15/0x25 [batman_adv]
> > [...]
> >=20
> > Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
>=20
> Fixes: 5b95c427d187 ("batman-adv: Annotate deleting functions with ex=
ternal lock via lockdep")
> Acked-by: Linus L=FCssing <linus.luessing@c0d3.blue>

I am confused why this should fix a commit which is there to find such =
problems.

Kind regards,
=09Sven
--nextPart8386580.CRxJ9KV3UN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWdSQmAAoJEF2HCgfBJntGUWIP/RN0zkR3kwCzwwVxdnwItOnh
Eu1+I9lTvMhTe/CskAMNZLFYj08Ip13ZtXlDTJxELCeu099ftnZFZrOxYqVY4XeZ
ztw/ANr+GcqeMLOUHoViXSY/GPilchyLPyVabrCFK42ZOsZ6K1xHOCu0dCrEGHPS
aOzdjYW1UK7D9LKbtaN1WNLEiu0+PgfuVtGW7I7UHKMVZoXEG9fw6k5/Siw0qYKK
cJhinLTeRfGVkFLEX7P8kEthxUc8rLrDo/wZO3pjGcKEPmMlooSGaVfJqnjxsnc8
xW4VmEWrCUFDsAUd9GbVXTB3TBKYxdZgD4FesBBdtarQHWLJFgtDmJHO59xF2Jrm
FEhUPstjB4MmPE1Clr2jHyYmWaHajMQVoRsGBGklasVDGVkMmcWcrIIMLZtChG+d
cpYLAde1l/W6yXJ8E8ZA3oU3v5aHVPFvdpya7rRy6AUoE4czDtPNUPO2H6qs2C72
W/6Mso1vfd8zMrkrXoVNkcZsYSdN2v8B9F7LL0IbKCeI3WwzT35rAfK0mZ0q4rOq
3HdfA2RnQeA/JPZcmO/BpeTBPl6aBEiaxBP6d+RFd3TX/90em0E4pfk+lsRKlsRf
qmputRlUmReuhl89w2/4pYuDF23Kzd4P8vGqxocf+1Ov2nzc11xYTWjDCRtsA4Z6
eFHjo+GzW/OZVuOqCxX0
=6fvi
-----END PGP SIGNATURE-----

--nextPart8386580.CRxJ9KV3UN--

