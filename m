Return-Path: <johannes@sipsolutions.net>
Message-ID: <1396951502.5936.18.camel@jlt4.sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 08 Apr 2014 12:05:02 +0200
In-Reply-To: <1396211704-4677-5-git-send-email-antonio@meshcoding.com>
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
 <1396211704-4677-5-git-send-email-antonio@meshcoding.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFCv2 4/6] mac80211: minstrel - implement
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

On Sun, 2014-03-30 at 22:35 +0200, Antonio Quartulli wrote:

> +static u32
> +minstrel_get_expected_throughput(void *priv, void *priv_sta,
> +				 struct ieee80211_supported_band *sband)
> +{
> +	struct minstrel_sta_info *mi = priv_sta;
> +	int idx = mi->max_tp_rate[0];
> +	u32 bitrate, ret;
> +
> +	bitrate = sband->bitrates[mi->r[idx].rix].bitrate;
> +	ret = bitrate * MINSTREL_TRUNC(mi->r[idx].probability * 1000) / 1000;
> +
> +	return ret;

You don't need a ret variable.

johannes

