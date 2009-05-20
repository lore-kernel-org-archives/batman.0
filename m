From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 21 May 2009 00:10:54 +0800
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200905200930.52901.lindner_marek@yahoo.de>
	<4313f3060905200734x3d6385f7jeac3eb3a8255355@mail.gmail.com>
In-Reply-To: <4313f3060905200734x3d6385f7jeac3eb3a8255355@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905210010.54489.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Kernel crashes with batgat installed
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Wednesday 20 May 2009 22:34:29 Nathan Wharton wrote:
> Here is the output when I have DEBUG_MALLOC on from start to finish:
> =========================================
> root@SchaferRobotics_1_3:/# batmand -d 3 -r 2 -a 10.1.3.0/24
> --disable-client-na t --hop-penalty 5 --purge-timeout 10000 ath0 eth0
> WARNING: You are using the unstable batman branch. If you are
> interested in *using* batman get the lat
> est stable release !
> B.A.T.M.A.N. 0.3.2-beta rv1256 (compatibility version 5)

Thanks, that helps.


> Adding throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo)
> Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - eth1)
> Adding throw route to 10.0.0.0/16 via 0.0.0.0 (table 68 - ath0)
> debug level: 3
> routing class: 2
> Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 65 - unknown)
> Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 66 - unknown)
> Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 67 - unknown)
> Adding throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - unknown)
> Error - can't add throw route to 10.1.3.0/24 via 0.0.0.0 (table 68): File
> exists debugRealloc - invalid magic number in trailer: 78183456, malloc tag
> = 15 Deleting throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo)
> Deleting throw route to 10.1.3.0/24 via 0.0.0.0 (table 68 - eth1)
> Deleting throw route to 10.0.0.0/16 via 0.0.0.0 (table 68 - ath0)

Ok, from your output plus the nvalid magic number we can say that it seems 
somewhat related to your HNA settings. A few more questions:
* In this case the batgat module is not involved and still it crashes ?!
* Is your network up & running ? Does batman receive messages from neighbor 
nodes (you can track that via debug log 4) ?
* Does batman also crash in a disconnected environment ?


> This is only happening when using the batgat module.
> The kernel is crashing.  If it happens to not reboot, I see that
> batman is in a device wait state and can't be killed.

The log you just provided is not about a kernel crash - its "just" the batman 
daemon. Are we hunting 2 different bugs ?


> I see that some more patches were added recently.  I will try them and
> see if anything changes.

Ok, keep us posted.

Regards,
Marek


