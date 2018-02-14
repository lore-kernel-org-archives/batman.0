Return-Path: <onelektra@gmx.net>
Date: Wed, 14 Feb 2018 13:39:50 +0100
From: elektra <onelektra@gmx.net>
Message-Id: <20180214133950.a921cbaa0c78a058bcca6372@gmx.net>
In-Reply-To: <839a5aa7-ed42-27d5-1453-6b152943d811@FreeBSD.org>
References: <839a5aa7-ed42-27d5-1453-6b152943d811@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv and/or batmand porting effort to
 FreeBSD
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Mokhi -
  
batmand implements IP-based routing with an older version of the B.A.T.M.A.N. protocol. Development is stalled. It currently lacks originator message aggregation and IPv6 support. I might add some improvements and features one day, but don't bet your money on it.

However, it is a simple, lightweight and fully working mesh routing daemon that has been used mainly by Villagetelco and community networks. It can be used in high range, low bandwidth networks such as meshes between maritime sensors or short wave packet radio. For this, small packet size is required and using IPv6 addresses is unnecessary overhead.
  
Today most community networks that mainly deal with Internet traffic have replaced it with batman-adv, though. It offers more features and is under active development.

batman-adv is a different approach, as it doesn't implement IP-based routing but a virtual layer 2 switch via the mesh. batman-adv offers interesting and exciting capabilities, thanks to the different approach. However, the technical implementation is way more difficult and porting it to a different OS is probably a lot of work, as Simon has pointed out.
  
A IP-based fork of batmand is bmx6/7, which is actively developed, has IPv6 support, originator message aggregation support and many other bells and whistles.
  
There might be a *BSD port already, but I don't know. Porting bmx* should be relatively easy, as it is a IP routing daemon.
  
Cheers,
Elektra


On Tue, 13 Feb 2018 18:52:51 +0330
Mahdi Mokhtari <mmokhi@FreeBSD.org> wrote:

> Hi,
> 
> After some time of playing with the B.A.T.M.A.N protocol and
> net-interface on OpenWRT and Debian I was thinking to use it with
> the servers I use everyday (and maybe on routers/appliances I have
> nanoBSD on).
> 
> So I started an effort...
> (As a background) I already ported some applications to FreeBSD [and I'm
> maintaining them] and
> also I did work already on the Linux emulation layer of FreeBSD (FreeBSD
> has a Linux syscall-emulation and Linux-KPI layers).
> So my approach (as naturally I didn't expect the build of batman-adv.ko
> to be successful as is),
> was based on the approach that we [at FreeBSD] did to port Linux's
> drm... <https://github.com/FreeBSDDesktop/kms-drm>
> I ended up in adding some header-files to FreeBSD Linux-KPI (like
> average.h, percpu.h, ...).
> Now I'm at a state that Netlink blocks me and I'm to determine next step :-)
> [Which I don't assume it being trivial with my current approach]
> 
> So I'd like to ask:
> 1- Is it better approach to "rewrite" batman-adv.ko [at least
> Netlink-ish (let's call "Linuxism") parts] than what I'm doing now?
> 2- Any other efforts are being done out there?
> 3- is batmand deprecated [So I should mainly focus on batman-adv.ko]?
> 4- any other comments do you have? :D
> 
> P.S. sorry if I'm not really good at starting conversation from scratch
> and out-of-nowhere :D
> but I hope by continuing the collaboration we can have better (more
> enriched) FreeBSD and better (as in more portable) B.A.T.M.A.N :-)
> 
> 
> -- 
> Best regards, MMokhi.
> 


-- 
Viral meme of radical freedom 
 
The fact that you talk in your head doesn't mean that you think. 
 
The best way to lose control over yourself is trying to control yourself. 
 
Most people experience themselves as a voice in their head, telling them 
 who they are, what they think and what they have to do. 
 
http://en.wikipedia.org/wiki/Meme 
