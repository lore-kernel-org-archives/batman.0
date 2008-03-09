Message-ID: <47D45193.4080100@gmx.net>
Date: Sun, 09 Mar 2008 22:07:31 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] b.a.t.m.a.n. + wrt54gl + OpenWrt Kamikaze + X-wrt
References: <1205094697.4165.8.camel@krupskaya.is-a-geek.net.is-a-geek.net>
In-Reply-To: <1205094697.4165.8.camel@krupskaya.is-a-geek.net.is-a-geek.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: dondavis@reglue.org, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

1. You have to use ad-hoc - multipoint to multipoint networking is what 
mesh networking is all about.
2. Did you check your firewall settings - in doubt try disabling it for 
a test (iptables -F)
3. The hints that you are giving are very sparse - which version are you 
using, your ip-settings etc.
4. Starting with a high debug level may provide more information.

cheers,

cu elektra
> I've been trying to get batman running on a a few wrt54gl's with openwrt
> kamikaze + x=wrt.
>
> Has anyone on the list had success with this?
>
> I am unsure about the wireless mode.  I thought ad-hoc, but I've also
> tried client and ap mode.
>
> I tried
> batmand br-lan
> batmand eth0:1
>
> I've tried running several all on channel 1.  And they reported there
> were no batman nodes in range.  What have I left out?
>
>
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>   

