Date: Fri, 11 Apr 2008 09:48:24 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] AHdemo mode
Message-ID: <20080411074824.GA25011@hrz.tu-chemnitz.de>
References: <200804092052.12389.gfjl@ubbi.com>
	<200804100852.51052.lindner_marek@yahoo.de>
	<200804092255.36474.gfjl@ubbi.com>
	<E3C3B297-FD0F-4708-AA7D-AEA1F979EA70@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <E3C3B297-FD0F-4708-AA7D-AEA1F979EA70@gmail.com>
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


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

i agree to Marek, just encryption won't give us security, and i think
it's better to keep the mesh open and "unsafe" than having people a
delusion of "security", which would probably make things worse.

Anyway, i'd like to add that there is more than WEP for Adhoc:

There is WPA-NONE, which can be used with wpa_supplicant. Basicly it
works with static keys, but doesn't support re-keying, replay attack
detection and such as there is of course no AP which would regulate
these features. So this is probably much weaker than "normal" WPA-PSK.=20
(I'd be interested in a proper "security" discussion/documentation=20
about this).

Btw, this does not seem to be a standard thing (couldn't find it in=20
802.11i), and there is no proper documentation as far as i can see. If
anyone finds something usable, please let me know. ;)

You can give it a try, have a look at [1] and search for WPA-NONE in the
document. Be aware that drivers might not (yet?) work with that. I know
=66rom madwifi that it still tries to apply replay rules even in IBSS mode
and thus won't work with more than 2 particapants (that would give a
boring mesh, right?). :D

Best Regards,
	Simon




[1] http://user.uni-frankfurt.de/~testrad/wpa_supplicant/wpa_supplicant.con=
f.examples

On Thu, Apr 10, 2008 at 07:53:58AM +0530, Vinay Menon wrote:
> The problem I see here is the possibility of unwanted batman nodes =20
> joining in and announcing wrong/ false gateway. Since adhoc will only =20
> support WEP and imo its not viable having batman run only over VPN, i =20
> think a symmetric key arrangement where in all nodes have the same =20
> password to join in routing would be a great addition. This basically =20
> is the concept of olsr secure plugin.
>=20
>=20
> Regards,
> Vinay Menon
>=20

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/xfIrzg/fFk7axYRAgpYAJ9AnZ3uDnEQRYzU4yJ1kvhPveuOngCgiFGt
8tTww2F/2bUXGaVLZ0X7OLk=
=wpZq
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
