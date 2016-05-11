Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 May 2016 15:48:01 +0800
Message-ID: <2461308.vqpoq73gv5@voltaire>
In-Reply-To: <1462952200-6368-1-git-send-email-sven@open-mesh.com>
References: <1462952200-6368-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart19508602.BLLGtyWHqD";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Only init ELP tweaking
	options when BATMAN_V is enabled
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart19508602.BLLGtyWHqD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, May 11, 2016 09:36:40 Sven Eckelmann wrote:
> From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> 
> The build currently fails with CONFIG_BATMAN_ADV_BATMAN_V=n because
> hard_iface->bat_v is only defined when CONFIG_BATMAN_ADV_BATMAN_V=y is set.
> The initialization of bat_v.throughput_override/bat_v.elp_interval
> must therefore only be compiled in when also BATMAN_V is enabled.
> 
> Fixes: 71e957cd30a0 ("batman-adv: init ELP tweaking options only once")
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
>  net/batman-adv/hard-interface.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied in revision ffd2f27.

Thanks,
Marek

--nextPart19508602.BLLGtyWHqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMuOxAAoJEFNVTo/uthzAE24IAL5w9PxLgOiSyvP9OGxT4UW3
amCz743jzvccSIWw6oDuqz0BKFSW37kuVrj5AxGHaN2gSP54uAcaWZTdIPfarcyj
vNHzrsI4mLRPSEEEUea082fL1/R1WZkg1ubiUaB4jNszpKVDBu7Owkf5TpS6QPjd
sU1FG2V9T4OqS7oDdmv2nODv4x3xhfUxXYezUywd7tDt1kKySbq/gLk7sOLDfdNg
lMdPIHkMNRmvJZrCZsXB+EjV/HWFYS1UJJzfxDiQHmZk2/amdyezqpCJws5pKmZr
s5YDZhwOZrjZ5C1/o67PpANhfT0JXNcoY4jpZQb7nOAtcbi9JxC+qodFE+S4Ucw=
=3lIz
-----END PGP SIGNATURE-----

--nextPart19508602.BLLGtyWHqD--

