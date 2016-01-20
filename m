Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 20 Jan 2016 09:38:38 +0800
Message-ID: <1521420.RysEBJYiKs@voltaire>
In-Reply-To: <569E3B82.2060102@sfr.fr>
References: <569E3B82.2060102@sfr.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2707525.9KJC35i3eb";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Question about sliding windows in Batman-adv
	2015.0
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
Cc: =?ISO-8859-1?Q?J=E9r=F4me?= GRIES <jerome.gries@sfr.fr>

--nextPart2707525.9KJC35i3eb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi J=E9r=F4me,

On Tuesday, January 19, 2016 14:34:58 J=E9r=F4me GRIES wrote:
> I would like to change the duration of the sliding windows, i underst=
and
> that the duration of the sliding windows is equals to 128*intervall i=
t
> (intervall beetween every hello packets)
>=20
> [..]
>
> Could you tell me where i can find something like that in the code :
>=20
> #define _timeslidingwindows 128

all protocol defines / parameters can be found in net/batman-adv/main.h=
. The=20
one you are looking for is this:

/* sliding packet range of received originator messages in sequence num=
bers
 * (should be a multiple of our word size)
 */
#define BATADV_TQ_LOCAL_WINDOW_SIZE 64

Cheers,
Marek

--nextPart2707525.9KJC35i3eb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnuUeAAoJEFNVTo/uthzACkUIAJLj46OizsL6L3D1wbT36AOi
KHmg/n3YXllFbRovR1Xe1zCvKZSsPUT/eOxlAjCp/jmN1Uhii705HI0urObenORJ
1wtoFxL/UFb6DFgFpYyWcCJ+5UD/cNA1QV7j3yEi3zI51JmxzU++fZSBHCqXdteo
A0Iw5ZSddVWzZhQghjGH/PICiPHd0mQqUy8jVb1mDIiJ5UAJWbxjNX+hQeafEpLD
uy1e8CUrTxLR0NiqoEFgY1zSn1Flcf4vIAMnlhBY2tOCBBo17pAPKUO0ggFCb1SI
zfBcZ3rB5ca7kVjFAcfLA8TgUyjEMi07Yj6uaAmhKwSxmp5+qHFRftLkqftzkU8=
=+/wK
-----END PGP SIGNATURE-----

--nextPart2707525.9KJC35i3eb--

