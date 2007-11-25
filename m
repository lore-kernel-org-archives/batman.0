From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batmand still doesn't start the right way
Date: Sun, 25 Nov 2007 20:56:25 +0100
References: <4747BE35.3040307@absorb.it>
	<200711251855.23693.axel@open-mesh.net>
	<4749C420.4010308@absorb.it>
In-Reply-To: <4749C420.4010308@absorb.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711252056.25728.axel@open-mesh.net>
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

On Sonntag 25 November 2007, rene wrote:
...
>
> Wow, seems a little disturbed the whole thing... 
indeed
> Another Router showed 
> the same transmission problem with BATMAN, this time one that had only
> one interface. 
Did you try to run batmand on the real-interface name (not alias) and if yes, 
did it also show such problems
> Solving the problem seems somehow possible by killing 
> batmand (not removing the interfaces), waiting a few seconds and
> starting batmand. after a few trials it works :)
this does not sound like an acceptable solution :-)

I am runing kamikaze from svn (currently rv 9118) on foneras(mips), 
netgears(mipsel), wrap(i386) and always bind batman to an alias interface. 
However, Ive never recognized that with kamikaze. 

My wrap board usually does not mesh on a lan device (only on the atheros wlan 
devices), but I'll test that sometime.


ciao,
axel

>
> Regards,
> Rene
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


