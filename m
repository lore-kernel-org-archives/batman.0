From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Segmentation fault and log errors,
	expermimental Rev.756
Date: Thu, 25 Oct 2007 16:01:39 +0200
References: <47207A74.3060005@ddmesh.de>
In-Reply-To: <47207A74.3060005@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710251601.39789.axel@open-mesh.net>
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

On Donnerstag 25 Oktober 2007, Freifunk Dresden wrote:
> Hi,
>
> I'm using experimental batmand Rev 756. 
Just to be sure, Where does it show Rev 756 ? Because this reveision has never 
been committed for batmand-exp. Do you mean rv752 ? Have you experienced this 
with previous revisions?
> After a while the batmand is 
> crashing. with "Segmentation fault". the crashing batmand is running on
> i386 (debian 2.6.22.1). All routers are running the same batmand version. I
> have not checked if also the batmand crashs on the routers.
can you check that? To be honest, I am usually not testing it a lot on i386. 
I'll do so now. But on the mipsel devices which Iam mostly using for testing 
it runs since weeks without problems.

>
> /usr/bin/batmand -g 1024/200 -a 104.61.0.0/16 -s 10.12.0.1
> --no-unreachable-rule --no-throw-rules --no-prio-rules
> --resist-blocked-send wlan0 bbs /t 1 /i /A bbc /t 1 /i /A -d 4
> >/tmp/batman-chrash
can you send me that batman-crash file, and even better also a core dump? (if 
its to large send it private).

thanks,
axel
