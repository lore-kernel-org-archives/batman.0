Message-ID: <2bda28cd0711090623r2e7b8750g558aebab35247da0@mail.gmail.com>
Date: Fri, 9 Nov 2007 15:23:47 +0100
From: "Stefano Scipioni" <stefano@one-b.it>
Sender: scipio.it@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] routing problem?
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

I'm testing batman 0.3 exp rv 777

traceroute give me a problem

root@sala:~$ traceroute  10.0.1.1
traceroute: can't find interface
root@sala:~$ ip route ls tab 66
10.1.5.104 dev ath0  proto static  scope link  src 10.1.5.102
10.1.5.130 via 10.1.5.104 dev ath0  proto static
10.1.5.129 via 10.1.5.1 dev ath0  proto static
10.1.5.1 via 10.1.5.104 dev ath0  proto static
root@sala:~$ ip route ls tab 65
10.0.1.0/24 via 10.1.5.1 dev ath0  proto static
root@sala:~$ traceroute  10.0.1.1
traceroute: can't find interface
root@sala:~$ ping 10.0.1.1
PING 10.0.1.1 (10.0.1.1): 56 data bytes
64 bytes from 10.0.1.1: seq=0 ttl=61 time=9.119 ms
64 bytes from 10.0.1.1: seq=1 ttl=61 time=8.486 ms

traceroute works If I utilize source address option.
What is my mistake?

Also if one of nodes has no batman-exp running on it I can't reach it
from neighbours (I use batmand on ath0 interface, not an alias)?
Perhaps I have to use --no-unreachable-rule?

Stefano
