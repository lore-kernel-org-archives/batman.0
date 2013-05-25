Return-Path: <ordex@autistici.org>
Date: Sat, 25 May 2013 23:42:19 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130525214219.GK1679@ritirata.org>
References: <1369307262-21901-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <20130525210748.GA11731@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="00hq2S6J2Jlg6EbK"
Content-Disposition: inline
In-Reply-To: <20130525210748.GA11731@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: forward late OGMs from
 best next hop
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--00hq2S6J2Jlg6EbK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2013 at 11:07:48PM +0200, Linus L=C3=BCssing wrote:
> Hi Simon,
>=20
> I'm currently wondering whether changing the protocol in the way
> you described is sufficient.
>=20
> I think it still has the problem of not converging to the optimal
> solution in various scenarios, for instance:
>=20
> ----------
>=20
>     B1 ---------
>   /             \       =20
> A        C1 ---- D
>   \    /        /
>     B2 - C2 ----
>=20
> A-B1:   10%, 0ms
> A-B2:  100%, 0ms
> B2-C1:   5%, 0ms
> B2-C2: 100%, 5ms
> B1-D:  100%, 0ms
> C1-D:  100%, 0ms
> C2-D:  100%, 0ms
> ('link': 'link-quality', 'link-delay')
>=20
> Obviously, here the path A-B2-C2 is the best, having a 100% link
> quality. However with this patch, it will select A-B1-D, having
> only a 10% link quality (I'm not considering asym/hop-penalty or
> that 0ms delay is unrealistic, and I'm not considering that the
> link quality will cause lost OGMs - just to keep things simple):
>=20
>=20
> The OGM from D gets forwarded to B1 and then to A instantly; A
> notes a path quality of 10% towards D via B1.
>=20
> The OGM from D reaches B2 via C1 first, so B2 first forwards an
> OGM with a path quality of 5% to A first. A notes a path quality
> of 5% towards D via B2.
>=20
> Then the OGM from D reaches B2 via C2, too. Now, with this patch
> B2 will correctly choose the path via C2, B2 notes a 100% path
> quality towards D via C2 instead of ignoring this OGM.

This was true also before this patch.

> And B2 will
> also rebroadcast this OGM.
>=20
> However, A will ignore this second OGM from D via B2 because it
> came from the same neighbor even though it came from the best,
> optimal, 100% link-quality path.
>=20
> ----------
>=20
> While converging to a path after applying this patch is obviously
> better than the starvation which can currently happen I'm
> still wondering whether the issue could be solved better.
>=20
> What if we were always rebroadcasting/forwarding an OGM even from
> the same neighbor, too, if the sequence number is the same but the
> TQ better (so similar to what is specified for BATMAN V)?

If I am not wrong this is what is going to happen, but with one originator
interval of delay.

If I correctly got your example, this happens the first time only, but from=
 the
next originator interval B2 will only rebroadcast the OGM coming from C2 si=
nce
this is the best next hop for it. So yes, this can happen but only the first
time. As soon as B2 learns the best route via C2.

What this patch is changing is to make B2 rebroadcast the OGM coming from C2
(best next hop) in case the latter arrived after the OGM coming from C1 (wh=
ich
is not rebroadcasted because C1 is not best next hop). Actually the fix is =
only
acting on the duplicate detection only (which affect forwarding).

So, without this patch, in this case I described, we were having a real "bl=
ock".
There is no change in the route selection. The routes are still selected the
same way as before.


Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--00hq2S6J2Jlg6EbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRoTA7AAoJEADl0hg6qKeOq2gP/1e1vekrDqq86E60cYMFCI8L
BAPvy7YNMtaKDBsAX0vwNjUR1CyrZPOFFmrTHVCIuucxK/PbKHXPS/y7IqjYHQBA
9Y+bTEfnYBKafKz3G2jSiMFNUq4dDI+a2FVikVRH62gKZj3+/bYX4jFucMQgw3Gi
dhXDNsALwGD5VIjHfJDZiBnO4aC2XBsM6AnpU/Ot3s4RNjR6HU7HaNkDkaVwRIkN
2toBKEgaVDukDlWrvNt6x51sXlSFmNsx8W6NhJwUgUg9HgVUeQWFYpb8UOCiF5wt
zWr3+Du89VrSMp2X3VxuurGRmLYkrLSXhs8X8iNux+Q0fUyiGDV9sLXbD2+T+SnS
S3mGRrS+gs0U+vymOjhdVcRgG+uK8A6ARr4B2TYFvcZ/yrST1wr7NmEp5YUtRfrn
0d+EZBAD40kFDsghyPPB/hCaPvJdWA6qHb9kZBseZ9tiJMAc/vuZGx91EVSTJDW4
wFt+51Ku6VlJfztQ54hylW2yk8Ut2WDAIwwhkYSkh4yjWif/E8Ck4sjms5e909P0
CefWS1Ei7OH0zQY2bF67KzJWfvxBf479b+VAkdxwDDIaFm9+PAGLtxJML/WeynJS
g8v5sz/SHxQfH5tKUhUUyUn+zr8/iau/g1q9iR1F+IDR1rWR9S9kEh0YZs1uwfM+
Fr3adK+MMQPdcaHxp7Yn
=/lnh
-----END PGP SIGNATURE-----

--00hq2S6J2Jlg6EbK--
