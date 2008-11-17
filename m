Date: Mon, 17 Nov 2008 23:00:52 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Batman security
Message-ID: <20081117220052.GB6516@pandem0nium>
References: <35301.149.5.32.200.1226956767.squirrel@www.rivertowermail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <35301.149.5.32.200.1226956767.squirrel@www.rivertowermail.com>
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


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Derek,

no, there isn't something like this in BATMAN. You might want to have a
look at WPA-NONE though, which can encrypt both data and routing
traffic on the 802.11 layer for Ad-Hoc networks with TKIP or AES/CCMP
(beware, it's pretty undocumented ...).

For both, the OLSR security routing plugin (as far as i understood it)=20
and WPA NONE, you have the problem of a shared, symmetric key. If each=20
node has the key and you have a pretty decentralized setup, you might=20
see your key on a website or ebay before you can even think about it. ;)

So the first question should be what you secure against whom, which
possible attackers are to be considered etc. We can discuss this further
if you want. Not implementing a security feature in BATMAN was not only=20
a design decision for minimalism, but we also could not find a scenario
where this "protection" would be useful or would handle the situation
better than conventional mechanisms.

best regards,
	Simon

On Mon, Nov 17, 2008 at 09:19:27PM -0000, Derek C wrote:
> Hi all,
>=20
> Is there any way to secure the traffic on the adhoc NIC with BATMAN - like
> the secure plugin in OLSRd?
>=20
> thanks,
>=20
> Derek
>=20
>=20
> --=20
> Derek C
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJIemUrzg/fFk7axYRAqfmAKCqcBY6Z15UUc1/eO9XaNyZNp79tgCgksGX
PhoCc4bZKEny9dVtjvSq+oY=
=t/w6
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
