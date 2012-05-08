Return-Path: <mschiffer@universe-factory.net>
Message-ID: <4FA92B3A.40000@universe-factory.net>
Date: Tue, 08 May 2012 16:18:34 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <4FA823EB.7070309@universe-factory.net>
	<201205081359.26707.lindner_marek@yahoo.de>
In-Reply-To: <201205081359.26707.lindner_marek@yahoo.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig493459E9CEF67855F25980E5"
Subject: Re: [B.A.T.M.A.N.] The current state of the batman-adv vis code
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig493459E9CEF67855F25980E5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/08/2012 07:59 AM, Marek Lindner wrote:
> On Tuesday, May 08, 2012 03:35:07 Matthias Schiffer wrote:

>> overall hash consistency might be a issue though - I would propose add=
ing a
>> hash_update function that updates a hash entry without deleting and
>> re-adding the hlist node.
>=20
> Can you give an example of such an "update" ? Where would we need it ?

It would be useful to keep the output consistent even when the hash is
updated while the output is generated - as a delete-add sequence adds
the new element at the head of the hlist, a RCU-locked reader will not
see the element when the traversal position is between the head and the
old position of the element. An hash_update could use
hlist_replace_rcu() to replace an element in a way that each reader
either sees the old or the new version, but none loses it completely.

A hash_update_if version that gets an additional callback that is
provided with the old and the new element and gets to decide which
element to keep in the hash could be used to compare the sequence
numbers in the vis code and update the hash atomically.

Matthias


--------------enig493459E9CEF67855F25980E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+pKzoACgkQq3qIxbiQM9h1fQCgit0orG3nDQYKGKWPuDzkylfZ
I7wAnRH9/SgFy2lFjQe7PGfcZuerafmv
=cLTk
-----END PGP SIGNATURE-----

--------------enig493459E9CEF67855F25980E5--
