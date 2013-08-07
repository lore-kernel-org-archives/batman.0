Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Aug 2013 00:43:09 +0800
References: <1375113404-10811-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1375113404-10811-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308080043.09858.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-next] batman-adv: set skb priority
	according to content
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
Cc: Simon Wunderlich <simon@open-mesh.com>

On Monday, July 29, 2013 23:56:44 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> The skb priority field may help the wireless driver to choose the right
> queue (e.g. WMM queues). This should be set in batman-adv, as this
> information is only available here.
> 
> This patch adds support for IPv4/IPv6 DS fields and VLAN PCP. Note that
> only VLAN PCP is used if a VLAN header is present. Also initially set
> TC_PRIO_CONTROL only for self-generated packets, and keep the priority
> set by higher layers.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCH:
>  * add compat code
>  * base on next instead of master
> ---
>  bat_iv_ogm.c        |    1 +
>  compat.h            |    3 +++
>  icmp_socket.c       |    1 +
>  main.c              |   58
> +++++++++++++++++++++++++++++++++++++++++++++++++++
> main.h              |    1 +
>  routing.c           |   20 +++++++++++++++++-
>  send.c              |    1 -
>  soft-interface.c    |    2 ++
>  translation-table.c |    5 +++++
>  unicast.c           |    2 ++
>  vis.c               |    2 ++
>  11 files changed, 94 insertions(+), 2 deletions(-)

Applied in revision eb76436.

Thanks,
Marek
