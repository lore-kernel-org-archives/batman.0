Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Apr 2013 22:03:09 +0800
References: <1365009026-931-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1365009026-931-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304162203.09702.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: let is_my_mac() check for
	the current mesh only
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

On Thursday, April 04, 2013 01:10:26 Antonio Quartulli wrote:
> In a multi-mesh node (a node running more than one batman
> virtual interface) batadv_is_my_mac() has to check MAC
> addresses of hard interfaces belonging to the current mesh
> only
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> I think this is worth being merged into maint.
> Being a fix, it should be sent to net.
> 
> Cheers,
> 
> 
>  main.c              |  5 ++++-
>  main.h              |  2 +-
>  network-coding.c    | 12 ++++++------
>  routing.c           | 38 ++++++++++++++++++++------------------
>  translation-table.c |  2 +-
>  vis.c               |  4 ++--
>  6 files changed, 34 insertions(+), 29 deletions(-)

Backported and applied on maint in revision 647d23f.

Thanks,
Marek
