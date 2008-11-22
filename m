Message-ID: <35921.149.5.32.200.1227387936.squirrel@www.rivertowermail.com>
In-Reply-To: <200811230035.05534.lindner_marek@yahoo.de>
References: <57356.149.5.32.200.1227370855.squirrel@www.rivertowermail.com>
	<200811230035.05534.lindner_marek@yahoo.de>
Date: Sat, 22 Nov 2008 21:05:36 -0000 (UTC)
Subject: Re: [B.A.T.M.A.N.] BATMAN routing (via gate0)
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

Does this mean that the mesh nodes cannot ping all the other nodes?   This
is if there is no routing to allow the nodes talk to "far-away" nodes not
within their own AdHoc single-hop network?

thanks,

Derek


On Sat, November 22, 2008 4:35 pm, Marek Lindner wrote:
> On Sunday 23 November 2008 00:20:55 Derek C wrote:
>
>> I see that BATMAN makes a tunnel to the gateway and then routes traffic
>>  via the 169.254 gate0 subnet
>>
>> Does this mean that all outgoing from the node should be NATed?  or is
>> it possible for the upstream node(s) to ping the node via its true IP
>> address (5.255.XXX.XXX) ?
>>
>
> The tunnel is used for internet traffic only. Within the mesh you can use
> the mesh ip addresses.
>
> Regards,
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

