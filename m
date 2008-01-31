From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] gateway class/batmand termination
Date: Thu, 31 Jan 2008 17:52:05 +0100
References: <20080127174820.uo7k8twns4c8c4o8@webmail.ddmesh.de>
In-Reply-To: <20080127174820.uo7k8twns4c8c4o8@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801311752.05973.axel@open-mesh.net>
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

Hello Stephan,

thanks for that report (and all the others :-) ).
I think it is fixed with revision 972.

ciao,
axel

On Sonntag 27 Januar 2008, Freifunk Dresden wrote:
> Hi,
>
> I have implemented a mechanism that checks for a working internet
> connection. Depending on this batmand is called either with options "-c -b
> -r2" or "-c -b -g 1024/1024".
>
> Most often when batmand is called with "-c -b -g 1024/1024" batmand
> terminates:
>
> batmand -c -b -g 1024/1024
> WARNING: You are using BatMan-eXp 0.3-alpha (compatibility version 10) !
> Connection terminated by remote host.
>
> I have to restart batmand, but all routes are removed and batman loses
> its data. I also have to check for the internet connection again and must
> hope that batmand does not terminate.
>
> Batmand does not terminate every time.
>
> Any ideas?
> Tested rev. 966 (batman-experimental)
>
> /Stephan
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


