Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 4 Jun 2010 22:56:50 +0200
References: <20100525225411.GA23108@pandem0nium>
	<201005261239.35972.sven.eckelmann@gmx.de>
	<20100604163704.GA5425@pandem0nium>
In-Reply-To: <20100604163704.GA5425@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1312812.77BGJXpbDN";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006042256.51777.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Staging: batman-adv: bonding and
	interface alternating
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

--nextPart1312812.77BGJXpbDN
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Simon Wunderlich wrote:
> I've also followed your other comments (hopefully correctly), so thank
> you very much for the review.
[...]
> > > This is an experimental patch and targeted for upcoming experiments at
> > > Wireless Battle Mesh v3 in Bracciano/Italy.
> > >=20
> > > Feedback, comments and reviews appreciated!
> >=20
> > That part is quite interesting for the mailinglist but should not be pa=
rt
> > of the commit message, or am I wrong? In that situation such information
> > should be appended after the "---". git-am or similar tools should
> > automatically ignore that parts, but the receiver can still read that
> > comment.

That "---" part was actually meant for the mail and not for the svn commit=
=20
messages. It will not be stripped from commit messages by git-svn - so it=20
remains in the git master branch. I have removed it manually from my rebase=
=20
branch - please tell me if that wasn't what you wanted and I will re-add it.

I noticed the "The patch also includes a bug fix...". What exactly do you m=
ean=20
here? I would guess that it is only this part:

> +			/* we only care if the other candidate is even
> +			 * considered as candidate. */
> +			if (tmp_neigh_node2->next_bond_candidate =3D=3D NULL)
> +				continue;
> +
> +

But nice to see that the testing resulted in an even more compact patch whi=
ch=20
is better readable. :)

Best regards,
	Sven

--nextPart1312812.77BGJXpbDN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMCWiSAAoJEF2HCgfBJntGvl8QANR7pkxBePH1tZSyw5AXktQR
/ksgN0jOf1Ro4Wx9Ios0vdP6DTMDJwnCjaVQfMb6l/XZShUE1nOyK9ZU/wzDr9J1
y6gVAqMWAtE4BuSAq0ySBX1mWWiVkxGFMmNh4Vm7N8JdK8Vhm+eifUPj/zX2zgZj
T7cu68lVNebJHcfGPKHWvBD5rUydZzsFgcUwjP4HTK8zDDDW+zkkP9mRaBlgAJhi
ed9miOO9sjhhdmH1rcRRrXpV6jgMhN9gFy1FEtbyCoW3pL2HsXsDJApFXt+no0eS
Bw5p/j1NLPYbODxQI8OiUXDZ4B68PWUXbt0c2rLT4KwP3APxrvTc5+HhspZNHZM3
5KBqTRsLedP/FhuBPOLTmDQkwAESg+lyC3xrl6F97ZK5taYze0oiEVSoJchxbIXK
vLlK1FZDuHm8dEDvcNjUzoHnJqfCwWDLqPXfWBrtWTgnVrscEpauTN2JHsqwgkLJ
jwLqNtH+Ecg7MRe1p/jDRxybFJ6/sSaa99Hu8k0m3rj7X9CEHdF8dcQGyxgYQvn5
GvyBXi7lMz7znE7wMtq+aGhd5I/aI5gt9ngvVsHrzvx6OUHW77T6XqrtkawtXqDf
9BGkRqBuND2y+8PKbYEKQYuTJxTYXXidoI5kzYQsFm+1PRqFJJRsdvDvRUj5nU2v
4SBae0KxbD+RvvABPlKK
=fUDp
-----END PGP SIGNATURE-----

--nextPart1312812.77BGJXpbDN--
