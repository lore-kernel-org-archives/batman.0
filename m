Return-Path: <nbd@openwrt.org>
References: <8047297.0qIFjkW2bL@voltaire> <56A0E335.8040207@openwrt.org>
 <1664897.xQoZSmslHn@bentobox> <132128022.hJazYISVSs@bentobox>
From: Felix Fietkau <nbd@openwrt.org>
Message-ID: <56A0EF66.9090003@openwrt.org>
Date: Thu, 21 Jan 2016 15:47:02 +0100
MIME-Version: 1.0
In-Reply-To: <132128022.hJazYISVSs@bentobox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] OpenWrt cfg80211.h station_info incompatibility
 with kernel+mac80211 [was: B.A.T.M.A.N. V leaves the nest v2]
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: openwrt-devel@lists.openwrt.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

On 2016-01-21 15:26, Sven Eckelmann wrote:
> On Thursday 21 January 2016 15:03:10 Sven Eckelmann wrote:
>> On Thursday 21 January 2016 14:55:01 Felix Fietkau wrote:
>> > > @Felix, would it be ok for you when I propose a
>> > > "*-sync-cfg80211-station_info.patch" for the 3.18 generic kernel 
> patches?
>> > > Or do you have a good idea how to force the openwrt-routing batman-adv 
> package
>> > > against the cfg80211.h of compat-wireless?
>> > The openwrt mac80211 package exports its headers to
>> > $(STAGING_DIR)/usr/include/mac80211
>> > 
>> > You could just make the batman-adv package use those includes.
>> 
>> Thanks, missed that. I will prepare a pull request for openwrt-routing.
> 
> Hm, didn't work out so well. It basically explodes right away because 
> possible_net_t, possible_read_pnet, possible_write_pnet is not defined on 
> v3.18 when not using the mac80211 backporting headers. And when usign the 
> backporting headers then it will explode because it conflicts with batman-
> adv's own backporting stuff. And without the batman-adv's backporting headers 
> it will also not compile due to missing backporting hacks.
I think in the short term it would be a good idea to identify what's
missing in the mac80211 backport support and make patches for it.
You should also rebase those on top of backports.git and submit them
upstream.

For a long term solution, you guys should probably start pushing for
full batman-adv integration in kernel backports. Might be useful for
increasing adoption of the latest stuff even outside of OpenWrt.

- Felix
