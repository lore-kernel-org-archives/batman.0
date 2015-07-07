Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 07 Jul 2015 16:48:18 +0800
Message-ID: <3475166.ZnDsjA6BGd@voltaire>
In-Reply-To: <1435940999-3829-5-git-send-email-linus.luessing@c0d3.blue>
References: <1435940999-3829-1-git-send-email-linus.luessing@c0d3.blue>
 <1435940999-3829-5-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3824007.6ma5kjZP6L";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint 4/4] batman-adv: Fix broken MCAST
	capability check
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


--nextPart3824007.6ma5kjZP6L
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, July 03, 2015 18:29:59 Linus L=FCssing wrote:
> The introduction of set_bit() and clear_bit() calls in batman-adv
> wrongly passed bitmasks and not the bit numbers to these functions.
> This leads to broken capability checks.
>=20
> Fixing this by making the capability enum a non-bitmasked one and by
> that passing non-masked values to set_bit()/clear_bit().
>=20
> Fixes: 201a54ba710a ("batman-adv: Make MCAST capability changes atomi=
c")
> Reported-by: Def <def@laposte.net>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  multicast.c |   11 ++++++-----
>  types.h     |    2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)

Applied in revision 1798ad3.

Thanks,
Marek

--nextPart3824007.6ma5kjZP6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVm5JSAAoJEFNVTo/uthzA8JQIAINg39tqvb+hJs8f5vtLQmsd
hPo2p7LOxwiuxxWEVWmBFQjTihys/hI8zlasnFwJ/hw17O4rNHamdq6eOaxbPcWd
7KAOpk/NKi8xOU47scMOiFpwPA6VduaLbkyGUyJ4RnNHHwgmT1NjNZk1FPI3WT6k
F85TOtZMpXOt/HM+A4DYVTfkeuyG1KooKCEJGldXvgXYmrsNv84YfxdlD3Ers0Hl
2NmuU1Y8hNJe0dQjqtZrAFoGJvkMWDSOjiLidX7P/5NFPIBQAGSKLaXvvfoYLIHr
bq97xwBvdAnVEnzHlxiPUSU4UGlyGpR6nZkutL+8XGSQdFxWnUOOHFYXNhnW+GQ=
=+UC3
-----END PGP SIGNATURE-----

--nextPart3824007.6ma5kjZP6L--

