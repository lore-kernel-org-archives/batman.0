Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 22 Jun 2012 20:01:21 +0200
References: <1340310534-7578-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1340310534-7578-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206222001.21558.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: prepend BATADV_ to TT flags
	in comments
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thursday, June 21, 2012 22:28:54 Antonio Quartulli wrote:
> After having added the BATADV_ prefix to all the TT_CLIENT flags, we have
> to add the same prefix in every comment where they are mentioned.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> this patch is based on top of next. It should be merged into next in order
> to fix the patch adding the prefix in front of the TT flags
> 
> 
>  packet.h            |    2 +-
>  translation-table.c |   14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)

Applied in revision 8dcb403.

Thanks,
Marek
