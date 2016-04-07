Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 07 Apr 2016 15:24:36 +0200
Message-ID: <4309384.f08z68H6K3@bentobox>
In-Reply-To: <4820570.LxUU2Z3eNS@prime>
References: <1458101205-26316-1-git-send-email-linus.luessing@c0d3.blue>
 <1458101205-26316-2-git-send-email-linus.luessing@c0d3.blue>
 <4820570.LxUU2Z3eNS@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart44245994.a3hZcV9mGD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 1/4] batman-adv: Always flood IGMP/MLD
	reports
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart44245994.a3hZcV9mGD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday 07 April 2016 15:03:11 Simon Wunderlich wrote:
> >=20
> > Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> > diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.=
c
> > index 8caa2c7..19cc404 100644
> > --- a/net/batman-adv/multicast.c
> > +++ b/net/batman-adv/multicast.c
> > @@ -320,6 +391,31 @@ static int batadv_mcast_forw_mode_check_ipv4(s=
truct
> > batadv_priv *bat_priv, return 0;
> >  }
> >=20
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +/**
> > + * batadv_mcast_is_report_ipv6 -=E2=80=AFcheck for MLD reports
>=20
> put a space after the dash?

Just to clarify: There is some kind of symbol but it is not a simple sp=
ace.
Right now it is 0xe280af [1]. This is a little bit too fancy for a simp=
le
space (0x20).

Kind regards,
=09Sven

[1] https://vazor.com/unicode/c202F.html

--nextPart44245994.a3hZcV9mGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXBl+UAAoJEF2HCgfBJntG+ncP/jUh+Z0aitbMskl56hE4g90/
yFIBHlXss74zePqAW1tHXIIioyJFI7afSCIBX4A+W+SFsHzEj64JrCmwh00uBoxg
5aah+uyyUdM9ajurAm49qDSzz6EddpwHPlJ3MHZ2JMG7yN/IIMsAWrHvG4UhZgP0
aJeWSEzZHlO4v778V8jdOJKH8PQ5mTcFzCMSnclbttYtccH1JW/UnRaKbwIPCksF
mWY5FZM1m6esv2jcb+9waKnFd8XEcEl1/82wEB6+9ZXrotK+ihvv1oJdeBEld/Km
KD7RzXOfguzrUucZ66scI7kP1K6QJZhJAFioOrvuO1irYzEgc/arljseap2qDVud
bT6d8xjmZEW8u7REET7jpFw8XOC/i/hcoCTN9MXSTFJmpciaSKYXd9ojiUNGZQz3
ikA9m/bluVRoTRAYbnyn31qxlGbxIQBIbRev7REmrTwwKs/z08XOoAfMew8b6yDQ
tO/gdZ26T25foHAda/50VvKSegyvLW0ATbc79GpMRBB3PI0L95DVDJKv05mM+MB5
PCLv0bfSMozUTQ7PfxiqIRkIrgbWORWjzfadoqziN1KxOWBhnXkcfyzvSzqgXBBL
GFNC1UV5vns1nOD23UAgH7P+RpuzKV/idBfdgkSrMhLislvSq8EonaCSJEvrpHQx
ObYy1Kb6F3CSct29skYV
=jZt2
-----END PGP SIGNATURE-----

--nextPart44245994.a3hZcV9mGD--

