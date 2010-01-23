Return-Path: <andrew@lunn.ch>
Date: Sat, 23 Jan 2010 18:50:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100123175028.GN24649@lunn.ch>
References: <20100122100238.GL24649@lunn.ch>
	<201001231127.30577.lindner_marek@yahoo.de>
	<20100123111427.GM24649@lunn.ch>
	<201001232024.58333.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201001232024.58333.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] State of batman-adv in mainline
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

On Sat, Jan 23, 2010 at 08:24:57PM +0800, Marek Lindner wrote:
> On Saturday 23 January 2010 19:14:27 Andrew Lunn wrote:
> > Well, 2.6.33 will have the in kernel dot/json formatting. So the vis
> > stuff in batctl 0.2.x is useless. 0.2.x however no longer has the
> > controls to set the vis format the kernel uses. 2.6.33 still has the
> > old logging concept, so the loglevel command with three levels is
> > wrong and the man page talks about dmesg etc...
> 
> That sounds like the 0.2 release, doesn't it ?

As i said, its a 0.2 from December. It is not the current 0.2. From
the current main.c:

http://www.open-mesh.org/browser/branches/batctl-0.2.x/main.c
41	void print_usage(void) {
42	        printf("Usage: batctl [options] commands \n");
43	        printf("commands:\n");
44	        printf(" \tinterface|if  [none|interface]  \tdisplay or modify the interface settings\n");
45	        printf(" \toriginators|o                   \tdisplay the originator table\n");
46	        printf(" \tinterval|it   [orig_interval]   \tdisplay or modify the originator interval in ms\n");
47	        printf(" \tloglevel|ll   [level]           \tdisplay or modify the log level\n");
48	        printf(" \tlog|l                           \tread the log produced by the kernel module\n");

loglevel and log are not supported by the 2.6.33 kernel. 2.6.33 uses
/proc/net/batman-adv/log_level, not /sys/module/batman_adv/parameters/debug
which this version of batctl is trying to use.

49	        printf(" \ttranslocal|tl                   \tdisplay the local translation table\n");
50	        printf(" \ttransglobal|tg                  \tdisplay the global translation table\n");
51	        printf(" \tvis_server|vs [enable|disable]  \tdisplay or modify the status of the VIS server\n");
52	        printf(" \tvis_data|vd [dot|JSON]          \tdisplay the VIS data in dot or JSON format\n");

vis_server and vis_data are not supported by 2.6.33. 2.6.33 still has
the old json and dot formatting in the kernel and /proc/net/batman/vis
being written to enable/disable client/server functionality, read from
the get the formatted data.

I think svn revision r1463 of batctl is about right for kernel 2.6.33.

  Andrew
