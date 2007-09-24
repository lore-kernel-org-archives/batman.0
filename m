Message-ID: <54331.85.41.146.90.1190664332.squirrel@krisma.oltrelinux.com>
In-Reply-To: <200709242038.29535.axel@open-mesh.net>
References: <53923.85.41.146.90.1190656836.squirrel@krisma.oltrelinux.com>
	<200709242038.29535.axel@open-mesh.net>
Date: Mon, 24 Sep 2007 22:05:32 +0200 (CEST)
Subject: Re: [B.A.T.M.A.N.] a strange case
From: a.anselmi@oltrelinux.com
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

Hi

Is not a problem of ports or firewall (batman' stream flows well over the
mesh... otherwise client node itself would not browse or would not find
any other originator): iI believe problem stay "in front" of mesh and not
inside the mesh. I've two roads to walk:

1) AP IP space is in HNA: maybe exists a different way of managing HNA
routes in gateways and in clients ? (remember that users associated with
gateway AP browse). It seems client node batmand daemon  (the 0.3 release)
doesn't how to manage/route packets coming from HNA - it desn't matter if
coming from wifi conenctions or wired one but its source IP

2) Something of wrong in route table 65?

I'll do more tests looking deeper at routing tables...

Antonio


> Just to get you right. your laptop is not running batman, just a usual
> wifi-client in managed mode. and your APs are not running batman as well,
> just usual APs in managed mode.
> If that is the case the problems is actually only related to non-batman
> nodes!? If not, try to collect further information about your iproute
> configuration like:
> $ip rule
> $ip r ls t 254
> $ip r ls t 65
> $ip r ls t 66
> $ip r ls t 67
> And maybe your firewall or nat settings?
>>
>> But what is puzzling me is that running batman 0.2 on nodes... laptop
>> associated with AP_n (client' AP) can browse!
>> (I've only changed the daemon, no others change into environment -
>> procedures dinamically change batmand command string)
>> .
>> I noticed the parameter "--no-unreachable-rule" then tryed adding this
>> parameter at the batman 0.3 command string but unfortunately with no
>> results!
>
> Batman-0.3 and beyond supports policy routing, thus uses 3 routing tables
> for
> configuring the routes. There is table 65 for HNA routes, 66 for host
> routes,
> and 67 for default routes (the command: ip route list table 66 # for
> example
> shows the host routes). Also batman usually adds an unreachable rule to
> the
> end of table 66 so that all hosts which IP netmask is falling into the
> netmask used for the batman mesh is immediately considered unreachable if
> not
> having a dedicated batman-host route to that IP.  The
> --no-unreachable-rule
> simply does not set this roule. Using this switch is usully only necessary
> if
> you are doing very fancy stuff.
>
> ciao,
> axel
>
>
>>
>> Maybe I'm boring you... bat have any ideas about?
>>
>> --
>> Antonio
>>
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


