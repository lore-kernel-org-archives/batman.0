Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Nov 2013 11:30 +0800
Message-ID: <1674408.CWmMTnBMIb@diderot>
In-Reply-To: <1384599832-3959-2-git-send-email-antonio@meshcoding.com>
References: <1384599832-3959-1-git-send-email-antonio@meshcoding.com>
 <1384599832-3959-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5801283.BLscItgJyk";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/6] batman-adv: add isolation_mark
	sysfs attribute
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart5801283.BLscItgJyk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 16 November 2013 12:03:47 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> This attribute can be used to set and read the value and the
> mask of the skb mark which will be used to classify the
> source non-mesh client as ISOLATED. In this way a client can
> be advertised as such and the mark can potentially be
> restored at the receiving node before delivering the skb.
> 
> This can be helpful for creating network wide netfilter
> policies.
> 
> This sysfs file expects a string of the shape "$mark/$mask".
> Where $mark has to be a 32-bit number in any base, while
> $mask must be a 32bit mask expressed in hex base. Only bits
> in $mark covered by the bitmask are really stored.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  soft-interface.c     |  2 ++
>  sysfs-class-net-mesh |  8 ++++++
>  sysfs.c              | 71
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
> types.h              |  2 ++
>  4 files changed, 83 insertions(+)

Applied in revision e29249b.

Thanks,
Marek

--nextPart5801283.BLscItgJyk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSiDg8AAoJEFNVTo/uthzAjPQH/RiyM57TCedTK2AbVhxilfRB
dgEadO/tfqGgvRgU2s50YiJc8Z04CI59U75rkh2opu0rVAZ91QkR7WCIga/GGf7z
tnd997QU7+2eK4ilzI8g5nnl6kU/VwALqCirRN0TAzAYFI8wI/IE6W/fRdo+WmZn
wZDmOmTY7VzStCSvG4LNbmjsrtQAuRVqPhfoBwRaXFfQvChqdNakurRmDWcQIne8
PhIQdxeezEBHi+adzBlZ86vwoOCx9rimmbEOHLLfR5Lxa3uNqwy3pELlFRGm67Mv
CeI3NSXagUHFCbC8mZqnyquuikGSBHnw/cweEVgi42suAwWwuCCXMKQqzP/eGO4=
=F0Bd
-----END PGP SIGNATURE-----

--nextPart5801283.BLscItgJyk--

