Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 May 2016 17:19:56 +0800
Message-ID: <3205250.XVQBBQgXNj@voltaire>
In-Reply-To: <1462959332-23410-3-git-send-email-sven@open-mesh.com>
References: <2757709.ryloMgzIDh@bentobox>
 <1462959332-23410-3-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5470620.UQ4x4xditX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v8 1/2] batctl: Add attributes/command
	for BATADV_CMD_GET_MESH_INFO
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

--nextPart5470620.UQ4x4xditX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, May 11, 2016 11:35:31 Sven Eckelmann wrote:
> From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> 
> BATADV_CMD_GET_MESH_INFO will be used as common function to retrieve
> information from the kernel. This information can be used to display a
> header for debugfs tables.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
> v8:
>  * check *_IFNAME to not be larger than IFNAMSIZ as suggested by Antonio
>  * rebase on current master
> ---
>  batman_adv.h | 18 ++++++++++++++++++
>  netlink.c    | 16 ++++++++++++++++
>  2 files changed, 34 insertions(+)

Applied (netlink.c section) in 071c16c.

Thanks,
Marek

--nextPart5470620.UQ4x4xditX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXOuI8AAoJEFNVTo/uthzAPy8IAMWJV/9IUzmnAPCarQE60meu
l1rT3ANVoELlWDBAR0lXzoM4SSs5ZuouHugJqx2P4w4O9or4aiQwitmZdMbL6mnQ
ptfUDBDja5O8WKC+wtW/bVlfv38FAsnkyKVgl9neLVQPi9eojENu14XU0gHpEyfW
iylBH0kTqpmx4N0z6M5x/CjBpD5SeJonaB0+22xWnhZtyRTo9akEpIi+wfjcA0p0
YI2+/KM9s4hbPA/VJ1Rmlu8CLwGbAEmOaYzoq8QH2EbJ96lfAHGKePsJKtdwg9ot
Gb7TwJOFHN2BaPUzD6Ix9OQDIuqgo95XCcKPz6rJyJGK+7OqMv37hwNBKW/2b4E=
=0EuJ
-----END PGP SIGNATURE-----

--nextPart5470620.UQ4x4xditX--

