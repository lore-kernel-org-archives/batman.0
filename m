Message-ID: <2bda28cd0709190519r74f0c58ncc1c23553c925091@mail.gmail.com>
Date: Wed, 19 Sep 2007 14:19:32 +0200
From: "Stefano Scipioni" <stefano@one-b.it>
Sender: scipio.it@gmail.com
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1158_7207971.1190204372216"
Subject: [B.A.T.M.A.N.] batman routing clarification
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

------=_Part_1158_7207971.1190204372216
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am switching a 20 mesh node from olsrd but I have some problem in routing.
I have no gateway node because I use openvpn to have a tunnel with PC.
All nodes have:
  batman -g 0 -r 3 -o 3000 <interface>

node C has:
  batman -g 0 -r 3 -o 3000 -a 10.0.0.0/24 <interface>

I have several case like this:

A----good----B----good-----C-----10.0.0.0/24----PC
\---------------poor-------------/

three node can communicate with all others but radio link from A to C is
poor.

When node A want to communicate to node C it goes directly to C because
batman calculate a direct route to it.
But if I manually set routes to use node B connection from A to C is good.

What is my mistake?

-r parameter in batmand daemon works only in searching gateway node? ...or
it works every time, also with normal node?

------=_Part_1158_7207971.1190204372216
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am switching a 20 mesh node from olsrd but I have some problem in routing.<br>I have no gateway node because I use openvpn to have a tunnel with PC. <br>All nodes have:<br>&nbsp; batman -g 0 -r 3 -o 3000 &lt;interface&gt;<br>
<br>node C has:<br>&nbsp; batman -g 0 -r 3 -o 3000 -a <a href="http://10.0.0.0/24">10.0.0.0/24</a> &lt;interface&gt;<br>
<br>I have several case like this:<br><br>A----good----B----good-----C-----10.0.0.0/24----PC<br>\---------------poor-------------/<br><br>three node can communicate with all others but radio link from A to C is poor.<br>
<br>When node A want to communicate to node C it goes directly to C because batman calculate a direct route to it.<br>But if I manually set routes to use node B connection from A to C is good.<br><br>What is my mistake?<br>
<br>-r parameter in batmand daemon works only in searching gateway node? ...or it works every time, also with normal node?<br> 

------=_Part_1158_7207971.1190204372216--
