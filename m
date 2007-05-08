In-Reply-To: <E14D633A-4B9F-439F-BA19-A7EED7F004BF@gmx.ch>
References: <E14D633A-4B9F-439F-BA19-A7EED7F004BF@gmx.ch>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <30318D39-9A9D-4847-B943-9AB2C7C82BA5@lo-res.org>
Content-Transfer-Encoding: 7bit
From: Aaron Kaplan <aaron@lo-res.org>
Subject: Re: [B.A.T.M.A.N.] BSD port
Date: Tue, 8 May 2007 15:52:20 +0200
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: Lorenz Schori <lorenz.schori@gmx.ch>
Cc: B.A.T.M.A.N@open-mesh.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


people we have the OLSR-NG test server ready. In case you want to  
test with many linux instances, please
go ahead. It wis waiting for your test results.

https://wiki.funkfeuer.at:443/index.php/OLSR-NG


just mail me.

a.


On May 6, 2007, at 8:43 PM, Lorenz Schori wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hello all
>
> I looked into trunk/batman/bsd.c on WCW07 and began to work on it  
> this weekend. I believe that i've fixed the routing code and that  
> the tun stuff is working but i'm somehow to stupid to actually test  
> the stuff. My setup is like this:
>
> == Mac OSX Intel/10.4 ==
> internal network interface en3 (-> Virtual Machine):  
> 192.168.129.130/25
>
> $ ps auxwww | grep batmand
> root      2308   0.1 -0.0    28600    436  p2  S+    8:21PM    
> 0:00.83 ./batmand -d 2 -g 7 en3
>
> $ ifconfig tun0
> tun0: flags=8850<POINTOPOINT,RUNNING,SIMPLEX,MULTICAST> mtu 1500
>         open (pid 2308)
>
> Batman says:
> No gateways in range ...
>
> == Virtualized Debian Linux ==
> eth0: 192.168.129.131/25
> batmand -r 3 -d 2 eth0
>
> $ ps auxwww | grep batman
> root      6784  0.2  0.1  34472   692 pts/1    Sl+  20:22   0:01 ./ 
> batmand -r 3 -d 2 eth0
>
> Batman says:
> 192.168.129.130 via: 192.168.129.130(64), gw_class 7 - 2 MBit,  
> reliability: 3
>
> BUT: ifconfig -a does not show any tun device. Is this normal  
> behavior? In my opinion the linux box should create a tun and point  
> the default route to it. Am i wrong?
>
> LG
> Lorenz-----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.5 (Darwin)
>
> iD8DBQFGPiHSlNX+1hvKqPsRArYmAJwIJbf068yN+KKgGl/57cz1B+J9GgCbBFWx
> fswy4zNXXSzFLs0UZIJcXZc=
> =4w8Y
> -----END PGP SIGNATURE-----
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

- ---
there's no place like 127.0.0.1


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFGQICWxEgyMttZ8YwRAuDDAJ9DFSGLOpF5W772SNOXVuH/VsZIzgCdFDX5
nHcs2Ip/3RNL0wMVXKFfDyY=
=xEFe
-----END PGP SIGNATURE-----
