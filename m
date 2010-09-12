Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 12 Sep 2010 22:11:06 +0200
References: <20100910184706.151a6728@rechenknecht>
	<201009111126.38504.sven.eckelmann@gmx.de>
	<201009120156.20364.lindner_marek@yahoo.de>
In-Reply-To: <201009120156.20364.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1477918.QQipjLk2yt";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009122211.07839.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: layer2 unicast packet
	fragmentation enhancements
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1477918.QQipjLk2yt
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Saturday 11 September 2010 11:26:37 Sven Eckelmann wrote:
> > Is it possible to split the patch in those parts? It would make it easi=
er
> > to read it and understand the patches later.
>=20
> I'm not sure that will do much good. He managed to reorganize the code and
> thereby remove redundancies. The second patch would probably be no bigger
> than 3-5 lines of code.

That would not be bad. But refactoring and adding two new features isn't=20
something I personally like. Guessing what part could belong to which other=
=20
part just makes it hard to find the real problems. Take for example the=20
missing failure checks in the patch.

Something I had in mind would be  a patch which adds frag_send_skb and star=
ts=20
to use it, one that removes the duplicated code, another one that does the=
=20
cleanup/renaming stuff, the next adds the fragmentation on routing and fina=
lly=20
there is the defragmentation (probably skipped some steps) - you could much=
=20
more easily check the actual change in its own context. That would for exam=
ple=20
remove the question why those lines were removed - the patch itself would=20
answer that question using its commit message which states: "hey those line=
s=20
aren't needed because we already check that fact here and there and don't n=
eed=20
that information before".

And if a patch real adds a cool feature only by changing some lines and=20
without rewriting the whole code then we must have done something right.

If you think different - ok, leave it that way.

> > > -	/* packet for me */
> > > -	if (is_my_mac(unicast_packet->dest)) {
> > > -		interface_rx(recv_if->soft_iface, skb, hdr_size);
> > > -		return NET_RX_SUCCESS;
> > > -	}
> > > -
> >=20
> > There are different parts of the patch which makes ma a little bit
> > curious - for example: why it is possible to drop that check entirely?
> > Could that be an extra patch with an explanation why that can be
> > dropped? Is it only valid in context of the new fragmentation handling?
> > ...
>=20
> I ran into the same question as it looks a bit odd here but if you apply
> the patch it all looks good. As I said: it seems he managed to purge quite
> a bit of redundancy (fragmented and non-fragmented packets are almost
> identical after all).
=20
Andreas Langer wrote:
> what are the other parts which makes you curious ?

That a failure in frag_reassemble_skb is a good successfully rx, that=20
frag_create_buffer is magically always successful even when the called=20
functions can fail, that you use skb_pull and directly afterward access the=
=20
data pointer, that no one frees the skb when frag_reassemble_skb cannot fin=
d a=20
matching originator, ...

Best regards,
	Sven

--nextPart1477918.QQipjLk2yt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMjTPbAAoJEF2HCgfBJntG1mEQAI6fv5rWtRVfQS5REHA7gqaL
u/8pYmO6iqE1MK0d6bSyKsBeLVgZ7kIVv9uwO1x4Fr751QF55VqICTvLP+6Ov4zU
ylLSW/vsscX5ShmdcqUVMWGRTrLv2vu/aJcQNpUWGWouaG/ihzfi99UBM56K4kT8
/eLIqjz7nI1eIYp/HziRLLLRC/38SJ3fnWOjyh4rFTL57BXbOvs8fYEgrF13kpN4
gLSkCm72g8/vcbm9+KootdcjGN1TPpDyzUFn7PUnBjyD7sqFEXqi/tB2qBlGZDPa
jhvGW9KigzOlqgvQlpsnAeuHg+tCuEttrfIOqGu8KGpJ+GDgUBBgbdRjMUjxmQHQ
NXPMxTw4rYzOqhjgSsfPt/5ltoS0iSajP4EcIs7v34o84T+HlzIv5+WlO3xVHLXT
rAjMbItqw7BD+cjqCmljCUzzdSENq0m76Pjz4CBlW2LqpXWSTf/KWveuPmOebw4w
pD4/w4vdpDsa9PdxEF2VCWi3uchdprGxtFFuaXhYIz2saq9gGIJk3Cw5Kk8AEp7B
8yDgx7SzdSXB4vB5xKosXUR+y/XHIgLjGUy2utc8itpak6PzRdweR4CuSxS3L+Kk
deoZqlk0QNAT8DHo4ETeR+oxlPnUpGtsgjBqg993nDeEK/vM9uULIoC752xxVjD/
J8Es1QFJosnxYWPNXCst
=JWQZ
-----END PGP SIGNATURE-----

--nextPart1477918.QQipjLk2yt--
