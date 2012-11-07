Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Nov 2012 23:43:20 +0800
References: <1352199923-16653-1-git-send-email-ordex@autistici.org>
 <1352199923-16653-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1352199923-16653-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211072343.20419.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/5] batman-adv: fix debug message
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

On Tuesday, November 06, 2012 19:05:20 Antonio Quartulli wrote:
> In case of re-routing, the old_ttvn must be saved before being
> overwritten, otherwise the debug message will obviously print the
> new one.
> 
> This was introduced by ("batman-adv: substitute tt_poss_change with a
> per-tt_entry flag")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  routing.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied in revision 44d6e4a.

Thanks,
Marek
