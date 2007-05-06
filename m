Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Transfer-Encoding: 7bit
Message-Id: <E14D633A-4B9F-439F-BA19-A7EED7F004BF@gmx.ch>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
From: Lorenz Schori <lorenz.schori@gmx.ch>
Date: Sun, 6 May 2007 20:43:30 +0200
Subject: [B.A.T.M.A.N.] BSD port
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: B.A.T.M.A.N@open-mesh.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all

I looked into trunk/batman/bsd.c on WCW07 and began to work on it  
this weekend. I believe that i've fixed the routing code and that the  
tun stuff is working but i'm somehow to stupid to actually test the  
stuff. My setup is like this:

== Mac OSX Intel/10.4 ==
internal network interface en3 (-> Virtual Machine): 192.168.129.130/25

$ ps auxwww | grep batmand
root      2308   0.1 -0.0    28600    436  p2  S+    8:21PM    
0:00.83 ./batmand -d 2 -g 7 en3

$ ifconfig tun0
tun0: flags=8850<POINTOPOINT,RUNNING,SIMPLEX,MULTICAST> mtu 1500
         open (pid 2308)

Batman says:
No gateways in range ...

== Virtualized Debian Linux ==
eth0: 192.168.129.131/25
batmand -r 3 -d 2 eth0

$ ps auxwww | grep batman
root      6784  0.2  0.1  34472   692 pts/1    Sl+  20:22   0:01 ./ 
batmand -r 3 -d 2 eth0

Batman says:
192.168.129.130 via: 192.168.129.130(64), gw_class 7 - 2 MBit,  
reliability: 3

BUT: ifconfig -a does not show any tun device. Is this normal  
behavior? In my opinion the linux box should create a tun and point  
the default route to it. Am i wrong?

LG
Lorenz 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFGPiHSlNX+1hvKqPsRArYmAJwIJbf068yN+KKgGl/57cz1B+J9GgCbBFWx
fswy4zNXXSzFLs0UZIJcXZc=
=4w8Y
-----END PGP SIGNATURE-----
