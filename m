Message-ID: <4750C29B.6030708@leipzig.freifunk.net>
Date: Sat, 01 Dec 2007 03:10:35 +0100
From: tetzlav <tetzlav@leipzig.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] rv791 <---> rv824 incompatible?
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
To: b.a.t.m.a.n@open-mesh.net

> root@17-21:~# batmand
> -v                                                                                                                                                    
>  
> B.A.T.M.A.N. 0.3-beta rv791 (compatibility version 4)
> root@17-21:~# batmand -cd4
> [  33051930] Received BATMAN packet via NB: 105.61.17.32, IF: eth1:bat
> 105.61.17.21 (from OG: 4.0.50.0, via old OG: 31.213.16.210, seqno
> 4384, tq 17, TTL 61, V 61, UDF 0, IDF 1)
> [  33051930] Is an internet gateway (class 105)
> [  33051930] Drop packet: incompatible batman version (61)


---
> root@17-32:~# batmand -v
> WARNING: You are using the unstable batman branch. If you are
> interested in *using* batman get the latest stable release
> !                                                   
> B.A.T.M.A.N. 0.3-beta rv824 (compatibility version 4)
> root@17.32:~# batmand -cd4
> [   7946500] Received BATMAN packet via NB: 105.61.17.21, IF: eth1:bat
> 105.61.17.32 (from OG: 0.254.113.181, via old OG: 0.4.117.105, seqno
> 26941, tq 61, TTL 18, V 105, UDF 0, IDF
> 0)                                                                                                                                                                     
>
> [   7946500] Is an internet gateway (class 1)
> [   7946510] Drop packet: incompatible batman version (105)

Regards
tetzlav

