Message-ID: <20070803113132.f7ij8uf21xwsog8o@webmail.ddmesh.de>
Date: Fri, 03 Aug 2007 11:31:32 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: [B.A.T.M.A.N.] dynamic gateway / hna / services
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
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
To: open-mesh <b.a.t.m.a.n@open-mesh.net>

Hello,
I didn't get the email for this request, so the mailling list thread  
my be brocken.


> n Dienstag 24 Juli 2007, Freifunk Dresden wrote:
> [...]
> > Question 2:
> >
> > I'm currently checking how the HNA is working, but until now I can not
> > see any HNA on a second node. Firewall is enabled completely for both
> > nodes and each node sees the other nodes. I call batmand as follow:
> > Node1: batmand -t 63 -a 141.56.0.0/16 wlan0 bbs /t 2 bbc /t 2
> > Node2: batmand -t 63 eth1 bbs /t 2 bbc /t 2
> >
> > But batmand -c -d 4 does not show any HNA messages and no HNA entry is
> > stored in   routing table.
>
> Indeed, seemed something has been missed (sorry for late reply). Can  
> you try something above rv489 debul-level 3 should show (batmand -c  
> -d 3):
> Adding route to 10.20.0.222/32 via 10.20.0.2 (table 65 - eth0:bat)
> and ip route ls table 65
> 10.20.0.222 via 10.20.0.2 dev eth0  proto static

I have checked out the rv491 and it seems working. In my test environment I
use a laptop (i386) and two wrt54gl. The wrt shows at "-d3" that the announced
HNA is added/deleted every 1-5 seconds. The wrt that has a greater  
distance (5meter 2 walls between) adds and deletes the HNA in a highe  
frequency than the
wrt that is about 50cm away.
I think that HNA should not be deleted to fast because someone that is  
using this "bad" connection will get often error messages during  
surfing that the rout e is not found. It would be better if just the  
connection slow because of transmistion errors.



> > Beside of this the Idea to add/delete HNA without stopping batmand
> > would be good. e.g. batmand -c -a <add-hna>
> >             batmand -c -A <del-hna>
>
> I also like the idea of dynamically changing some parameters but on  
> the other hand, what are the negative side-effects of restarting a  
> daemon ?  - A client connected to the daemon might temporary loose  
> connection
>  - Do you know others?

I think the first point is important enough. see the statement above.

> [...]
>
> >
> > Another Idea of the "-m" is to differenciate this parameter to -M
> > <"message"> and -m <send-script>. by calling batmand -c -m send-script,
> > batmand can setup stdin/stdou as binary file handle and fill a user-OGM
> > with binary data that is then send.
> >
>
> Even if such message-flooding ist not implemented I just thought of  
> whether there exist some standardized formats to announce such  
> services (maybe the community network markup language CNML idea) ?  
> ciao, axel

I have looked through the code and have seen that the HNA is simply  
appended to
the end of a message. if we want to send other information a TLV structure is
needed (Tag-length-value). Batmand can ignore unknown Tags and is  
still working in the network. At moment the whole network needs an  
update at same time, because old batmand will interpret any data as HNA.
I hope I'm not wrong :)

Bye
  Stephan





