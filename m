Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 27 Jan 2013 13:21:30 +0800
References: <1357989546-12762-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1357989546-12762-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301271321.30516.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: replace redudant
	primary_if_get calls
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday, January 12, 2013 19:19:06 Marek Lindner wrote:
> The batadv_priv struct carries a pointer to its own interface
> struct. Therefore, it is not necessary to retrieve the soft_iface
> via the primary interface.
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  distributed-arp-table.c |   22 ++++------------------
>  sysfs.c                 |   10 +---------
>  translation-table.c     |   25 ++++++-------------------
>  3 files changed, 11 insertions(+), 46 deletions(-)

Applied in revision 8d58064.

Regards,
Marek
