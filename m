Return-Path: <johannes@sipsolutions.net>
Message-ID: <1398440652.4152.25.camel@jlt4.sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 25 Apr 2014 17:44:12 +0200
In-Reply-To: <1397484205-20905-1-git-send-email-antonio@meshcoding.com>
References: <1397484205-20905-1-git-send-email-antonio@meshcoding.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] cfg80211: export expected throughput
 through get_station()
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
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org, Antonio Quartulli <antonio@open-mesh.com>

On Mon, 2014-04-14 at 16:03 +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Users may need information about the expected throughput

I think this "expected throughput" should be a bit clarified.

Are you talking about "expected PHY rate" or rather "expected (payload)
throughput"?

> towards a given peer computed by the RC algorithm.
> Export such value in Mbps/100 through the get_station() API.

"units of 10Kbps" might be a better description :-)

> This unit has been chosen because it is the same of the
> throughput returned by MinstrelHT.

Since it's unlikely we'll ever reach the limit of a u32, maybe just
multiply by 10 to get the nicer Kbps?

> + * @expected_throughput: expected throughput in Mbps/100 reported by the RC
> + *	algorithm towards this station. The unit of this value has been chosen
> + *	because it is the same of the throughput returned by MinstrelHT

I think the rationale shouldn't be here now.

johannes

