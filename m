Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 7 Nov 2011 01:27:27 +0800
References: <CAKeC-QFhm8CgyT8HwGqPwtS=E2g_2Haq3bUK2p+GZnppnwUBgQ@mail.gmail.com>
	<CAKeC-QEJAJVk1=bdB0R6iqu_Q5NBdcgL3=qU9-KLg8k7zbCKMQ@mail.gmail.com>
	<CAKeC-QGBb3n-_x0rpvp-BFy4NuHdsh_hOPUwh4wRHvH3xkuT8Q@mail.gmail.com>
In-Reply-To: <CAKeC-QGBb3n-_x0rpvp-BFy4NuHdsh_hOPUwh4wRHvH3xkuT8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201111070127.27769.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] MTU issue
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


Hi,

> However using the latest trunk Openwrt, batman-adv it simply does not
> communicate via the bat0 interface.
> 
> bat0 is up, batctl confirms correct interface, MTU set at 1527 or 1528
> or even a touch higher still does not produce batctl pings or
> originator lists.

in your previous mail you said increasing the MTU value helped and now it does 
not ? It is a bit confusing .. Would you mind to clarify ?
We had some bugs in the 2011.3.0 release which led to connection issues, 
therefore we released 2011.3.1. However, the originator list was unaffected.
You might want to give it a try.


> Thus I was wondering if anybody has had the same problem, to assist me
> compiling WRT trunk with a older version, I tried the Wiki procedure
> for older version editing makefile to 2010.2.0 which produced a error
> , " can;t remove /usr/sbin/batcl ;permissions at the build stage.

The location of the batctl binary changed. You can find the necessary changes 
in the OpenWrt repository.

Regards,
Marek
