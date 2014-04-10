Return-Path: <johannes@sipsolutions.net>
Message-ID: <1397149960.4757.22.camel@jlt4.sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 10 Apr 2014 19:12:40 +0200
In-Reply-To: <5346C0B3.4050704@open-mesh.com>
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
 <1396211704-4677-7-git-send-email-antonio@meshcoding.com>
 <1396951582.5936.20.camel@jlt4.sipsolutions.net>
 <5346C0B3.4050704@open-mesh.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFCv2 6/6] cfg80211: implement
 cfg80211_get_station cfg80211 API
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

On Thu, 2014-04-10 at 18:02 +0200, Antonio Quartulli wrote:

> > Any thoughts about clearing/filling/partially filling *sinfo when
> > returning an error?
> 
> At the moment this function relies on what rdev_get_station() does and I
> always assumed that in case of error the content of *sinfo should be
> considered "undefined".

That's fine, maybe add a line of documentation?

johannes

