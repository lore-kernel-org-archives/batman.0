Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Jun 2015 21:53:47 +0800
Message-ID: <2022714.gP4Hb47QDf@voltaire>
In-Reply-To: <1435150220-25157-1-git-send-email-sw@simonwunderlich.de>
References: <1435150220-25157-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1510388.XsGbRyeHWF";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: initialize up/down
	values when adding a gateway
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


--nextPart1510388.XsGbRyeHWF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, June 24, 2015 14:50:19 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> Without this initialization, gateways which actually announce up/down
> bandwidth of 0/0 could be added. If these nodes get purged later, the
> gw_node structure does not get removed since batadv_gw_node_delete()
> updates the gw_node with up/down bandwidth of 0/0, and the updating
> function then discards the change and does not free gw_node.
> 
> This results in leaking the gw_node structures, which references other
> structures: gw_node -> orig_node -> orig_node_ifinfo -> hardif. When
> removing the interface later, the open reference on the hardif may cause
> hangs with the infamous "unregister_netdevice: waiting for mesh1 to
> become free. Usage count = 1" message.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  gateway_client.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied in revision 3c92b63.

Thanks,
Marek

--nextPart1510388.XsGbRyeHWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVj/x0AAoJEFNVTo/uthzAsRcH/j6G+vzodYUFyH4YcKxYVWan
UpWoMULW5wqcvMbT7jTsHVaS5gDbDI0allXCtF2/AXP6EaGIeoJVwIOZY5qQAKjr
8ZpTawjn8yaxSg+MlFPnqk4IiS3pkMRkfz3ujJje+XFjNr32aBt3MKVzUUUjXwSK
F7T3/s+YZHxx4iNsuYHzPBzXxEIK6kOMvF3ksVKQqrES2swLGyFGSykf4pVnNdeR
WcYb6sm+9j1FwutL3Bj6HoVDlRNnPptK2rxPTZqhKB8du6jEIeH/zJQCODrucacH
lwfa9xcUQkLYrTOx8PBj+J8kSwclsVj1/gmpB2nSHIM84x2/mOmi5rJMlsKydCA=
=LePk
-----END PGP SIGNATURE-----

--nextPart1510388.XsGbRyeHWF--

