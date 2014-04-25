Return-Path: <johannes@sipsolutions.net>
Message-ID: <1398440774.4152.28.camel@jlt4.sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 25 Apr 2014 17:46:14 +0200
In-Reply-To: <1397484205-20905-5-git-send-email-antonio@meshcoding.com>
References: <1397484205-20905-1-git-send-email-antonio@meshcoding.com>
 <1397484205-20905-5-git-send-email-antonio@meshcoding.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/7] mac80211: minstrel - implement
 get_expected_throughput() API
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: devel@lists.open80211s.org, Felix Fietkau <nbd@openwrt.org>, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org, Antonio Quartulli <antonio@open-mesh.com>

On Mon, 2014-04-14 at 16:03 +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Cc: Felix Fietkau <nbd@openwrt.org>
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  net/mac80211/rc80211_minstrel.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/net/mac80211/rc80211_minstrel.c b/net/mac80211/rc80211_minstrel.c
> index 26fd94f..cd40bc0 100644
> --- a/net/mac80211/rc80211_minstrel.c
> +++ b/net/mac80211/rc80211_minstrel.c
> @@ -657,6 +657,18 @@ minstrel_free(void *priv)
>  	kfree(priv);
>  }
>  
> +static u32
> +minstrel_get_expected_throughput(void *priv, void *priv_sta,
> +				 struct ieee80211_supported_band *sband)
> +{
> +	struct minstrel_sta_info *mi = priv_sta;
> +	int idx = mi->max_tp_rate[0];
> +	u32 bitrate, ret;
> +
> +	bitrate = sband->bitrates[mi->r[idx].rix].bitrate;
> +	return bitrate * MINSTREL_TRUNC(mi->r[idx].probability * 1000) / 100;

/100? didn't you say minstrel already used your units?

johannes

