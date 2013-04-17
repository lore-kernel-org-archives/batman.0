Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Apr 2013 05:57:07 +0800
References: <1364934524-11764-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1364934524-11764-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304180557.07906.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't deal with NET_IP_ALIGN
	manually
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

On Wednesday, April 03, 2013 04:28:44 Antonio Quartulli wrote:
> Instead of dealing with NET_IP_ALIGN during allocation and
> headroom reservation, it is possible to use
> netdev_alloc_skb_ip_align() which transparently allocate
> and reserve the correct amount of data
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> compat stuff: compiled tested only on 2.6.32
> 
>  bat_iv_ogm.c        |  6 +++---
>  compat.h            | 10 ++++++++++
>  icmp_socket.c       |  4 ++--
>  translation-table.c | 20 ++++++++++----------
>  vis.c               | 12 ++++++------
>  5 files changed, 31 insertions(+), 21 deletions(-)

Applied in revision 1cacf96.

Thanks,
Marek
