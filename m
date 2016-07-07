Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 07 Jul 2016 14:20:24 +0800
Message-ID: <4703647.RgJ4DtV1Gr@voltaire>
In-Reply-To: <3881329.4jsIrYQ9vh@sven-edge>
References: <1466451595-6347-1-git-send-email-linus.luessing@c0d3.blue>
 <3881329.4jsIrYQ9vh@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1619222.00glkc8sid";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: Introduce forward packet
	creation helper
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

--nextPart1619222.00glkc8sid
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, June 20, 2016 22:14:28 Sven Eckelmann wrote:
> On Monday 20 June 2016 21:39:54 Linus L=FCssing wrote:
> > This patch abstracts the forward packet creation into the new funct=
ion
> > batadv_forw_packet_alloc().
> >
> > The queue counting and interface reference counters are now handled=

> > internally within batadv_forw_packet_alloc() and its
> > batadv_forw_packet_free() counterpart. This should reduce the risk =
of
> > having reference/queue counting bugs again and should increase
> > code readibility.
> >
> > Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> > ---
> > Changelog v4:
> > * Removed goto in batadv_iv_ogm_aggregate_new()
> > * Removed two goto's in batadv_forw_packet_alloc()
> > * Easier to read debug output code in batadv_forw_packet_alloc()
> > * Renamed "out" and "packet_free" jump labels in
> > batadv_add_bcast_packet_to_list()>
> >   to "err" and "err_packet_free"
>=20
> Reviewed-by: Sven Eckelmann <sven@narfation.org>

Applied in revision afb07c8.

Thanks,
Marek


--nextPart1619222.00glkc8sid
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXffSoAAoJEFNVTo/uthzAgmIH/1J7vmd4nf8esvOiK6o8SgP3
YWnNkPgmBSLC1qPbEKLNUL43q1J8Kljo3T2I3+5cpmBOPDyIM5sVdxI57f3TCYqY
v88JdG284r7HqtgfJVgLmoyBVIyU5dZLehql9NYqJpYUoCV6zdgZz7APYK/e/iY3
aWUAT3WpN9A/V8PFq2iDZgaSTxm/JdxEurNILzdryNSAYdUPlGjk65PUvpiCN2JB
DmTDkezPaUKYmnEDvlBBeKloJ2vjrJ3Lb7ImyBLJjTvPpH//ekPSqyhT8j2+QkpA
q4IzQ/Sb9+osDnvOeCruoKgm/Xoun3690pCZfVmOHtvaLXPba/gKBwGGiMP1Ngo=
=ECWc
-----END PGP SIGNATURE-----

--nextPart1619222.00glkc8sid--

