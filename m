From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] a strange case
Date: Mon, 24 Sep 2007 20:38:29 +0200
References: <53923.85.41.146.90.1190656836.squirrel@krisma.oltrelinux.com>
In-Reply-To: <53923.85.41.146.90.1190656836.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709242038.29535.axel@open-mesh.net>
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

On Montag 24 September 2007, a.anselmi@oltrelinux.com wrote:
> Hi all
>
> I'm experiencing a strange situation
>
> [AP_n]--wifi--[client]--mesh--[gateway]--wifi--[AP_g]
>
>                              [xDSL]---[world]
>
> The two nodes (client and gateway) are running batman 0.3 (experimental
> rv636) in the right way with option --bmx-defaults.
>
> A wifi laptop associated with AP_g (gateway' AP) can browse internet
> pretty well while associated with AP_n (client' AP) it can't!
> Please note that client itself can browse internet! (I tryed ssh into node
> and then wget something).
> I verified no nameserver problem neither firewall blocking rules (gateway
> and node are flashed and run the same firmware)

Just to get you right. your laptop is not running batman, just a usual 
wifi-client in managed mode. and your APs are not running batman as well, 
just usual APs in managed mode.
If that is the case the problems is actually only related to non-batman 
nodes!? If not, try to collect further information about your iproute 
configuration like:
$ip rule
$ip r ls t 254
$ip r ls t 65
$ip r ls t 66
$ip r ls t 67
And maybe your firewall or nat settings?
>
> But what is puzzling me is that running batman 0.2 on nodes... laptop
> associated with AP_n (client' AP) can browse!
> (I've only changed the daemon, no others change into environment -
> procedures dinamically change batmand command string)
> .
> I noticed the parameter "--no-unreachable-rule" then tryed adding this
> parameter at the batman 0.3 command string but unfortunately with no
> results!

Batman-0.3 and beyond supports policy routing, thus uses 3 routing tables for 
configuring the routes. There is table 65 for HNA routes, 66 for host routes, 
and 67 for default routes (the command: ip route list table 66 # for example 
shows the host routes). Also batman usually adds an unreachable rule to the 
end of table 66 so that all hosts which IP netmask is falling into the 
netmask used for the batman mesh is immediately considered unreachable if not 
having a dedicated batman-host route to that IP.  The --no-unreachable-rule 
simply does not set this roule. Using this switch is usully only necessary if 
you are doing very fancy stuff. 

ciao,
axel


>
> Maybe I'm boring you... bat have any ideas about?
>
> --
> Antonio
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


