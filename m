From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batman-exp still has sometimes around 90% CPU load
Date: Mon, 27 Oct 2008 06:03:18 +0200
References: <24eb75fd8a048d4b908387e3bfbce04f.squirrel@webmail.ddmesh.de>
In-Reply-To: <24eb75fd8a048d4b908387e3bfbce04f.squirrel@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810270503.18516.axel@open-mesh.net>
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

On Samstag 25 Oktober 2008, Stephan Enderlein (Freifunk Dresden) wrote:
[...]
>
> it was not possibe to connect to the running batmand.
> A call "batmand -c" just hangs without printing current parameters.

grrr, I know that really ugly

>
> I had this error in previous revision where you disabled the debug task.
> Batmand was running without problems.Have you enabled the debug task again
> in current revision?
Well, the debug functionality has never been disabled. It has just been moved 
to the main thread. Iam already thinking whether it makes sense to do the 
same with the tunnel thread - but not tonight. According to your debug output 
Iam sure its the tunnel thread. Just wondering why the same peace of code 
works since days on several mipsel and x86 devices here. Please test with 
r1146.

cheers,
axel




>
> any idea or solution?
> Regards
>  /Stephan
>
>
> ---------------------------------------
> Dipl.Informatiker(FH) Stephan Enderlein
> Freifunk Dresden
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


