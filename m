Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 26 May 2013 17:14:43 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130526151443.GA27074@pandem0nium>
References: <1369307262-21901-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <20130525210748.GA11731@Linus-Debian>
 <20130525214219.GK1679@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20130525214219.GK1679@ritirata.org>
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


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus & Antonio,

On Sat, May 25, 2013 at 11:42:19PM +0200, Antonio Quartulli wrote:
> On Sat, May 25, 2013 at 11:07:48PM +0200, Linus L=C3=BCssing wrote:
> > Hi Simon,
> >=20
> > I'm currently wondering whether changing the protocol in the way
> > you described is sufficient.
> >=20
> > I think it still has the problem of not converging to the optimal
> > solution in various scenarios, for instance:
> >=20
> > ----------
> >=20
> >     B1 ---------
> >   /             \       =20
> > A        C1 ---- D
> >   \    /        /
> >     B2 - C2 ----
> >=20
> > A-B1:   10%, 0ms
> > A-B2:  100%, 0ms
> > B2-C1:   5%, 0ms
> > B2-C2: 100%, 5ms
> > B1-D:  100%, 0ms
> > C1-D:  100%, 0ms
> > C2-D:  100%, 0ms
> > ('link': 'link-quality', 'link-delay')
> >=20
> > Obviously, here the path A-B2-C2 is the best, having a 100% link
> > quality. However with this patch, it will select A-B1-D, having
> > only a 10% link quality (I'm not considering asym/hop-penalty or
> > that 0ms delay is unrealistic, and I'm not considering that the
> > link quality will cause lost OGMs - just to keep things simple):
> >=20
> >=20
> > The OGM from D gets forwarded to B1 and then to A instantly; A
> > notes a path quality of 10% towards D via B1.
> >=20
> > The OGM from D reaches B2 via C1 first, so B2 first forwards an
> > OGM with a path quality of 5% to A first. A notes a path quality
> > of 5% towards D via B2.
> >=20
> > Then the OGM from D reaches B2 via C2, too. Now, with this patch
> > B2 will correctly choose the path via C2, B2 notes a 100% path
> > quality towards D via C2 instead of ignoring this OGM.
>=20
> This was true also before this patch.
>=20

I agree - actually A would have not gotten any (valid) packets from B2
because B2 would got the packets first from C1, discard them (not best
nexthop), and then from C2 (best nexthop) but don't forward it because
it was a duplicate. Antonio pointed out the same thing below ...

Then A would always have to choose B1 because it gets no valid OGMs via
B2. The patch actually solves this situation, even not in optimal time
as Antonio pointed out ...


> > And B2 will
> > also rebroadcast this OGM.
> >=20
> > However, A will ignore this second OGM from D via B2 because it
> > came from the same neighbor even though it came from the best,
> > optimal, 100% link-quality path.
> >=20
> > ----------
> >=20
> > While converging to a path after applying this patch is obviously
> > better than the starvation which can currently happen I'm
> > still wondering whether the issue could be solved better.
> >=20
> > What if we were always rebroadcasting/forwarding an OGM even from
> > the same neighbor, too, if the sequence number is the same but the
> > TQ better (so similar to what is specified for BATMAN V)?
>=20
> If I am not wrong this is what is going to happen, but with one originator
> interval of delay.
>=20
> If I correctly got your example, this happens the first time only, but fr=
om the
> next originator interval B2 will only rebroadcast the OGM coming from C2 =
since
> this is the best next hop for it. So yes, this can happen but only the fi=
rst
> time. As soon as B2 learns the best route via C2.

Agreed here too - B2 should select C2 "soon" as the best nexthop and then o=
nly
forward Ds OGMs via C2, but not via C1. Then A will get the good OGMs via C=
2-B2
and - voila - will select it as best route.

The situation you describe happens for the first "few" OGMs (not sure if it=
's only
the first), when only OGMs from C1 have been received at B2 but not from C2.

Regarding your suggestion to forward multiple packets with the same seqno, =
but
better TQ: We currently would ignore them in A for beeing a duplicate. If w=
e were
to change that, we would have to change the TQ ring buffer as well. However=
 this ring
buffer currently has no specific order, so it's not so easy to update a spe=
cific value
in this ring buffer because we don't know which TQ value belongs to which s=
eqno.
If packets arrive out of order, they will be saved in the ring buffer in the
order they come in, regardless of the seqno. Have a look at batadv_iv_ogm_o=
rig_update(),
maybe you can find a decent solution for that. :)

Apart from this technical issue, I don't think it's that critical to save a=
 single OGM
cycle by sending (many) more OGMs, that's pretty much an overhead vs speed =
discussion.

>=20
> What this patch is changing is to make B2 rebroadcast the OGM coming from=
 C2
> (best next hop) in case the latter arrived after the OGM coming from C1 (=
which
> is not rebroadcasted because C1 is not best next hop). Actually the fix i=
s only
> acting on the duplicate detection only (which affect forwarding).
>=20
> So, without this patch, in this case I described, we were having a real "=
block".
> There is no change in the route selection. The routes are still selected =
the
> same way as before.

Yup, see above.

Thanks for you comments and thoughts,
	Simon

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlGiJuMACgkQrzg/fFk7axaPPACg7DmNfigY9wE1F2VlkrjWBcGm
g6YAni/V/daWGpV06hvOzbZfZ5MAO0hG
=GM18
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
