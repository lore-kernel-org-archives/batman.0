From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Re: TTL-Interface specific
Date: Sun, 22 Jul 2007 22:25:02 +0200
References: <200707211000.l6LA02R6018086@open-mesh.net>
	<46A21D01.3000406@ddmesh.de>
In-Reply-To: <46A21D01.3000406@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707222225.02178.axel@open-mesh.net>
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

Hello

On Saturday 21 July 2007 16:49, Freifunk Dresden wrote:
> As setting up a TTL per interface and per command line you may extent
done!
can be tested from trunk/batman-experimental revision rv 479  
available from e.g.:
http://downloads.open-mesh.net/batman/development/i386/batmand-exp_0.3-exp-current_i386-gc-elf-32-lsb-dynamic.tgz
or using:
svn co https://dev.open-mesh.net/svn/batman/trunk/batman-experimental

> the interface name like the following examble:
> batmand eth1:32 bbs:2 bbc
however, the ":" is reserved because it is used to differentiate alias 
interfaces from the physical interface name. 
The (optional) syntax is now: /t number-of-ttl to be given behind the 
interface name.  According to your example use:
batmand eth1 /t 32 bbs /t 2 bbc

> which could mean to setup the eth1 with TTL 32, bbs with TTL 2 and bbc
> with the default TTL value.

You can also specify the default TTL value with -t like
batmand -t 60 eth1 /t 32 bbs /t 2 bbc

ciao,
axel
