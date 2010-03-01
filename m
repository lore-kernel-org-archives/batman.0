Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 1 Mar 2010 15:27:08 +0800
References: <201002280430.09575.lindner_marek@yahoo.de>
	<1267302649-22040-2-git-send-email-lindner_marek@yahoo.de>
	<20100301015103.GA6602@Linus-Debian>
In-Reply-To: <20100301015103.GA6602@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201003011527.08635.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: follow /proc to sysfs
	conversion & introduce input validation
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


Hey,

> I like :). This already looks well structured for introducing more
> than one bat-interface later. 

glad to hear that! :)


> Just noticed, that I don't have this /sys/devices/virtual folder
> on my Debian stable VM. But I think we should be on the safe side
> to use
> #define SYS_BATIF_PATH "/sys/class/net/bat0/mesh/"
> instead, they look equivalent and I'm having them both avaiable on
> Debian stable (2.6.26 kernel) and Debian unstable (2.6.32 kernel).

The path "/sys/class" simply contains symlinks to the real paths. On my 
OpenWRT it looks like this:
ls -l /sys/class/net/
bat0 -> ../../devices/virtual/net/bat0
br-lan -> ../../devices/virtual/net/br-lan
lo -> ../../devices/virtual/net/lo

If the virtual path does not exist on your debian where does the symlink point 
to ? Btw, on my debian (2.6.32) the virtual path exists but we use 
/sys/class/net instead to be on the safe side.

Regards,
Marek
