Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 12 Jun 2013 14:44:38 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130612124437.GA14493@pandem0nium>
References: <1370848318-18755-1-git-send-email-linus.luessing@web.de>
 <20130612101411.GA13323@pandem0nium>
 <20130612122714.GA27583@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20130612122714.GA27583@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2013 at 02:27:14PM +0200, Linus L=C3=BCssing wrote:
> On Wed, Jun 12, 2013 at 12:14:11PM +0200, Simon Wunderlich wrote:
> > Hello Linus,
> >=20
> > I gave it a try - but there seems something off. What I did is:
> >  * apply your patches on 3b38a80 - multicast was enabled by default
> >  * start 2 VMs directly connected
> >  * ping6 -I bat0 ff02::1
> >=20
> > I only got a reply locally, but not from the peer. When I disabled
> > multicast, I got two replies from the local host and the peer.
> >=20
> > As far as I have tracked the problem down, it appears that
> > batadv_mcast_forw_mode() returns 1 correctly, but the packet is dropped
>=20
> Ok, found a bug - the return 1 is actually incorrect. You've
> chosen the one multicast address where no optimization is
> conceptually possible. ff02::1 is the only link-local IPv6
> multicast address which should return a BATADV_FORW_ALL (0)
> instead.

Ah, wonderful, and I thought I found a testcase. :D

Can you advise how the feature can be tested then, practically?
I guess I'll need to add some routes and ping6 another address?

>=20
> (Conceptually impossible because for ff02::1 is the one multicast
> address which by the IPv6 standard every host listens to, without
> performing any MLD.)
>=20
> I'll add another check next to the scope check in
> mcast_forw_mode().
>=20
> > later in the process - I would guess that this happens in
> > batadv_send_generic_unicast_skb() where we try to select the gateway
> > when the destination mac is multicast instead of looking it up in the
> > tt table. But I leave the details to you. :)
>=20
> Hm, but still, you're right, with this single destination, the
> other VM, the ICMPv6 request and reply should have arrived because
> the according MAC (33:33:00:00:00:01) is in the global translation table.

Yeah, it was, that is what puzzled me.
>=20
> I didn't have that issue in my tests so far, I'll try to reproduce
> that issue.

OK.

Thanks,
	Simon

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlG4bTUACgkQrzg/fFk7axZ0qwCgizZtViIC5F0Nwon/R3P3N33H
AcwAoPIWbHTmaz2z5ui13gxk4SP808Py
=rvRh
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
