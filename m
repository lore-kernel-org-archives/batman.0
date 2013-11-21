Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Nov 2013 09:29:21 +0800
Message-ID: <1930847.pulV1MhPXq@diderot>
In-Reply-To: <1384366492-27310-6-git-send-email-sw@simonwunderlich.de>
References: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
 <1384366492-27310-6-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3830699.PEt33L3Cro";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 5/8] batman-adv: consider outgoing
	interface in OGM sending
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart3830699.PEt33L3Cro
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 13 November 2013 19:14:49 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> The current OGM sending an aggregation functionality decides on
> which interfaces a packet should be sent when it parses the forward
> packet struct. However, with the network wide multi interface
> optimization the outgoing interface is decided by the OGM processing
> function.
> 
> This is reflected by moving the decision in the OGM processing function
> and add the outgoing interface in the forwarding packet struct. This
> practically implies that an OGM may be added multiple times (once per
> outgoing interface), and this also affects aggregation which needs to
> consider the outgoing interface as well.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCH:
>  * beautify big if/else block in batadv_iv_ogm_schedule() and comments
>  * remove TODO (obviously everyone is confused by that anyway. If
>    someone wants to optimize the aggregation later, I'm sure he/she can
>    do that without having my TODO in the code. :] )
> 
> Changes to RFCv2:
>  * rework kerneldoc and comments
> ---
>  bat_iv_ogm.c |  146
> ++++++++++++++++++++++++++++++++++++++--------------------
> send.c       |   19 ++++++--
>  types.h      |    7 ++-
>  3 files changed, 115 insertions(+), 57 deletions(-)

Applied in revision 29b9256.

Thanks,
Marek

--nextPart3830699.PEt33L3Cro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSjWHxAAoJEFNVTo/uthzAnXYH/AyrxUZiBhAbst8Hxrz/Zgw7
nsy5zr+P0tiqRbSaxSbYFHjMs/6SG672DUM+YMDZQdbaN2bd+SYBtU8eBes46ymf
iSQ4sgxQZ/vYWC4HCkpwfQeJdSO6rrepNPmrTjXHOnC6JATv+t7e5xcZk6uvloKP
UTNfptQF6eKNmgREUFjW7/UFL3m1Re0Z2RaLfevoE/f4P97dtgQjXEn3UH3ghIUY
CM0EnfJUGmNPLsoKLvi5zrmnU9rfzXsbCGmYLnZy12nGRTB3fE+wpcVLQj34XqOQ
jaMCKKtw0G+nH9aqVIeI6NCMWFCE4Z40IATc+AfJCBtNQRe+PjIwmokC+mnrnCc=
=wG2c
-----END PGP SIGNATURE-----

--nextPart3830699.PEt33L3Cro--

