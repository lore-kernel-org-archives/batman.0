Date: Fri, 5 Dec 2008 20:51:31 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv-kernelland: Fix memory
	corruption bug
Message-ID: <20081205195131.GA27271@pandem0nium>
References: <DFF8A357-1AF1-4F11-BE89-46DD131FA7FF@gmail.com>
	<20081204113558.GA14932@pandem0nium>
	<C12B8956-7F83-4FBE-A300-B803928CB64C@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <C12B8956-7F83-4FBE-A300-B803928CB64C@gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Scott,

On Fri, Dec 05, 2008 at 11:40:30PM +1300, Scott Raynel wrote:
> Hi Simon,
>=20
> On 5/12/2008, at 12:35 AM, Simon Wunderlich wrote:
>=20
> >Hey Scott,
> >
> >thank you very much for the fix! Can you confirm if this bug is =20
> >related
> >to https://dev.open-mesh.net/batman/ticket/86 ?
> >This bug has very likely been caused by a memory corruption, but i
> >couldn=C3=82=C2=B4t find where. (i have not experienced any kernel panic=
s by =20
> >this
> >however ...).
>=20
>=20
> It is quite possible that they are related. The slab error states that =
=20
> a memory allocation was overwritten - the same problem as my patch =20
> fixed. However, I can't confirm whether it is the same memory =20
> allocation or a different one. The stack trace I got specifically =20
> mentioned the kfree() in send_own_packet(), whereas this stack trace =20
> does not.
>=20
> Is that bug easily reproducible? It will be a couple of days before I =20
> can try to look at it.

Yep, it was quite easy: just turn it on and off a few times. (echo
device and nothing into /proc/net/batman-adv/interfaces). The warning
appeared after 10 times in my qemu instance. No crash, only this warning.
>=20
> Also, the stack trace is confusing as it appears to indicate a kfree() =
=20
> within hardif_min_mtu(), which I can't find :)

That's the problem, that is what confused me at this point. :/

>=20
> I'll try to do some stress testing of the module with the slab =20
> debugger turned on for a while and see what happens.

Sounds great. Thanks for you hard work. :)

best regards,
	Simon

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJOYZDrzg/fFk7axYRAlX7AKCsLdwCSKOiYwdG3rsvT3U++RF8IgCg1ciN
tMsv2UAu4I/fm6LuGZjLe54=
=yig1
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
