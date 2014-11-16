Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Nov 2014 16:55:02 +0800
Message-ID: <12208952.53ie7oUJTC@diderot>
In-Reply-To: <1414644048-5792-3-git-send-email-linus.luessing@c0d3.blue>
References: <1414644048-5792-1-git-send-email-linus.luessing@c0d3.blue>
 <1414644048-5792-3-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1807237.O2eEj54z3P";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: fix multicast counter
	when purging originators
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart1807237.O2eEj54z3P
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 30 October 2014 05:40:47 Linus L=FCssing wrote:
> When purging an orig_node we should only decrease counter tracking th=
e
> number of nodes without multicast optimizations support if it was
> increased through this orig_node before.
>=20
> A not yet quite initialized orig_node (meaning it did not have its tu=
rn
> in the mcast-tvlv handler so far) which gets purged would not adhere =
to
> this and will lead to a counter imbalance.
>=20
> Fixing this by adding a check whether the orig_node is mcast-initaliz=
ed
> before decreasing the counter in the mcast-orig_node-purging routine.=

>=20
> Introduced by 77ec494490d60d89b42cd01d5dbf8dee04503623
> ("batman-adv: Announce new capability via multicast TVLV")
>=20
> Reported-by: Tobias Hachmer <tobias@hachmer.de>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  multicast.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied in revision 9e9d48e.

Thanks,
Marek

--nextPart1807237.O2eEj54z3P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUaGZmAAoJEFNVTo/uthzAULIH/2KD0QfUC9CvsAhXN0PEW0PC
wildiJlLcqLUzNx2mublKInMmY5uGJF+VtR1zSdf+Ue9IqNApM89ctK7XF3/A9xb
f3h0kFeFUXxAmpJDg4mmIgOULWr9qrk2f0Aql0YMlVOjxGR2XBIBpJZwBAvxgxyu
I+OyL4HM4MRm11wMdRjwtmgK2/NJqlr/K3bJaM4sVsU0XOcYVrKceYsfgMchfYD5
BlOwFX0Aq8CnUfDQCHXjInFFC54Yi7fTloagwyRDV+9zN7egNPZSlTW0AOJzqDse
qccAgKl6IIMuu572v8zKJRbXAIfwG136sExTHz4P33yuzMEU5RGFzZ6mOtQXL48=
=FtOp
-----END PGP SIGNATURE-----

--nextPart1807237.O2eEj54z3P--

