Return-Path: <linus.luessing@web.de>
Date: Sat, 12 Dec 2009 00:20:12 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091211232012.GA17232@Linus-Debian>
References: <20091130211445.GN4150@lunn.ch>
	<20091211225835.GA17140@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20091211225835.GA17140@Linus-Debian>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] /proc vis rework
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ah, sorry, and skip the functions.c-part please, I had submitted a
seperate patch for that here already.

Cheers, Linus

On Fri, Dec 11, 2009 at 11:58:35PM +0100, Linus L=C3=BCssing wrote:
> Hi Andrew,
>=20
> your patch seems to work pretty well here, tested it with 9
> batman-nodes in the same room. Nevertheless I found a couple of
> smaller bugs in there:
> - batctl segfaults, if "batctl vis" has no following argument
> - batctl now displays the help-page in certain situations where we
>   don't want it to
> - batctl ommits the first TQ tupel
> The attached patch for your patch should fix these issues :).
>=20
> And I wanted to ask, what do you think about unifying the specific
> help output? For instance having this "Usage: ..."-header and the
> alignment for the following items the same way as it is done for
> other batctl commands as well.
>=20
> Cheers, Linus
>=20
> PS:
> Hmm, I'm also missing a couple of link/TQ entries already in the
> unified /proc/../vis. The 9 nodes in the same room should be able
> to see each other - the originator table on those nodes is also
> saying so. But I think I had seen this before without your patch,
> the problems has to be somewhere else. I'm attaching a batctl-vis-
> and proc-vis-output of the setup here too, just in case someone
> might spot some (more) parsing mistakes.

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLItOsAAoJEBKw7u43QNpfylkP/iBjzIIsEs0SGck33cl0ZUTq
5qtdwFsExtTCS8OwsWrhW8LZ+j/NkRLIaPkmshBltKXCPmciAIReFml1qTgrQ5e6
84DAS1NnlQjisDjk491ym3cLHHqbAIkV8MuECQ00Dq+7JOa1MU7LTBX4JLAnScDM
yVk4dOcrxYD9vBMqs7bsYUjOr+cY7gzgRMQEiGHlGAWfywewMr0UpAZdIregYN+k
FYvYgcjBPcCOuLZXFzxxlt1+oYiRSYxOt1BinwrBC5HlQE/R7kXFmnJewA3DxF2F
NbEbOBvIFu32yna7P/eITeDb5zi+oiNk5zxqdpWg4a2QT5tZWXqmrhRa6cWbShfh
T5ffqKPixHSTXoqRe0M2IYkCFgc0mEIWVgBjX2DCHleaAwy2OakDSsr55+9auO2x
JgfspguXOlRd83/HWXlp+C9u+qkwRpvJiZIgJ0pcvkwL+C0mj7ny1lY/8YTxLsZR
s+rwgfALE6KM9hBtlRFATk/s7jl1EXXdEZEtjtjHrQGYQX+1N8yDBdQTEWdPMWVK
HIC3vz6BCTaxdLL7QNZho4fZkjc4nr3exBBnBrT3oEVvxv9u9GWAbjAR9giM3bHT
Uiku19Z43FeBo+BNHMe5nNsPmnXh4lEojvh+JJHCWiwUCRChTUuvOPCjr+JKNr36
2kA8U4GvbTpYdjcKW+0O
=yt+s
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
