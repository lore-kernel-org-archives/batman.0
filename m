Return-Path: <mschiffer@universe-factory.net>
Message-ID: <4FA823EB.7070309@universe-factory.net>
Date: Mon, 07 May 2012 21:35:07 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6B67D3C3D514960CD07BEBA9"
Subject: [B.A.T.M.A.N.] The current state of the batman-adv vis code
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B67D3C3D514960CD07BEBA9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,
after reading Marek's and Sven's comments to my question about the vis
code, and looking at the code a bit I came to the following conclusion
about the first part of the cleanup, the finishing of the RCU conversion
of the vis code:

It should be possible to get rid of the vis_hash_lock altogether, as the
hash table has spinlocks for the hash lists itself; overall hash
consistency might be a issue though - I would propose adding a
hash_update function that updates a hash entry without deleting and
re-adding the hlist node.

I think I found a bug in the hash_add function though. First there is a
RCU-locked loop that checks if a entry does already exist, but the
spinlock is taken after the rcu_read_unlock() - thus allowing the same
entry to be appended twice if two threads try to add it at the same time.=


If you want to contact me about this via IRC, I'm now idling in #batman
- my nickname there is neoraider.

Thanks,
Matthias


--------------enig6B67D3C3D514960CD07BEBA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+oI+sACgkQq3qIxbiQM9j5TQCgtM3aBh8tAGdYxTavzYxKrp1J
3fYAoJiNpGo3WmwdTBq8sOKGJQ4UPzVJ
=2LXz
-----END PGP SIGNATURE-----

--------------enig6B67D3C3D514960CD07BEBA9--
