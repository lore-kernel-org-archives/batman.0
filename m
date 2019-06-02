Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH maint v2] batman-adv: Fix duplicated OGMs on NETDEV_UP
Date: Sun, 02 Jun 2019 18:16:36 +0800
Message-ID: <5199258.49RjUs2h3V@rousseau>
In-Reply-To: <20190602095135.15604-1-sven@narfation.org>
References: <20190602095135.15604-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2142912.qmWHnJAY8H";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <a@unstable.cc>

--nextPart2142912.qmWHnJAY8H
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 2 June 2019 17:51:35 HKT Sven Eckelmann wrote:
> The state of slave interfaces are handled differently depending on whether
> the interface is up or not. All active interfaces (IFF_UP) will transmit
> OGMs. But for B.A.T.M.A.N. IV, also non-active interfaces are scheduling
> (low TTL) OGMs on active interfaces. The code which setups and schedules
> the OGMs must therefore already be called when the interfaces gets added =
as
> slave interface and the transmit function must then check whether it has =
to
> send out the OGM or not on the specific slave interface.
>=20
> But the commit 0d8468553c3c ("batman-adv: remove ogm_emit and ogm_schedule
> API calls") moved the setup code from the enable function to the activate
> function. The latter is called either when the added slave was already up
> when batadv_hardif_enable_interface processed the new interface or when a
> NETDEV_UP event was received for this slave interfac. As result, each
> NETDEV_UP would schedule a new OGM worker for the interface and thus OGMs
> would be send a lot more than expected.
>=20
> Fixes: 0d8468553c3c ("batman-adv: remove ogm_emit and ogm_schedule API
> calls") Reported-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>


Acked-by: Marek Lindner <mareklindner@neomailbox.ch>

Cheers,
Marek


--nextPart2142912.qmWHnJAY8H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlzzogQACgkQU1VOj+62
HMBKIQf+N0wNHeUdxY7QOPkxXs/ff4Xm73Y499u4tAvkGd+LTxGYoxnLK6eTYT0V
EidnsepSIm5di+el5Dbj/U9827DdyFOX1668jyp6zGz/ClANIdxdJLSt/C7nnopG
t9xGJ47stOkrIbcPIN01V/8r3SmrRp+iGzJdrxMd/et/z+c89cmB3aackj03nLmM
re73ziDShwdqL2wvUHzJ5zYlyM2ZbqeWk0xgdx1USb3EuFqX6m5iv76rG8HXCJUY
dEgqBtwdY29Xl8sBHHvUBr1r/eOiJZR7yQW6N5Jw0uREarJmPS9P0p27ptz+ZCts
Lbkn+QG20TBnWnOMLEj1oCYc8JHhVg==
=tOh1
-----END PGP SIGNATURE-----

--nextPart2142912.qmWHnJAY8H--



