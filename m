Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 10 Jul 2015 16:04:07 +0800
Message-ID: <1606313.sbytlt8Win@voltaire>
In-Reply-To: <1434890572-3199-4-git-send-email-sven@narfation.org>
References: <1434890572-3199-1-git-send-email-sven@narfation.org>
 <1434890572-3199-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3539483.OjcYrVHts9";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 4/4] batman-adv: Fix gw_bandwidth
	calculation on 32 bit systems
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


--nextPart3539483.OjcYrVHts9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, June 21, 2015 14:42:52 Sven Eckelmann wrote:
> The TVLV for the gw_bandwidth stores everything as u32. But the
> gw_bandwidth reads the signed long which limits the maximum value to
> (2 ** 31 - 1) on systems with 4 byte long. Also the input value is always
> converted from either Mibit/s or Kibit/s to 100Kibit/s. This reduces the
> values even further when the user sets it via the default unit Kibit/s. It
> may even cause an integer overflow and end up with a value the user never
> intended.
> 
> Instead read the values as u64, check for possible overflows, do the unit
> adjustments and then reduce the size to u32.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  * rebased on current master
> 
>  net/batman-adv/gateway_common.c | 49
> +++++++++++++++++++++++++++++++++++------ 1 file changed, 42 insertions(+),
> 7 deletions(-)

Applied in revision ca6b86f.

Thanks,
Marek

--nextPart3539483.OjcYrVHts9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVn3x3AAoJEFNVTo/uthzADt0H/A+dt5rqcRJ9oikWmwnvVgaU
QkmwvO5YarFzO6o6fpxTU3J8Sdjk+P1rQzoEu+ghRlEwJ300WWVUq6XxeWnzqgSa
wQxfjDD3Ea6tCaCUHK7GuEhKKOv6kkKm4R52eSblYn3CfIcU3RTBcVvTW8F0cho8
UmNubYUIHyfjr7yEPxiWnFK9dOJtKjU2YMu+79/ndhiH6qY02UtMO1354/7qfU+x
5/SMFonGcup+j4kMiDc9tcTAGuZTHbeODxEAQohhRcxhl9sFSFiP98k6mAuhH761
dH/21SM3Tl038+Rz1bW8A+PjHbf5dD/wJxKGxGvJuasrT+PxvAS8ks7KXHMP8WY=
=DRcu
-----END PGP SIGNATURE-----

--nextPart3539483.OjcYrVHts9--

