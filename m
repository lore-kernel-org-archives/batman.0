Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat,  7 Jun 2014 18:26:25 +0200
Message-Id: <1402158389-13239-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 net-next 0/4] bridge: multicast snooping
	patches / exports
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
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Herbert Xu <herbert@gondor.apana.org.au>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>

The first patch is simply a cosmetic patch. So far I (and maybe others
too?) have been regularly confusing these two structs, therefore I'd
suggest renaming them and therefore making the follow-up patches easier
to understand and nicer to fit in.

The second patch fixes a minor issue, but probably not worth for stable.


On the other hand the first two patches are also preparations for the
third and fourth patch:

These two patches are exporting functionality needed to marry the bridge
multicast snooping with the batman-adv multicast optimizations recently
added for the 3.15 kernel, allowing to use these optimzations in common
setups having a bridge on top of e.g. bat0, too. So far these bridged
setups would fall back to simple flooding through the batman-adv mesh
network for any multicast packet entering bat0.

More information about the batman-adv multicast optimizations currently
implemented can be found here:

http://www.open-mesh.org/projects/batman-adv/wiki/Basic-multicast-optimizations

The integration on the batman-adv side could afterwards look like this,
for instance:

http://git.open-mesh.org/batman-adv.git/commitdiff/576b59dd3e34737c702e548b21fa72059262f796?hp=f95ce7131746c65fbcdffcf2089cab59e2c2f7ac


Changes in v4:
 - merged header postings from all previous patchset versions

Changes in v3:
 - use EXPORT_SYMBOL_GPL() instead of EXPORT_SYMBOL()

Changes in v2:
 - fix a nasty typo in PATCH 1/4, br_multicast_update_query_timer():
   "br->multicast_query_interval" vs. "br->multicast_querier_interval"
   => this accidentally reduced the other querier present timer 
      from 255 to 125 seconds
 - fix a typo in PATCH 2/4, br_ip{4,6}_multicast_query():
   ntohs(ETH_P_{IP,IPV6}) vs. htons(ETH_P_{IP,IPV6})
 - add missing ntohl()s before address comparison in PATCH 2/4,
   br_ip4_multicast_select_querier() (thanks David!)

Cheers, Linus

