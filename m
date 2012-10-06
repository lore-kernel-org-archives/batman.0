Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Oct 2012 02:47:35 +0800
References: <1349078263-5834-1-git-send-email-ordex@autistici.org>
 <1349078263-5834-10-git-send-email-ordex@autistici.org>
In-Reply-To: <1349078263-5834-10-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201210070247.35946.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 9/9] batman-adv: Add
	get_ethtool_stats() support for DAT
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

On Monday, October 01, 2012 15:57:43 Antonio Quartulli wrote:
> From: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
>=20
> Added additional counters for D.A.T.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  distributed-arp-table.c | 19 +++++++++++++++++--
>  distributed-arp-table.h | 27 +++++++++++++++++++++++++++
>  routing.c               |  8 +++++++-
>  soft-interface.c        |  7 +++++++
>  types.h                 |  7 +++++++
>  5 files changed, 65 insertions(+), 3 deletions(-)

Applied in revision b996a44.

Thanks,
Marek
