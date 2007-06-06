From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Using batman
Date: Wed, 6 Jun 2007 17:57:49 +0200
References: <20070606175918.t5afx9tub1ckwk88@wwwstudent.murdoch.edu.au>
In-Reply-To: <20070606175918.t5afx9tub1ckwk88@wwwstudent.murdoch.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706061757.49661.axel@open-mesh.net>
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

Hi,
just to be sure:
> #./batmand interface ath0

you must start it with:
#./batmand ath0



On Wednesday 06 June 2007 11:59, David Murray wrote:
> Hi
>
> I have setup a testbed to try out the batman routing protocol and
> hopefully learn a little about it. I have installed it on 4 machines
> and they all seem ok but when I try to run batman with:
>
> #./batmand interface ath0
>
> I simply get another command line #. Then when I try a:
>
> #ps -e
>
> I cannot see batman running as a process anywhere. Is there something
> that I am missing?
>
> My systems are all: Debian Sarge (kernel 2.6.8-3)
> P3 800 with 256 Mb RAM
>
> I am using the latest release of Batman:
> B.A.T.M.A.N. III 0.2.0 rc2 (compability version 3)
>
> Thanks
>
> Dave
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
