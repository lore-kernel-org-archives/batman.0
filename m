Message-ID: <52708.149.5.32.200.1227271288.squirrel@www.rivertowermail.com>
In-Reply-To: <50914.149.5.32.200.1227263810.squirrel@www.rivertowermail.com>
References: <50914.149.5.32.200.1227263810.squirrel@www.rivertowermail.com>
Date: Fri, 21 Nov 2008 12:41:28 -0000 (UTC)
Subject: Re: [B.A.T.M.A.N.] gateway 'expiring' instantly
From: "Derek C" <derekbatman@hssl.ie>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi again,

It does look like a clock date/time issue.  I put ntpdate into both boxes
and managed to synchronize the dates.  I did the gateway box first and
then when I got a BATMAN default route on the 2nd node I ran ntpdate there
too.

All seems fine now and the BATMAN route is staying up all the time.

My only concern is the "chicken and egg" situation (need BATMAN working to
get ntpdate to get on the Internet).  I'm not sure how I got the BATMAN
route up on the 2nd node when its date was Jan 1 2000 - maybe just because
the gateway node's date was ok?

Derek


On Fri, November 21, 2008 10:36 am, Derek C wrote:
> Hi all,
>
>
> On a couple of test x86 based openwrt boxes (PC engines WRAP boards) I'm
> seeing a client (non-gateway) batman node setting-up and dropping the
> gateway over-and-over again.
>
> With debug set to 3 I see the log output below.
>
>
> Could it be because the WRAP boards have no clock battery ?  They always
> boot up and set their clocks to Jan 1 2000.
>
> thanks for any help
>
> Derek
>
>
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate1 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate1 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 251, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate1 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate1 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 251, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate1 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate1 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 251, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate1 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate1 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 251, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate1 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate1 (table 68)
>
>
>
>
> --
> Derek C
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>


-- 
Derek C

