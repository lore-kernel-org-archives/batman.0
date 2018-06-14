Return-Path: <johannes@sipsolutions.net>
Message-ID: <1528974316.26847.0.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 14 Jun 2018 13:05:16 +0200
In-Reply-To: <1567584.jbsRn7ofiA@bentobox>
 (sfid-20180614_125324_149221_2D722F3B)
References: <1528971137-432-1-git-send-email-omer.efrat@tandemg.com>
 <32533954.9n15W0HXMB@bentobox> <1567584.jbsRn7ofiA@bentobox>
 (sfid-20180614_125324_149221_2D722F3B)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/5] batman: use BIT_ULL for
 NL80211_STA_INFO_* attribute types
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Omer Efrat <omer.efrat@tandemg.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org

On Thu, 2018-06-14 at 12:53 +0200, Sven Eckelmann wrote:
> Hi,
> 
> here are the infos which were missing and which should be included in the 
> commit message
> 
> > > Since 'filled' member in station_info changed to u64
> 
> in commit 739960f128e5 ("cfg80211/nl80211: Add support for 
> NL80211_STA_INFO_RX_DURATION")

Yeah, which actually means this patch isn't needed?

BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT) is fine since
NL80211_STA_INFO_EXPECTED_THROUGHPUT is actually == 27.

johannes
