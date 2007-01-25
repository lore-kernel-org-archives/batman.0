Date: Thu, 25 Jan 2007 15:45:41 +0100 (MET)
From: Marek Lindner <lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701251533.03312.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] Announcement: batman 0.1.1 released
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


Hi,

the batman team proudly announces the 0.1.1 release which is a stability and 
bugfix release for the 0.1.x branch.
The following bugs were squashed:

- compability version increased to 2
- batmand deactivates linux kernel antispoof protection which led to packet 
loss on multihomed devices
- "logical" memory leaks fixed (continuously growing neighbour and packet 
list)
- removed double free on neighbour purge (neighbour with hna)
- broken tun support disabled (on *BSD and MacOS X)
- debug level 1 display bug fixed (patch from nino) 

We suggest you to upgrade to the latest version for a better batman 
experience !  ;-)

ATTENTION: Certain bugs affect the behaviour of a batman network not only the 
one batman node itself. That is why we increased the compability version for 
batman packets for the first time. batman irgnores all batman packets that do 
not have the same compability version. Which means that batman 0.1.1 will 
ignore batman 0.1 and the other way round. 

You can get the sources and precompiled mips binaries from open-mesh.net.

Regards,
Marek
