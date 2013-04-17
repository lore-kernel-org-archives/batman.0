Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Apr 2013 03:53:36 +0800
References: <201304172356.55561.lindner_marek@yahoo.de>
 <1366225996-13954-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1366225996-13954-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201304180353.36445.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Avoid double freeing of
	bat_counters
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
Cc: Martin =?utf-8?q?Hundeb=C3=B8ll?= <martin@hundeboll.net>

On Thursday, April 18, 2013 03:13:16 Martin Hundeb=C3=B8ll wrote:
> On errors in batadv_mesh_init(), bat_counters will be freed in both
> batadv_mesh_free() and batadv_softif_init_late(). This patch fixes this
> by returning earlier from batadv_softif_init_late() in case of errors in
> batadv_mesh_init() and by setting bat_counters to NULL after freeing.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
> v2:
>   Removed label as suggested by Antonio
> v3:
>   Set bat_counters to NULL after freeing
>=20
>  main.c           | 1 +
>  soft-interface.c | 9 ++++-----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Applied in revision b10ac71 with minor modifications.

Thanks,
Marek
