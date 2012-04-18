Return-Path: <ordex@autistici.org>
Date: Wed, 18 Apr 2012 08:47:00 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120418064659.GC27966@ritirata.org>
References: <1334663907-22725-1-git-send-email-ordex@autistici.org>
	<1334663907-22725-11-git-send-email-ordex@autistici.org>
	<20120417.224746.802445483718191876.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <20120417.224746.802445483718191876.davem@davemloft.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/11] batman-adv: print OGM seq numbers
	as unsigned long
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 10:47:46 -0400, David Miller wrote:
> From: Antonio Quartulli <ordex@autistici.org>
> Date: Tue, 17 Apr 2012 13:58:26 +0200
>=20
> > OGM sequence numbers are declared as uint32_t and so they have to print=
ed
> > using %u instead of %d in order to avoid wrong representations.
> >=20
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
>=20
> Fix this commit message subject, "%u" is "unsigned int" not
> "unsigned long"
>=20
> "unsigned long" would be "%lu"

Yap. The broken part is %u, because the data type we are going to print is
uint32_t. I'll fix it.

Thank you.

I'll send a new pull request once I'll have fixed these errors.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPjmNjAAoJEFMQTLzJFOZFR+IH/i2ZyJ4xsE0sLJ9HxqxtBD9V
yNpNjEvyVZ0TZvKLop4gqEQ4uA0iXBDk9tlfeYwA5Kj3KWdt0bhPod72UeayRJGr
BgnMdcT2kPc1ZjGdEmiMD8bPQgsqvxGhksMkyvE6gAIEhNcyWG2hEFsugX0ozAId
6zgZRFuP36GtWAZ25sN8t4u7fZmYGTwtr0CdJPRC0i4EqxN4lzThX874zCX+gHCy
gVv+k9+gh4OoXdDIyrSNzKgmN3KLUE6+V8XMFPfbdobrMAS9HogYiq1rhWNACL9i
/yWHNbRzj87xzw4rTtZ5EyndOCjm/frcnfZPOwg3Vxl8umCP4gBHhjtQYJ+3hhI=
=cx9C
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
