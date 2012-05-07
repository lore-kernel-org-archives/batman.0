Return-Path: <mschiffer@universe-factory.net>
Message-ID: <4FA75113.40401@universe-factory.net>
Date: Mon, 07 May 2012 06:35:31 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <4FA54C09.6000303@universe-factory.net>
	<7f84c7e913b9a0c9a22cc19864c6b7d9e2a347de.1336233103.git.mschiffer@universe-factory.net>
	<20120506201435.GA27416@pandem0nium>
In-Reply-To: <20120506201435.GA27416@pandem0nium>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7911EAECCD5E114493DA2B75"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
 without neighbors on the primary interface
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
--------------enig7911EAECCD5E114493DA2B75
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/06/2012 10:14 PM, Simon Wunderlich wrote:
> Your patch does the trick, although I think this ugly function could us=
e a rewrite.
> First counting bytes and then allocating this size to do exactly the sa=
me thing again
> is not really good style. If you would like to volunteer to do this job=
 (or plan to
> work more on vis), please tell me, otherwise I'll put it in on my TODO =
list.

While I'am already at it, I guess I can also volunteer to do some more vi=
s work :)

Besides cleanup, are there more ideas about the vis? A nice feature I can=
 think about would be adding some freely chosen identification string (fo=
r example the hostname) to the vis data, this could make big graphs much =
more readable. I wonder though if this would be possible without breaking=
 compatiblity.

I have some questions about the code though:

- Is there any reason vis_seq_print_text() allocates a buffer at all inst=
ead of just printing the data directy into the seq_file? Looking at the s=
eq_printf implementation, there doesn't seem to be a problem calling it w=
hile holding the lock.
- In many places in the vis code hlist_for_each_entry_rcu() is used to it=
erate over the hash lists, even though all access to vis_hash is guarded =
by the vis_hash_lock, so it seems to be okay to just use hlist_for_each_e=
ntry(). In some functions, vis_seq_print_text() being one of them, rcu_re=
ad_lock/unlock pairs could be removed as well with this change. Do I over=
look something?

I'll also drop by the batman IRC channel.

Matthias


--------------enig7911EAECCD5E114493DA2B75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+nURMACgkQq3qIxbiQM9itKgCcCyQtVwDOCBCqEXwqB440ojbE
4R4AnRdKIa73vBwE6UnmLX5LiAIj0YhC
=DvHW
-----END PGP SIGNATURE-----

--------------enig7911EAECCD5E114493DA2B75--
