From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batmand still doesn't start the right way
Date: Sun, 25 Nov 2007 18:55:23 +0100
References: <4747BE35.3040307@absorb.it>
	<200711251732.00986.axel@open-mesh.net> <4749A6DF.40106@absorb.it>
In-Reply-To: <4749A6DF.40106@absorb.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711251855.23693.axel@open-mesh.net>
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

On Sonntag 25 November 2007, rene wrote:
> Hi,
>
> Axel Neumann wrote:
> > According to your log files the 144 batman does send OGM and also
> > receives them. For me that does not look like a problem with batman.
> >
> > If it is not HW related, it might still be a problem with the alias
> > interfaces.
>
> Maybe, but this is happening on a range of different hardware. At least
> on WRAP(x86), Buffalo and Linksys, all running OpenWrt, the WRAPs a
> kamikaze(half-year-old) and the BuffaloS and LinkSysS running
> Whiterussian0.9.
> Any Problems about the usage of alias-interfaces known on these platforms?
>
> Thanks for your reply, the one APs wasn't changed and still has no OGMs
> sended - so further debugging is possible, if somebody suggests how...

try to let another application use the suspect alias interface.
for example ping from AP144:
ping -I 192.168.41.144 192.168.41.43

-I specifies the outgoing interface. what does tcpdump report then?

ciao,
axel

PS.:
if you need a non-busybox version of ping for buffalo/linksys:
http://downloads.open-mesh.net/misc/handy-tools/wrt-freifunk/ping.tgz
and i386/wrap
http://downloads.open-mesh.net/misc/handy-tools/sources/iputils-current/ping


>
> Regards,
> Rene
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


