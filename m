Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 08 Aug 2015 03:06:18 +0800
Message-ID: <3592510.EADgsIozEl@voltaire>
In-Reply-To: <1438968522-3470-1-git-send-email-sven@narfation.org>
References: <1438968522-3470-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7092589.6qbHdCetM4";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: Add lower layer
	needed_(head|tail)room to own ones
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


--nextPart7092589.6qbHdCetM4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, August 07, 2015 19:28:42 Sven Eckelmann wrote:
> The maximum of hard_header_len and maximum of all needed_(head|tail)room of
> all slave interfaces of a batman-adv device must be used to define the
> batman-adv device needed_(head|tail)room. This is required to avoid too
> small buffer problems when these slave devices try to send the encapsulated
> packet in a tx path without the possibility to resize the skbuff.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v4:
>  - only check non-BATADV_IF_NOT_IN_USE interfaces
>  - drop the batadv_hardif_disable_interface changes which are already
>    handled by the non-BATADV_IF_NOT_IN_USE check
> v3:
>  - set hard_header_len always to ETH_HLEN and only modify needed_headroom
>    as done in mac80211/vxlan
>  - do the same for needed_tailroom
> v2:
>  - based on patch "batman-adv: don't access unregistered net_device object"
>  - remove the function call from batadv_update_min_mtu
>  - instead use batadv_hardif_disable_interface +
>    batadv_hardif_enable_interface
> ---
>  net/batman-adv/hard-interface.c | 41
> +++++++++++++++++++++++++++++++++++++++++ net/batman-adv/soft-interface.c
> |  2 --
>  2 files changed, 41 insertions(+), 2 deletions(-)

Applied in revision e2b4301.

Thanks,
Marek


--nextPart7092589.6qbHdCetM4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVxQGuAAoJEFNVTo/uthzAw6YIAKw6Z3ti53SeHdrM0Dk5UF91
ge4P/f8+javshVi7ufL0aPTRI3LctbB+/reiQyBFp1lEYPWeOhY+PMfg1o/PC5A3
9Vy1YWUmNTY6i8/0J/vnZY22SBKkNACQuQo+lEaqbTnAr6wPlSbmOAx0Ac9i0g9r
1a7d5zyWil75RYRclACD/t8V/PJE9tNHWWrjR2/vK++A6Tr9LyHJwlz22SVbFhdv
ovTuaDMcJt+QX5XElmhIVJLshOWyZc7RWibIP6FS+97l687EohlvYIWXpnkC0WB1
zqo/yGsIZ9aOxrbX6hOR/kGedm55heFCytvHro5pDjFhJCVbgH226kWfzp3BMSw=
=E/Wj
-----END PGP SIGNATURE-----

--nextPart7092589.6qbHdCetM4--

