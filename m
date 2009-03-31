Sender: Kai Timmer <kai@kait.de>
Message-ID: <49D2300C.9010206@kait.de>
Date: Tue, 31 Mar 2009 17:00:28 +0200
From: Kai Timmer <email@kait.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Batman-adv nodes do not recieve OGMs
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
To: b.a.t.m.a.n@open-mesh.net

Hello,
i have a problem using batman-adv. At the moment i use v0.1, but i had
the same problem when trying the svn version 1241.

All the nodes send their ogm, but none does recieve any of these. What i
did on all nodes is:

iwconfig $wlaninterface essid batman mode ad-hoc
and then
echo "$wlaninterface" > /proc/net/batman-adv/interfaces
echo 15 > /proc/net/batman-adv/log_level

cat /proc/net/batman-adv/log after that shows somethink like this:

Adding interface: ath0
Can't activate module: the primary interface is not active
Sending own packet (originator 00:18:84:14:48:e5, seqno 1, TTL 50) on
interface ath0 [00:18:84:14:48:e5]
Sending own packet (originator 00:18:84:14:48:e5, seqno 2, TTL 50) on
interface ath0 [00:18:84:14:48:e5]
Sending own packet (originator 00:18:84:14:48:e5, seqno 3, TTL 50) on
interface ath0 [00:18:84:14:48:e5]

I also tried to set the channel on all nodes, but with no effect.

Maybe someone can tell me what i do wrong.

Thank you,
-- 
Kai Timmer
Email : email@kait.de
Jabber: kai@kait.de
Blog: http://blog.kaitimmer.de
