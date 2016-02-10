Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 10 Feb 2016 19:01:37 +0800
Message-ID: <2226895.tWGBQDvmUT@voltaire>
In-Reply-To: <1454336498-2621-1-git-send-email-sw@simonwunderlich.de>
References: <1454336498-2621-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1677447.AofP5Aktx5";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: move and restructure
	batadv_v_ogm_forward
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1677447.AofP5Aktx5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 01, 2016 15:21:37 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> To match our code better to the protocol description of B.A.T.M.A.N. V,
> move batadv_v_ogm_forward() out into batadv_v_ogm_process_per_outif()
> and move all checks directly deciding whether the OGM should be
> forwarded into batadv_v_ogm_forward().
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCH:
>  * fix some embarassing compile issues and style issues (thanks Marek)
> ---
>  net/batman-adv/bat_v_ogm.c | 110
> ++++++++++++++++++++++++++------------------- 1 file changed, 63
> insertions(+), 47 deletions(-)

Applied in revision 30c96bc.

Thanks,
Marek

--nextPart1677447.AofP5Aktx5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWuxiRAAoJEFNVTo/uthzAHZkH/1vnQo5ZH/K97QIy2Ilm0RC/
X+XSUAEMRTryrPDKR5I7CxyIpNKKMzf0KAU0kh547G7HUb1koZWpghYJg7B1rmvW
K2osKAtx0JsKk7hmTGSO5FkpqTAfOdJZmTYMWZX9W6JKsu7s0nmRepSYfhMGCL4P
z0jAKJxcfu8L2UFnKrENxavg0/wPh0ttGJ0+CK05kw8EQS1ckIa8zzHlHoG6vlyD
+KPAv80ADdYrJiJ+xw9w1YtHtMVrqMUMzA0dofONInGXU8QskC7ebAii3FrjU+1K
uV3N8HzZKb5D04GP0YVrW/5N6vmH6t8MEDRLA4AigSdZ7S6nm5msFHMNWhxPYNA=
=T77a
-----END PGP SIGNATURE-----

--nextPart1677447.AofP5Aktx5--

