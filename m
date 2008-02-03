Message-ID: <20080203125031.37lz3lkn0gsc0ooc@webmail.ddmesh.de>
Date: Sun, 03 Feb 2008 12:50:31 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Rev 972: batmand -c -d n hangs sometimes
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
To: "Open-Mesh, Mailinglist" <b.a.t.m.a.n@open-mesh.net>

Hi,

I'm currently try using batmand-experimental Rev.972.

I have encountered a strange behaviour. I'm running two
WRT54 (GL and GS).
Routing is working and there is enough memory. I have setup
a cron job to call "batmand -c -d [2,7,8,9]" every minutes to
update the status files on ramdisk. The webinterface then
access the content of the status file which reduces the cpu load.

The WRT54GS is working almost, but the WRT54GL hangs after a while
as described below:

The call to "batmand -c -d [2,7,8,9]" blocks batmand completely.
batman does not do any routing and OGM processing. As result the
router leaves the network.
I can still call "batmand -c -r 3" and verify with "batmand -c" that the
options were set. But OGMs are not processed.
Any call to access the debug-information is blocked.

After killall batmand and restart the call to "batmand -c -d x" is possible
serveral times until batman hangs. The process list shows this
"batmand -c -d x" - process.

I have compiled batmand for whiterussian_rc6 and with the following options:
(The email server has a problem with the assignment character so I have
removed it in this email)
CFLAGS         -Wall -Os
LDFLAGS        -lpthread
CFLAGS_MIPS    -Wall -Os -DREVISION_VERSION $(REVISION_VERSION)
LDFLAGS_MIPS   -lpthread

I had to remove the -pg option because it was not possible to compile.
Also in whiterussian_rc the CFLAGS_MIPS/LDFLAGS_MIPS are not used (I think).

Any Idea
/Stephan

