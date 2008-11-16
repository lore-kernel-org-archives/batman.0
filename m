Message-ID: <60517.149.5.32.200.1226874708.squirrel@www.rivertowermail.com>
Date: Sun, 16 Nov 2008 22:31:48 -0000 (UTC)
From: "Derek C" <derekbatman@hssl.ie>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Newbe - almost have batman up and running (almost)
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

Hi all,

I'm trying to try-out batman with kamikaze 8.09 on some Atheros boards
(Ubiquity litestation 2s).

So far almost so good.

I have both boards booted.  I've setup the ath0 interfaces as Adhoc with
IP addresses 5.0.0.1/8 and 5.0.0.2/8 and I can ping between them.

batmand is started on both boards and on the Internet gateway board I've
run "batmand -c -g 4Mbit" and on the radio linked node board I've run
"batmand -c -r 3".

Then I see some great looking messages:
     Found new gateway 5.255.0.1 -> class: 49 - 4MBit/1024KBit
     Adding default route to 5.255.0.1 (gw_flags: 49, tq: 110, gw_product: 0)
     Gateway client - got IP (169.254.0.1) from gateway: 5.255.0.1
     Adding default route via gate0 (table 68)

I see that there is indeed a "gate0" tunnel NIC created and although I
don't see a new default route if I run "ip route list table 68" I CAN see
a line "default dev gate0  proto static  scope link  src 169.254.0.1".

Still - I don't much like the look of that 169.254.0.1 IP address ?

I am not getting actual Internet access - which is why I'm looking for help


thanks for any info!

Derek


-- 
Derek C

