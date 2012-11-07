Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Nov 2012 23:41:08 +0800
References: <1352199923-16653-1-git-send-email-ordex@autistici.org>
 <1352199923-16653-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1352199923-16653-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211072341.08972.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/5] batman-adv: fix TT packet rerouting
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

On Tuesday, November 06, 2012 19:05:19 Antonio Quartulli wrote:
> When the node checks for a packet to be re-routed or not, first it
> should consider whether the destination is a local client. Only after
> this check, the node can eventually search the global table.
> 
> This was introduced by ("batman-adv: substitute tt_poss_change with a
> per-tt_entry flag")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  routing.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)

Applied in revision 3bd73df.

Thanks,
Marek
