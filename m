Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 19 Apr 2013 18:22:14 +0800
References: <1366366016-7691-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1366366016-7691-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201304191822.15024.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unnecessary
	INIT_HLIST_NODE() calls
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

On Friday, April 19, 2013 18:06:56 Linus L=C3=BCssing wrote:
> There's no need to for an explicit hlist_node initialization if it is
> added to a list right away, like it's the case with the
> hlist_add_head()s here.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
> Unmodified, reposted from:
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2013-March/009248.html
>=20
>  bat_iv_ogm.c |    2 --
>  send.c       |    2 --
>  2 files changed, 4 deletions(-)

Applied in revision 68a3373.

Thanks,
Marek
