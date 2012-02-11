Return-Path: <gmazzurco89@gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Date: Sat, 11 Feb 2012 19:15:45 +0100
Message-ID: <1511503.TNKGsptLL7@g10h4cklab>
In-Reply-To: <1909726.3aAO7925oA@g10h4cklab>
References: <1807712.xKAsDcUsSn@g10h4cklab>
	<201202120141.41695.lindner_marek@yahoo.de>
	<1909726.3aAO7925oA@g10h4cklab>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] batman openwrt
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I am working on a patch but i have some question

here:
./files/etc/hotplug.d/net/99-batman-adv:9:              [ -d 
/sys/class/net/$INTERFACE/mesh/ ] && config_bat "$INTERFACE"

shouldn't it be bat_config intead of config_bat?

i have tried to find config_bat definition but without success :|


On Saturday 11 February 2012 18:58:26 you wrote:
> > It might be a recommended behavior but simply making it a list in the
> > configuration file and wondering why it does not work is kind of strange
> > ..
> 
> ehhe you are right but i was fooled by that
> 
> > Then only worked by accident. It never was a list.
> 
> I am already working on a patch ;)
> 
> On Sunday 12 February 2012 01:41:41 Marek Lindner wrote:
> > On Sunday, February 12, 2012 01:37:22 Gioacchino Mazzurco wrote:
> > > Yes that configuration worked in the past here is info from a not
> > > recently
> > > flashed device in ninux pisa and as you can see both eth0 and ath0 are
> > > added
> > 
> > Then only worked by accident. It never was a list.
> > 
> > > moreover use of list in cases like that is the recommended openwrt
> > > beaviour
> > > so  if batman package is not working with list it should be fixed ;)
> > 
> > It might be a recommended behavior but simply making it a list in the
> > configuration file and wondering why it does not work is kind of strange
> > ..
> > 
> > Feel free to post a patch for the OpenWrt package. I'll include it.
> > 
> > Regards,
> > Marek
