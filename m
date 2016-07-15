Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Jul 2016 15:54:22 +0800
Message-ID: <48953815.gotEjm2ngx@voltaire>
In-Reply-To: <12344489.b6hFVBHYRz@bentobox>
References: <1468228596-18690-1-git-send-email-linus.luessing@c0d3.blue>
 <12344489.b6hFVBHYRz@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4769589.LGcRvA50No";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use bitwise instead of
	arithmetic operator for flags
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

--nextPart4769589.LGcRvA50No
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, July 11, 2016 11:38:19 Sven Eckelmann wrote:
> On Montag, 11. Juli 2016 11:16:36 CEST Linus L=FCssing wrote:
> > This silences the following coccinelle warning:
> >=20
> > "WARNING: sum of probable bitmasks, consider |"
> >=20
> > Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> > ---
> >=20
> >  net/batman-adv/multicast.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Reviewed-by: Sven Eckelmann <sven@narfation.org>

Applied in revision f0935ab.

Thanks,
Marek

--nextPart4769589.LGcRvA50No
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXiJauAAoJEFNVTo/uthzAIpEH/1wp8VSmNDpAQ6Qm0OVwlycY
XSO49G4AoS//pKvUuPSYb/1VYHWX6Tg4X7bxwUWcHfuIYnJmoam+/OMybnyZX6L5
h5KPCB2tHI+swjtiFb/YAu1NQfrQ+6oLyWmubBisStayvGN3Q82fQFjyLyFl5dAm
aU6Nf3d91xASKCzfO1p9ppwpfwO7lFd44+Q2t/zEydQMH2e9AOoIG2/imv1BrWSl
6MEZs2GqvjcuCkN88Iavivs3OBgKCLVXOgZkRrB5mrqeRdzu2kZF5MpJ5rgXB/ml
ylYhmx90Bgk72qsLw2KH9eF84HVIpd25VBTUHxvA/0x+/nGsRkIrNTx47960Z9w=
=WFYi
-----END PGP SIGNATURE-----

--nextPart4769589.LGcRvA50No--

