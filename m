Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Apr 2013 21:08:41 +0800
References: <1365426498-3187-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1365426498-3187-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304162108.41345.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use eth_hdr() when possible
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

On Monday, April 08, 2013 21:08:18 Antonio Quartulli wrote:
> Instead of casting the result of skb_mac_header() to
> "struct ethhdr *" every time, the eth_hdr inline function
> can be use to beautify the code and improve its readability
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  bat_iv_ogm.c            |  2 +-
>  bridge_loop_avoidance.c |  8 ++++----
>  network-coding.c        | 10 +++++-----
>  routing.c               | 12 ++++++------
>  send.c                  |  2 +-
>  soft-interface.c        |  2 +-
>  6 files changed, 18 insertions(+), 18 deletions(-)

Applied in revision 1015463.

Thanks,
Marek
