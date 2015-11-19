Return-Path: <jens@viisauksena.de>
Message-ID: <564E2032.4000908@viisauksena.de>
Date: Thu, 19 Nov 2015 20:17:06 +0100
From: jens <jens@viisauksena.de>
MIME-Version: 1.0
References: <CAKrZ8yf8rKK__5gNsUncjt59zR7T+wuVx2x+DHQELdqWVz6DxA@mail.gmail.com>
In-Reply-To: <CAKrZ8yf8rKK__5gNsUncjt59zR7T+wuVx2x+DHQELdqWVz6DxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batctl file errors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

in addition to that see Descriptions here on raspberry pi and
installation for Freifunk Networks (which uses many of the tools)
you really want to build the tools on the Raspbian (or whatever Distro
you have) itself

https://forum.freifunk.net/t/raspberry-pi-fit-fuer-freifunk/8915/8
https://viisauksena.de/blog/raspberry-pi-und-freifunk-freiburg-or-batman-adv-mesh-network/
https://cccfr.de/wiki/freifunk:debian


On 19.11.2015 15:04, no name wrote:
> I am using BATMAN on a raspberry pi b+ with a kernel version of
> 4.1.13+ but my problem also occured on an older kernel (I tried
> updating, which did not help). My BATMAN is on batctl
> debian-2012.1.0-1 [batman-adv: 2015.0].
>
>
> I try to get the vis_mode up and running, which fails in multiple
> ways, because I can't even create logs.
>
> sudo batctl loglevel -> "Error - can't open file
> '/sys/class/net/bat0/mesh/log_level': No such file or directory"
>
> sudo batctl vm -> "Error - can't open file
> '/sys/class/net/bat0/mesh/log_level': No such file or directory"
>
> and so on. The thing is, when I try:
>
> sudo batmand s -> "Not using interface s (retrying later): interface
> not active" whereas if I try:
>
> sudo batmand s IP bat0 -> batman cannot be pinged from any other
> interface any more
>
> did I forget to install something?
>
> Thanks
> Richard

-- 
make the world nicer, please use PGP encryption

