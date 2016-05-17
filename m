Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 May 2016 17:14:47 +0800
Message-ID: <1705687.XexGnDGZGl@voltaire>
In-Reply-To: <1463157342-13195-3-git-send-email-linus.luessing@c0d3.blue>
References: <1463157342-13195-1-git-send-email-linus.luessing@c0d3.blue>
 <1463157342-13195-3-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1528015.2i6xODdrGe";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 2/2] batctl: adding mcast flags debugfs
	table
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

--nextPart1528015.2i6xODdrGe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, May 13, 2016 18:35:42 Linus L=FCssing wrote:
> From: Linus L=FCssing <linus.luessing@web.de>
>=20
> This patch adds an option to retrieve the per originator multicast
> flags table.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>=20
> Changes in v5:
> * fixed README description of mcast_flags (copy & paste error from DA=
T)
>=20
> Changes in v4:
> * rebase to current master (no conflicts)
>=20
> Changes in v3:
> * updated mcast_flags example in README file
>=20
> Changes in v2:
> * header_lines for 'mcast_flags' increased from 2 to 6
> * Example updated to more verbose, 6 lines debugfs header output
> * (kept order for the noted manpage section as it wasn't alphabetical=
ly
>    orderd in the first place - instead keeping the previous "logical"=

>    order - 'mcast' after 'nc')
>=20
>  README       |   34 ++++++++++++++++++++++++++++++++++
>  debug.c      |    6 ++++++
>  debug.h      |    1 +
>  functions.c  |    1 +
>  man/batctl.8 |    3 +++
>  5 files changed, 45 insertions(+)

Applied in revision 2f6b65f.

Thanks,
Marek

--nextPart1528015.2i6xODdrGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXOuEHAAoJEFNVTo/uthzAXD8IAJCzZWHLeDWvk+gGBkn+9jPA
qTyD/0wgny7lzvPiAxrYSTxa6Sg/KsiHFxJ1s4zBtlkCx0RObfaLUB/IWJ+VOAEo
7DPOufZqYBEiZEfmIqc86IGUObRuEHi3LY3oaebaBP7wqQ7Yot/bUiTiQT+KbDgp
sxrNhIuhtJoNfoNIAdL3Jp4vwBa+pHuznTcfmwa/u9+w8Fidi4hQ09hifFCH28V0
myWCpepl8U7NJSIuS3KrYAkUgGC389t0X9XJzMijV5Nhxyc+AbQMQoGlsNJWVJRD
2LnHxaYaDamzfdUaOlZ3oKi2ezvDh/NSnJGzCyagEe+mKiqNwj09XWoH5RHw6VA=
=d38E
-----END PGP SIGNATURE-----

--nextPart1528015.2i6xODdrGe--

