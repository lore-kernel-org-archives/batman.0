Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 23 Oct 2013 06:16:41 +0800
Message-ID: <10173352.hZCPyyZyi4@diderot>
In-Reply-To: <20131022214710.GB6214@Linus-Debian>
References: <20131020082506.GC13550@Linus-Debian>
 <20131022212604.GA6214@Linus-Debian> <20131022214710.GB6214@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart44604192.IDI2KnnMk1";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] A few questions on TVLV
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart44604192.IDI2KnnMk1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 22 October 2013 23:47:10 Linus L=FCssing wrote:
> Or actually I just go ahead from the things which got mentioned in
> your email and on IRC by Antonio already.

The only reason I reply here is to give you pointers. I can only repeat=
 what I=20
wrote in the other mail: We need reasons why we need/want something ins=
tead of =20
reasons why we could not not want something.


> # Code complexity
>=20
> Wouldn't this actually reduce code complexity? Now the code needs
> to distinguish which packet type it got and based on that needs to
> perform TVLV parsing. "Moving TVLVs down to the common header"
> does not duplicating the code to for every packet type in my
> understanding, but the contrary, unifying things, "just moving" the
> current concept.

Please consider the broader picture: We need TVLV parsers everywhere. b=
atctl=20
and wireshark still can't not decode the TVLVs we have today. On top of=
 that,=20
TVLVs require dynamic header / memory management involving lists, locks=
, size=20
calculations, etc which you simply don't have with static headers.


> # Network Traffic overhead
>=20
> It's just 2 Bytes extra for the tvlv_len which doesn't seem much
> to me. Furthermore I'm wondering, whether saving these two bytes
> but not being able to run some new, more efficiant feature
> could be a net loss in terms of overhead in the future.

Please compare the original OGM size to the TVLV-OGM before starting to=
 talk=20
about '2 bytes extra' ...


> # TVLV parsing speed overhead
>=20
> If no TVLV were actually added, then this would be nearly zero
> parsing overhead, checking whether tvlv_len =3D=3D 0 is trivial. Of
> course, if no other packet types than the current TVLV capable
> ones were actually having TVLVs one day, then wouldn't need this
> discussion, true. Broadcast packets, for instance, aren't really
> on the fastest fastpath, thre it wouldn't harm TVLVs, I think. But
> also in general, I don't quite see, why packets on the fastpath
> shouldn't have some TVLVs in the future: For one thing the parsing
> speed overhead heavily depends on the kind of TVLV, how complex it
> is to parse it. And why not having some easy to parse TVLVs for
> those too? Embedded systems already need to be able to parse
> Ethernet and IP headers as well as IP options on a hop-by-hop
> basis in layer 3 routing. Also, even embedded systems become
> faster and faster every day.

So, you are saying there is overhead but we should not care because sys=
tems=20
get faster and faster anyway ? Or are you saying your coming proposal o=
nly=20
contains tvlv_len =3D 0 ?


> # Encapsulation speed overhead
>=20
> Again, heavily depends on the kind of TVLV, doesn't it?

Your point being ? Actually, your last statement illustrates my point. =
Shortly=20
after the start of the discussion we are already so abstract that I don=
't even=20
know what we are talking about.

Cheers,
Marek

--nextPart44604192.IDI2KnnMk1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSZvlNAAoJEFNVTo/uthzAlpcH/2vtBw/3+SWBCqhUaumzvo11
l21fZ4h2dYDsnGqPj2zA1S1qwdJf1waiRJPD5xOXbMvpBezELGGDLEXz1/7TShT0
8epyMg6ZFsbPDXrf7U68+Zhs6vHPJ0VfQjtPvaLxEvmu/xtLNa2ueqKbdkk7Esns
lXkdaig6w9NlPKP4v/yvWWwO+Kv0SA3RphoRWCn1Fw9olnV9cNGhH+xBPWHh/+j0
tqs0ghmJi9qRZbStQXDfCX0o1VP5tdRUFCx+8W1Jp2jOBLK3wTtuO01c4dA5xbgX
RHgAmAC+mHbGLXixBzIvEZyh+k79YRnQkCdk9YLiN5b4mleKaeuJa24C6JvHqgg=
=HCnI
-----END PGP SIGNATURE-----

--nextPart44604192.IDI2KnnMk1--

