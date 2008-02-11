From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Rev 972: batmand -c -d n hangs sometimes
Date: Mon, 11 Feb 2008 13:04:42 +0100
References: <20080203125031.37lz3lkn0gsc0ooc@webmail.ddmesh.de>
In-Reply-To: <20080203125031.37lz3lkn0gsc0ooc@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802111304.42349.axel@open-mesh.net>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi Stephan,

I have several WRT54GL here and I can execute something like
"batmand -cbd8"
as often as I want. It never hangs. 
Can you attach the cron file that is executed and that causes the problem?

ciao,
axel

On Sonntag 03 Februar 2008, Freifunk Dresden wrote:
> Hi,
>
> I'm currently try using batmand-experimental Rev.972.
>
> I have encountered a strange behaviour. I'm running two
> WRT54 (GL and GS).
> Routing is working and there is enough memory. I have setup
> a cron job to call "batmand -c -d [2,7,8,9]" every minutes to
> update the status files on ramdisk. The webinterface then
> access the content of the status file which reduces the cpu load.
>
> The WRT54GS is working almost, but the WRT54GL hangs after a while
> as described below:
>
> The call to "batmand -c -d [2,7,8,9]" blocks batmand completely.
> batman does not do any routing and OGM processing. As result the
> router leaves the network.
> I can still call "batmand -c -r 3" and verify with "batmand -c" that the
> options were set. But OGMs are not processed.
> Any call to access the debug-information is blocked.
>
> After killall batmand and restart the call to "batmand -c -d x" is possible
> serveral times until batman hangs. The process list shows this
> "batmand -c -d x" - process.
>
> I have compiled batmand for whiterussian_rc6 and with the following
> options: (The email server has a problem with the assignment character so I
> have removed it in this email)
> CFLAGS         -Wall -Os
> LDFLAGS        -lpthread
> CFLAGS_MIPS    -Wall -Os -DREVISION_VERSION $(REVISION_VERSION)
> LDFLAGS_MIPS   -lpthread
>
> I had to remove the -pg option because it was not possible to compile.
> Also in whiterussian_rc the CFLAGS_MIPS/LDFLAGS_MIPS are not used (I
> think).
>
> Any Idea
> /Stephan
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


