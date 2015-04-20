Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Apr 2015 11:44:09 +0800
Message-ID: <1858370.NxXzavUms0@voltaire>
In-Reply-To: <20150419174900.GG2396@odroid>
References: <1429298961-13250-1-git-send-email-sven@narfation.org>
 <20150419174900.GG2396@odroid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart59564435.W2JsWdTTqB";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Use kernel-like folder
	structure
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


--nextPart59564435.W2JsWdTTqB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, April 19, 2015 19:49:00 Linus L=FCssing wrote:
> On Fri, Apr 17, 2015 at 09:29:21PM +0200, Sven Eckelmann wrote:
> > The person submitting the patches to the Networking maintainer has =
to take
> > each patch and move files around and add some files to make it work=
 in
> > the actual kernel tree. Having all files included and already  in t=
he
> > correct kernel tree layout should make this a lot easier.
>=20
> I like the idea. Was moving patches between in- and
> out-of-kernel-tree batman-adv a few times, too and that'd
> spare an sed call in the future :).

If I am not mistaken the build process of the various packages need to =
be=20
adapted unless we provide a Makefile in the root folder ?

Apart from that detail I also like the idea of mimicking the kernel fol=
der=20
structure.


Cheers,
Marek

--nextPart59564435.W2JsWdTTqB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNHYJAAoJEFNVTo/uthzApLMH/0lPc09wojYQS6YFQYqFVEkr
NtMErJimsZNqCoAgqbHPfyaYk0uUih8QQflGUOAkwEh+f3Z/KiKZyopF2UTnk0er
tPEZ6BnbfuvpP4q2XmADJ7rLgV5yYt1njGurQbm/UOaLXcCOcgYai8X5mVe6jKms
ZT1KQ4pYsKmg/70oK5mXdIiSEgCgLw/ikAS6VpeUL545xgYqm+374wzvdtQZFHDo
CEjX/lskvFcr02q2JiIlM0tV7Xb7uThIfmZBQTD6vDj/zVHUphFHqdU+W2A9RNCG
lgL7gjqzmbzy5aNlVPlmyajnx4x+5/dTJC0O925NUJjjBDwdodboFik5x02IVss=
=Ssmj
-----END PGP SIGNATURE-----

--nextPart59564435.W2JsWdTTqB--

