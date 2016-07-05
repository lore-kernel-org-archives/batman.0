Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 17:34:05 +0800
Message-ID: <2195360.X41xBE5PPn@voltaire>
In-Reply-To: <1467315673-9950-1-git-send-email-sven@narfation.org>
References: <1467310246-5820-1-git-send-email-sven@narfation.org>
 <1467315673-9950-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1912554.MZCYPoc4hA";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2 4/4] batman-adv: Free
	last_bonding_candidate on release of orig_node
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

--nextPart1912554.MZCYPoc4hA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 30, 2016 21:41:13 Sven Eckelmann wrote:
> The orig_ifinfo reference counter for last_bonding_candidate in
> batadv_orig_node has to be reduced when an originator node is released.
> Otherwise the orig_ifinfo is leaked and the reference counter the netdevice
> is not reduced correctly.
> 
> Fixes: 797edd9e87ac ("batman-adv: add bonding again")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - added new patch
> ---
>  net/batman-adv/originator.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied in revision 20df5c5.

Thanks,
Marek

--nextPart1912554.MZCYPoc4hA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe38NAAoJEFNVTo/uthzAnEwH/A8cM8IPnjGkNCt0RX+ulI49
KUlYINlZ6XX4fAeIZtfQyR9Amz14u2orMghzrmRr4EX3DAXR0LTfutWOShLvVZ59
H9iDnmBkIrVsHunf2EDI4KvXa7qHC5F5ndH5IFT3ezsJe1cTUZcgN+amcnB0WrN9
xOSAuTePj6G3Fyj2Ac3XaHBALzy4DxNGyDCJzJwlQOsYGL9mJB3OG9WJMHrZZQYC
8u58OJhac/S5lvmdLvBMBdZpOVlmTNEqreAl+BrocDrDP+Mj905rIb6/wb0UEqKo
tKVwlQCUrnu7rm7TKJLcF7ZrtutbkM/QFVCQZUg6RqjpAJvsOAwdyNqmyM7LVkg=
=egwU
-----END PGP SIGNATURE-----

--nextPart1912554.MZCYPoc4hA--

