From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batman FONera
Date: Tue, 26 Jun 2007 09:50:42 +0200
References: <28978.85.41.146.90.1182805896.squirrel@krisma.oltrelinux.com>
In-Reply-To: <28978.85.41.146.90.1182805896.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706260950.43044.axel@open-mesh.net>
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

Hey Antonio,

Very cool work!  Particulary i like your illustrative documentation:
http://www.blogin.it/howtoponte2/node95.html

I am very interested to hear how stable your madwifi virtual interfaces 
configuration operates in the long run (and with more than one mesh 
neighbor). My experience (months ago and with another purpose) was that one 
of them (either the one in ad-hoc, the ap or the client one) sooner or later 
broke. And I've never tested the pseudo IBSS mode. 

ciao,
axel


On Monday 25 June 2007 23:11, a.anselmi@oltrelinux.com wrote:
> I'm testing BATMAN (batmand_0.2-rv451_mips-kk-elf-32-msb-static) in a mesh
> composed with Fonera (standard FON firmware 0.7.x) in pseudo IBSS mode:
> every cient node brings up a bat_AP offering connectivity. It seems
> working well but... I'm experiencing in a small environment with only 4
> Fonera and 1 gateway node.
>
> My request is intended to obtain - if possible - a better testbed with
> your help: if you decide to make a little batman-fonera-mesh-cloud you can
> download     mesh-ponte2 from http://sourceforge.net/projects/ponte2/
>
> The testing release in named 1.0.8-step2, in the next days I'll upload
> 1.0.10 (sure more stable)
>
> Thanks for all
>
> --
> Antonio
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
