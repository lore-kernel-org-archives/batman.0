Message-ID: <c1004cd20806160901m70ff21d2y97830fdd128c5f75@mail.gmail.com>
Date: Mon, 16 Jun 2008 18:01:23 +0200
From: "thomas anderson" <eidos85@gmail.com>
Subject: [B.A.T.M.A.N.] Batman doesn't add default route...
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6715_22519653.1213632083226"
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

------=_Part_6715_22519653.1213632083226
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I can't understund why the batmand doesn't add the default route for go on
internet.
My configuration is:
The fonera (192.168.9.1) has internet throught the eth0 interface with class
ip 192.168.1.X/24
On  fonera i start batman with this command:
batmand -s 192.168.9.1 -g 9 ath0

And on the client computer (192.168.9.4) i start batmand with this computer:
batmand -s 192.168.9.1 -r 3  -p 192.168.9.1 eth1


The problem is that when i start batman on the client pc it doesn't add the
default route to 192.168.9.1 infact if i add it manually with:
route add default gw 192.168.9.1
everything goes ok and i can surf on internet but without the manual add of
the route i can't surf..
Can someone help me?
Eidos

------=_Part_6715_22519653.1213632083226
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I can&#39;t understund why the batmand doesn&#39;t add the default route for go on internet.<br>My configuration is:<br>The fonera (<a href="http://192.168.9.1">192.168.9.1</a>) has internet throught the eth0 interface with class ip 192.168.1.X/24<br>
On&nbsp; fonera i start batman with this command:<br>batmand -s <a href="http://192.168.9.1">192.168.9.1</a> -g 9 ath0<br><br>And on the client computer (<a href="http://192.168.9.4">192.168.9.4</a>) i start batmand with this computer:<br>
batmand -s <a href="http://192.168.9.1">192.168.9.1</a> -r 3&nbsp; -p <a href="http://192.168.9.1">192.168.9.1</a> eth1<br><br><br>The problem is that when i start batman on the client pc it doesn&#39;t add the default route to <a href="http://192.168.9.1">192.168.9.1</a> infact if i add it manually with:<br>
route add default gw <a href="http://192.168.9.1">192.168.9.1</a> <br>everything goes ok and i can surf on internet but without the manual add of the route i can&#39;t surf..<br>Can someone help me?<br>Eidos<br>

------=_Part_6715_22519653.1213632083226--
