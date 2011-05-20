Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 20 May 2011 14:29:04 +0200
References: <1304496393-16405-1-git-send-email-sven@narfation.org>
	<1305011821-5411-1-git-send-email-sven@narfation.org>
	<1305011821-5411-2-git-send-email-sven@narfation.org>
In-Reply-To: <1305011821-5411-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2554884.H9Rqku8GOm";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105201429.06896.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/4] batman-adv: convert
	call_rcu(gw_node_free_rcu) to kfree_rcu
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

--nextPart2554884.H9Rqku8GOm
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>=20
> The RCU callback gw_node_free_rcu() just calls kfree(), so we can use
> kfree_rcu() instead of call_rcu().
>=20
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Marek Lindner <lindner_marek@yahoo.de>
> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Acked-by: David S. Miller <davem@davemloft.net>
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Linus applied it in eb340b2f804860a51a0b92e35fd36742b6c2d6b7

Applied in 9f517fb3

--nextPart2554884.H9Rqku8GOm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN1l6SAAoJEF2HCgfBJntGe78QAJ4RlQ+hZubgb8N7V6+zpkF0
DRfFXgQgbbgw9XGWBc5EV7BnsbWjqdBGbcs8Njh+3NFPtQ0cRZILf5dkVho9gcVi
PqcDOaQFx6056YXgOP1TE3BVSmh58LhcV1wyXpFjDVPuAkCetd3IrhnBDfnTzRif
I7Kf8aPCAv7K53iGLlKTGxI/F9PT5nRY2DPsr35adrUyof0ipQnknX9afXhJ1BB/
fQ26/HuQMaibvMFiIig0jsidTxQyNgwy6C5wEeNn31tE+8GSvQc/wQs+m52f8VAz
6wlTLkdeKVhFAlR6PnCbgpiuCeno0TZqPKH9OKX6TPkCeODCoDSucm3HX4Si2yDw
AErCPQzIMnoHHvTDplG/JAQqR0hTs7mT5jAVQdLfRN9ivx7tsMoJ70L6HlogB6Ux
od3PxsaBDB2qNBtkdqT8yXUPXfU+2gpeOokdZzQlAQKuMDEYgDHO/2Ta8aQtnO+w
OxhHtHdvWVfsdtsG4MHkMnzgqH6TQipukfnyMOy6qabvgxwXWHBjQsnLpc3XXeZP
N1fp1IgQHWRjFN2uU3qit6PooHZH9cyi9SRDQDWr8/OUoaa/tf3AMcdgTfP6UrDT
+30IP4+UpsN6ZLLbruIaa0wlX6Zz21dd1CxwVjVUaZr+ic7a/II9gkFOS0UW5o8N
w7gYO3uJktnqh7mOUt1A
=seL/
-----END PGP SIGNATURE-----

--nextPart2554884.H9Rqku8GOm--
