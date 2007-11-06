Date: Tue, 6 Nov 2007 08:26:20 +0000 (GMT)
From: Marek Lindner <lindner_marek@yahoo.de>
Subject: AW: [B.A.T.M.A.N.] 0.3-beta-rv779 and rv780
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <193253.89493.qm@web26905.mail.ukl.yahoo.com>
Content-Transfer-Encoding: 8bit
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


Hi,


> For some reason (or another?) my middle unit keeps re-creating the
 gate0
> every few seconds. Sometimes it loses it completely and sometimes it
 keeps
> it for 10 seconds or so. The furthest node from the gw keeps it's
 tunnel
> permanently configured (which is nice).

to get to the bottom of your problem I need debug level 3 output. If
 you start
the daemon with "-d 3" or connect to the running daemon with "batmand
 -c -d 3"
and send me that output I will be able to figure it out.


> Basically, node-to-node traffic is ok, very stable and very nice but
> node-through-gw is flaky.

On all nodes or just from that one ?


Greetings,
Marek






      Heute schon einen Blick in die Zukunft von E-Mails wagen? www.yahoo.de/mail

