Date: Wed, 14 Nov 2007 11:06:18 -0600
From: Jan Hetges <tran@ms20.net>
Message-ID: <20071114170618.GA4282@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] parametrization for bmxd on ethernet?
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
To: b.a.t.m.a.n@open-mesh.net


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi
I did'nt find doku on that.=20
As i'm getting a 2nd GW :-)...

setup:
                      ---"DMZ"
                     /
 vsat --- gateway ------ wifi-gw --- "wifi-world" --- 2nd-wifi-gw=20
                            \
			     ---"wifi-world-2"


I'm running bmxd-rv785 on all the wireless stuff, where wifi-gw runs=20
bmxd -g -blabla,  but i liked to move the bmxd-gw to the cabled gw,
so if the sat-link fails, "wifi-world-2" and "DMZ" can still reach
the internet through the 2nd-wifi-gw.
So howto parametrize bmxd for devices without wireless-intrerface?
Can i use --gateway-change-hysteresis together with -p ?
Suggestion: in bmxd -cbd1 i saw nodes with lvld >400 before they=20
get deleted, i think 180 should be more than enough, 3 minutes is plenty
of time for normal reboot, and if a node dosn't send OGMs for more
than that... it has a serious problem ;)

cheers

  --Jan

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHOysKlTtvZdk47D4RAoKaAJwK2Y0+kjtKfFETeFUAiTgJSKgAQwCePhf2
3JA3051GzQj0FfFG6523MQ4=
=gHgv
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
