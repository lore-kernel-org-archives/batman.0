Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 May 2013 15:30:57 +0800
References: <1367879362-3164-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1367879362-3164-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305121530.57674.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: don't use call_rcu if not
	needed
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
Cc: Antonio Quartulli <ordex@autistici.org>

On Tuesday, May 07, 2013 06:29:22 Antonio Quartulli wrote:
> batadv_tt_global_entry_free_ref uses call_rcu to schedule a
> function which will only free the global entry itself.
> 
> For this reason call_rcu is useless and kfree_rcu can be
> used to simplify the code.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - removed one useless container_of in compat.c
> 
>  compat.c            |  9 +++++++++
>  translation-table.c | 20 ++++++--------------
>  2 files changed, 15 insertions(+), 14 deletions(-)

Applied in revision 1bd8161.

Thanks,
Marek
