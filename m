Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 19 Apr 2013 19:30:49 +0800
References: <1366291255-30080-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1366291255-30080-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201304191930.49880.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH repost] batman-adv: schedule global entry
	removal earlier
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Antonio Quartulli <ordex@autistici.org>

On Thursday, April 18, 2013 21:20:55 Antonio Quartulli wrote:
> Instead of scheduling the global entry removals in
> batadv_orig_node_free_rcu() (which would result in
> scheduling other RCU callbacks for the next RCU period),
> do it in batadv_orig_node_free_ref() directly.
>=20
> In this way all the callbacks get scheduled in one RCU
> period.
>=20
> CC: Linus L=C3=BCssing <linus.luessing@web.de>
> CC: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> CC: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  originator.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

I'd rather see a cleaner solution instead making the "less than ideal"=20
situation worse.

Cheers,
Marek
