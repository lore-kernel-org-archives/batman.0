From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] dynamic gateway / hna / services
Date: Thu, 2 Aug 2007 16:26:21 +0200
References: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>
In-Reply-To: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200708021626.21405.axel@open-mesh.net>
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

Hello,

On Dienstag 24 Juli 2007, Freifunk Dresden wrote:
[...]
> Question 2:
>
> I'm currently checking how the HNA is working, but until now I can not
> see any HNA on a second node. Firewall is enabled completely for both
> nodes and each node sees the other nodes. I call batmand as follow:
> Node1: batmand -t 63 -a 141.56.0.0/16 wlan0 bbs /t 2 bbc /t 2
> Node2: batmand -t 63 eth1 bbs /t 2 bbc /t 2
>
> But batmand -c -d 4 does not show any HNA messages and no HNA entry is
> stored in   routing table.

Indeed, seemed something has been missed (sorry for late reply). 
Can you try something above rv489 

debul-level 3 should show (batmand -c -d 3):
Adding route to 10.20.0.222/32 via 10.20.0.2 (table 65 - eth0:bat)
and 
ip route ls table 65
10.20.0.222 via 10.20.0.2 dev eth0  proto static

> Beside of this the Idea to add/delete HNA without stopping batmand
> would be good. e.g. batmand -c -a <add-hna>
>             batmand -c -A <del-hna>

I also like the idea of dynamically changing some parameters but on the other 
hand, what are the negative side-effects of restarting a daemon ? 
 - A client connected to the daemon might temporary loose connection
 - Do you know others?

[...]

>
> Another Idea of the "-m" is to differenciate this parameter to -M
> <"message"> and -m <send-script>. by calling batmand -c -m send-script,
> batmand can setup stdin/stdou as binary file handle and fill a user-OGM
> with binary data that is then send.
>

Even if such message-flooding ist not implemented I just thought of whether 
there exist some standardized formats to announce such services (maybe the 
community network markup language CNML idea) ? 

ciao, 
axel
