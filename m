Return-Path: <johannes@sipsolutions.net>
Message-ID: <1472537253.4249.6.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 30 Aug 2016 08:07:33 +0200
In-Reply-To: <20160819200248.8202-1-linus.luessing@c0d3.blue>
 (sfid-20160819_220304_170640_809CF938)
References: <20160819200248.8202-1-linus.luessing@c0d3.blue>
 (sfid-20160819_220304_170640_809CF938)
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] cfg80211: Add stub for
	cfg80211_get_station()
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Fri, 2016-08-19 at 22:02 +0200, Linus Lüssing wrote:
> This allows modules using this function (currently: batman-adv) to
> compile even if cfg80211 is not built at all, thus relaxing
> dependencies.
> 
Err, excuse the earlier empty email - editing mixup.

I've applied this and will send it to 4.8 so you can take advantage of
it sooner (to adjust the Kconfig dependencies, presumably).

johannes
