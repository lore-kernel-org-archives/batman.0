Return-Path: <johannes@sipsolutions.net>
Message-ID: <1397149987.4757.23.camel@jlt4.sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 10 Apr 2014 19:13:07 +0200
In-Reply-To: <5346BCEB.1010700@open-mesh.com>
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
 <1396211704-4677-3-git-send-email-antonio@meshcoding.com>
 <1396951430.5936.16.camel@jlt4.sipsolutions.net>
 <5346BCEB.1010700@open-mesh.com>
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

On Thu, 2014-04-10 at 17:46 +0200, Antonio Quartulli wrote:

> > What about drivers with HW rate control?
> > 
> 
> True, they do not implement the rate_control_ops API.
> 
> Therefore, as discussed on IRC, I need to move this new API at the
> mac80211 level, so that each driver can implement it the way it prefer.

Well, not *move*, but rather have both. Or you can just say that the
drivers that may need this can worry about it ...

johannes

