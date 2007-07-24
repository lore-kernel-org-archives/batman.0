Message-ID: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>
Date: Tue, 24 Jul 2007 15:21:09 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] dynamic gateway / hna / services
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

hi,

Question 1:

how does batmand detect whether the internet connection is really connected to
the internet or not. Or does batmand just relays on the -g parameter.
Until now we let run a cron job that checks for the real working  
gateway. Because we can not relay on the presence of the default  
route. User may use a different
router to connect to the internet and just add the default route this  
private router.
The problem is that the node offering a internet connection (-g)  
should also be able to access other internet connection if its local  
connection is brocken.

Question 2:

I'm currently checking how the HNA is working, but until now I can not  
see any HNA on a second node. Firewall is enabled completely for both  
nodes and each node sees the other nodes. I call batmand as follow:
Node1: batmand -t 63 -a 141.56.0.0/16 wlan0 bbs /t 2 bbc /t 2
Node2: batmand -t 63 eth1 bbs /t 2 bbc /t 2

But batmand -c -d 4 does not show any HNA messages and no HNA entry is  
stored in   routing table.

Beside of this the Idea to add/delete HNA without stopping batmand  
would be good. e.g. batmand -c -a <add-hna>
            batmand -c -A <del-hna>

Question 3:

If a node offers a ftp server (portforwarding) I like to offer this  
"service" via batmand like olsrd.
A generic solution would be good to just allow to send user text  
messages with the OGM.

e.g:sending:  batmand -c -m "this is my message" (called requlary by  
cron.d to send/update a message or command)
  the running batmand will need an addional options e.g. -m (script)  
that is called to process the incomming message.
e.g:  batmand -m process-message-script wlan0

The advantage would be, that each user that is using batman can offer  
different
services: e.g. populate a service list, news, software updates,....

Another Idea of the "-m" is to differenciate this parameter to -M <"message">
and -m <send-script>. by calling batmand -c -m send-script, batmand  
can setup stdin/stdou as binary file handle and fill a user-OGM with  
binary data that is then send.


Please tell me if some of the features already present in the  
batman-experimental trunk.

Kind regards
  Stephan




