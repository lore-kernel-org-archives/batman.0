Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 19 Jan 2010 18:12:59 +0100
References: <20100118112706.91160@gmx.net>
	<201001191611.30799.sven.eckelmann@gmx.de>
	<20100119153233.319500@gmx.net>
In-Reply-To: <20100119153233.319500@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1340541.QXdipJ7yfG";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001191813.04466.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1340541.QXdipJ7yfG
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Juha Yl=F6nen wrote:
> > As far as I can see only data from 00:22:fa:dc:9a:ce can be seen (send
> > from us
> > aka laptop?). Have you tested if the adhoc connection between this two
> > devices
> > (arm <-> laptop) is really working (just set up the adhoc network as
> > usual and
> > then give them an ip instead of adding to
> > /proc/net/batman-adv/interfaces. A
> > simple ping test should be sufficient to say that it works(tm)).
>=20
> Yes, ad-hoc itself works pretty well. the device boots up to his default
>  ad-hoc, and I've sent the module over with scp and did some configuring
>  over ssh. I did run couple of tests with IP disabled in the interfaces
>  (set up exactly as in the readme) but recently I've just kept them in the
>  default setup with IP's, will it cause problems? The problem existed with
>  non-IP interfaces too.

batman-adv works on a lower level - so it shouldn't be a really problem in=
=20
that situation. Maybe you can "tcpdump -s 0 -w test.dump" on the arm too. I=
 am=20
currently not sure why the arm cannot or doesn't send packets at all. The l=
ogs=20
in 20100118132935.91200@gmx.net say that it was send, but I currently don't=
=20
understand why they don't reach their destination. Maybe a dump from the ar=
m=20
reveals the problem - or at least we know if data gets send at all or if th=
e=20
data is stopped somewhere else.

Best regards,
	Sven

--nextPart1340541.QXdipJ7yfG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLVegbAAoJEF2HCgfBJntGYnQP/jQeOonKJiH2Rp2DvPFkahKB
56hpVD+BnWtHWqmZf3AxWe4XeWRtAlqvAV1ezL8Dj7BsxgcWFy3Ll7pmzpCGC1by
PdFz3jjFAZn/QVyoul1F4DPRbSQIrcLrIcnjqZ67S/+rEZEnxap9FyOI6LoaCUzE
PS5Fgu9n5tmWxyknk8xlKK6gTRboeRQuJMnkVoxbEXPM6DX4TbBLdLGKXOL7RvNs
DTss6VKadTNxs/hMGnas+WrctuPR4uyfNhA8FxM+fr8LYAQkzIX5Noa7YxQs2Mas
OOiINfjE465edDmz/2YQ7zt1+8tzW0+shi2Tf9ye4LL0lm2SaGlPvkWwOMfvRc08
dVEdfHHBSZR5qsv8ErKNlvEDu2rcHlB2S6hKCwedpmZTBG29s7fJv8KAkjvL9t7g
QggU+ipFLeWh2VdKP9Pz8T0V3aymNQ5TtRLKU5Mr748Js0zU4CN2JLlJCKUfAyvv
Q0znl0NvTIvzuiYaYgMbLRf06JCvisAjGNHeOI6mvijWLe6d/IbjtmtJrzqMqvZ4
jLP2DYY48vbdqjSZJQ/uBzF3HGpDKw5OF4y+4iN6mEGg6vgB8z8+VTNozeRZfHbs
mEq1igbxV6HAYMtMUWLWl8NKuhVi00x2Fp1YSyhBsQZgc3T9abt0wEj3srwkvug0
jX/8PEjolJ4lUxF2Dm2w
=nyRB
-----END PGP SIGNATURE-----

--nextPart1340541.QXdipJ7yfG--
