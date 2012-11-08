Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Nov 2012 21:06:16 +0800
References: <1352297133-17652-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1352297133-17652-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211082106.16746.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix tt_global_entries flags
	update
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

On Wednesday, November 07, 2012 22:05:33 Antonio Quartulli wrote:
> Flags carried by a change_entry have to be always copied into the
> client entry as they may contain important attributes (e.g.
> TT_CLIENT_WIFI).
> 
> For instance, a client added by means of the "early detection
> mechanism" has no flag set at the beginning, so they must be updated once
> the proper ADD event is received.
> 
> This was introduced by ("batman-adv: detect not yet announced clients")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> This patch is based on "maint"
> 
> 
>  translation-table.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied in revision fa614fd.

Thanks,
Marek
