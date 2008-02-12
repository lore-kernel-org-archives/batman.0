Message-ID: <20080212092737.mo3o35zwg0044gcs@webmail.ddmesh.de>
Date: Tue, 12 Feb 2008 09:27:37 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: Re: [B.A.T.M.A.N.] Rev 972: batmand -c -d n hangs sometimes
References: <20080203125031.37lz3lkn0gsc0ooc@webmail.ddmesh.de>
	<47A607A8.3050709@gmx.net>
In-Reply-To: <47A607A8.3050709@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Zitat von elektra <onelektra@gmx.net>:

[Zitattext verstecken]
Hi -

Routing is working and there is enough memory. I have setup
a cron job to call "batmand -c -d [2,7,8,9]" every minutes to
update the status files on ramdisk. The webinterface then
access the content of the status file which reduces the cpu load.
just a stupid question to verify things - you have not forgotten to  
add -b for batch mode to the command?
yes, you are right. I just forgot this option in the previous post.
The firmware uses the -b option.
When I create the firmware I'm using the whiterussian kit 1.4.5. It generates
the same firmware for different routers. So when I flash the WRT54GS and the
WRT54GL with the same firmware, the WRT54GL batmand hangs. There are
still 2Mbyte Ram unused. restarting batman does almost not change the memory
consumtion. I use the "top" command for this.

I have made a log when the batmand stopps. Perhaps it helps you a little.
http://www.ddmesh.de/batmand-hanglog.txt

/Stephan
