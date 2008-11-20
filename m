Message-ID: <49111.149.5.32.200.1227173227.squirrel@www.rivertowermail.com>
In-Reply-To: <200811201148.45976.lindner_marek@yahoo.de>
References: <52133.149.5.32.200.1227140000.squirrel@www.rivertowermail.com>
	<37878.149.5.32.200.1227142313.squirrel@www.rivertowermail.com>
	<200811201148.45976.lindner_marek@yahoo.de>
Date: Thu, 20 Nov 2008 09:27:07 -0000 (UTC)
Subject: Re: [B.A.T.M.A.N.] My proposed network - is it ok?
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

Hi Marek,

Overall that's great news (that I can route BATMAN over ethernet as well
as wireless) - it means that if routes flap from gateway to gateway for
whatever reason people will not drop connections as I'll keep the NAT at
the Internet source (I can do it because I only have one Internet source).

I've just been trying out a "lazy" option for my internal AP bridge
routing (just to that I can check they are alive and work on them, etc): -
I've setup a NIC alias on another private subnet - BATMAN seems quite
happy that an alias is there and doesn't affect its routing - so this
looks like a good option right now!

thanks very much for the good news

Derek


On Thu, November 20, 2008 3:48 am, Marek Lindner wrote:
>

> Hi,
>
>
>> I've been trying to test this idea a bit but I'm a bit concerned - does
>>  BATMAN only work with AdHoc wireless NICs?
>>
>
> no - its does not care about the lower layers. It will run on ad-hoc,
> managed, ethernet, etc ... Batman also runs on multiple interfaces. Simply
> supply several interfaces on the command line: batmand if1 if2 if3
>
>
>> I have a server with an Ethernet NIC with an IP 5.0.0.1/8.  I've got a
>> transparent AP bridge with an IP of 5.1.0.1/8 and normally I can ping it
>>  from my server.
>>
>> Maybe this is due to an IP2 rule/route?  I can see that this is due to
>> a IP2 rule "from all to 5.0.0.0/8 lookup 67" and routes for table 67 is
>> "unreachable default proto static"
>>
>
> Yes, the unreachable route may be the reason for that. Batman assumes
> that everything within its own IP range (5.0.0.1/8) should have a routing
> entry or the route does not exist. It lets you detect faster whether a
> node is down or not. Depending on your setup it may make sense to not have
> a route. Does the AP bridge (5.1.0.1/8) have a route back to your server ?
> If you want to integrate
> batmans routing decision into your fancy setup have a look here:
> https://dev.open-mesh.net/batman/wiki/RoutingVodoo
>
>
>
> Marek
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

