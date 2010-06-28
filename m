Return-Path: <linus.luessing@web.de>
Date: Tue, 29 Jun 2010 01:51:35 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100628235134.GA25514@Sellars>
References: <AANLkTimCSkFrm9F7DF6HWBBgo4PCb5qmy6xEmeHGonLl@mail.gmail.com>
	<201006281840.08381.sven.eckelmann@gmx.de>
	<AANLkTil7STjuod65b5gzPfIunyr81e0H8Bj0gsAWD-yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTil7STjuod65b5gzPfIunyr81e0H8Bj0gsAWD-yQ@mail.gmail.com>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] Multicast video over 2 node mesh
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

Hi Nathan,

On Mon, Jun 28, 2010 at 12:01:35PM -0500, Nathan Wharton wrote:
> On Mon, Jun 28, 2010 at 11:40 AM, Sven Eckelmann <sven.eckelmann@gmx.de> wrote:
> > Nathan Wharton wrote:
> >> I am having problems getting multicast video over my 2 node mesh.  I
> >> am building under openwrt and the version is 0.3.0-alpha rv1715.
> >
> > First thing: multicast is currently implemented over broadcast.
> >
> >> I have a lan bridge on each side.  If I directly add ath0 to the lan
> >> bridge the video works fine.  But since I want to mesh, I put ath0
> >> into bat0 instead, and then I put bat0 into the bridge.  This works
> >> for all my traffic that put across it so far except the multicast
> >> video.  A tcpdump comparison of both sides shows that after about 32
> >> packets data starts getting dropped.  The video is about 1Mbs.
> >
> > Simon changed to broadcast code some time ago. Maybe it is related. Can you
> > please try to use ethernet to transfer the data between the nodes (so bat0
> > should only have the ethernet device included). Just as test if it could be
> > related to midair collisions due to the broadcasts resends or if the broadcast
> > code as a general problem.
> 
> Connecting them via eth0 and putting eth0 in bat0 works fine, even though
> I could not set the mtu of my ethernet device to 1524.  The packets are only
> up to 1400 in size anyway.
Could you maybe compile batman-adv with extra debugging info and
especially have a look in this output for something like "old packet
received, start protection" please? As Sven said before, there've
been some additions in the code lately to prevent
never-ending-broadcast-storms if the air is very "messy" - and one
of them has been the "protected window" in rev. 1631. It would be
great if you could check if the problem was there in 1630 already.

Could you also check, if you might get the next 32 packets again
after 30 seconds?

It would also be interesting if the broadcast-throughput
has anything to do with it. Are you using the VLC player by any
chance? If I remember right, it can downsample the bitrate
on-the-fly.

And for the MTU stuff, you could set it to 1300 with ifconfig/ip
on both the sending and receiving host on the lan segment, just to
make sure (without touching any mtu's on the routers).

Cheers,
Linus
