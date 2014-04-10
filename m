Return-Path: <johannes@sipsolutions.net>
Message-ID: <1397150096.4757.24.camel@jlt4.sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 10 Apr 2014 19:14:56 +0200
In-Reply-To: <5346BE8A.5080601@open-mesh.com>
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
 <1396211704-4677-3-git-send-email-antonio@meshcoding.com>
 <1396951464.5936.17.camel@jlt4.sipsolutions.net>
 <5346BE8A.5080601@open-mesh.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFCv2 2/6] mac80211: add new RC API to retrieve
 expected throughput
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
To: Antonio Quartulli <antonio@open-mesh.com>
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org

On Thu, 2014-04-10 at 17:53 +0200, Antonio Quartulli wrote:
> 
> On 08/04/14 12:04, Johannes Berg wrote:
> > On Sun, 2014-03-30 at 22:35 +0200, Antonio Quartulli wrote:
> > 
> >> +	u32 (*get_expected_throughput)(void *priv, void *priv_sta,
> >> +				       struct ieee80211_supported_band *sband);
> > 
> > why would that need an sband argument?
> > 
> 
> I needed this because I saw it is required by some RC algo (only
> minstrel) to extract the bitrate starting from the index.
> 
> You can check patch 4/6 for this:
> 
> +	bitrate = sband->bitrates[mi->r[idx].rix].bitrate;
> 
> maybe I can extract it from another structure? I couldn't find any way..

Bit strange that the algorithm doesn't have the band, if it has an
index? but I guess I didn't check all the patches...

johannes

