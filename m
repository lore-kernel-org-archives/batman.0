Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 01 Mar 2015 18:20:50 +0800
Message-ID: <4306674.F7nSybvRle@voltaire>
In-Reply-To: <1425142217-18966-1-git-send-email-mareklindner@neomailbox.ch>
References: <1425142217-18966-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1758261.iS1W6kgkx3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: split name from variable
	for uint mesh attributes
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--nextPart1758261.iS1W6kgkx3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 01, 2015 00:50:16 Marek Lindner wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Some mesh attributes are behind substructs in the
> batadv_priv object and for this reason the name cannot be
> used anymore to refer to them.
> 
> This patch allows to specify the variable name where the
> attribute is stored inside batadv_priv instead of using the
> name
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  sysfs.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

Applied in revision a915b64.

Thanks,
Marek

--nextPart1758261.iS1W6kgkx3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU8ugGAAoJEFNVTo/uthzAg9wIALvA7Bm7yAXDGwXsi3+6WHQV
K430b9VPCCb/kPTvYNMHo4OjCgmFVvnt+TMetmhuXUBAfMawTDV5QrqKzZvBOl2L
UJ3VR6hc7kbUDQHsc0hsp6EaXrNkxtMn3HMDIH++AdptNRKa56J9ZGHbhzoSeOnk
c5KYGW/AOOj95KOqwNoGirNvB0Ot8ZfmsLT3IrWHERpTFfziJolFNtYnLWlv16/K
8zevLLuMnR9PLAjdMNa9AdA56F0/jdvyjeh/21IQ9vfhhQMqa1aCDJrW14T2hLdr
tkDBvjolFMV0UjbCSvHZHim8/qF1PPUAitjRDZm+si5eWAPme7UeyFzrXNGYL/o=
=jY4R
-----END PGP SIGNATURE-----

--nextPart1758261.iS1W6kgkx3--

