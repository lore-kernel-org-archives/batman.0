Message-ID: <37878.149.5.32.200.1227142313.squirrel@www.rivertowermail.com>
In-Reply-To: <52133.149.5.32.200.1227140000.squirrel@www.rivertowermail.com>
References: <52133.149.5.32.200.1227140000.squirrel@www.rivertowermail.com>
Date: Thu, 20 Nov 2008 00:51:53 -0000 (UTC)
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

Hi again,

I've been trying to test this idea a bit but I'm a bit concerned - does
BATMAN only work with AdHoc wireless NICs?

I have a server with an Ethernet NIC with an IP 5.0.0.1/8.  I've got a
transparent AP bridge with an IP of 5.1.0.1/8 and normally I can ping it
from my server.

But when I enable BATMAN on the ethernet NIC I can no longer ping 5.1.0.1 -

Maybe this is due to an IP2 rule/route?  I can see that this is due to a
IP2 rule "from all to 5.0.0.0/8 lookup 67" and routes for table 67 is
"unreachable default proto static"

So I'm wondering if it's possible to have part of the network as Ethernet
rather than AdHoc wirless? (in my case with a transparent wireless bridge
in the "middle" of the ethernet but that doesn't matter)

thanks for any info

Derek

On Thu, November 20, 2008 12:13 am, Derek C wrote:
> Hi all,
>
>
> I'm getting ready to install a BATMAN based MESH node (10dBM omni) in a
> housing estate connected via a 2KM transparent bridge 5Ghz wireless link to
> the data centre.
>
> Is it OK to have my base station(s) MESH openwrt boards have BATMAN
> running on two interfaces?  the Ethernet NIC (to bridge) - & WIFI omni.
>
> The reason I'm asking is that I'd like the base station(s) to find their
> last hop to be the datacentre server (running BATMAN).
>
> I want to keep the Internet NATing in one place (datacentre gateway
> server) - this would ensure I'd have no problem with flapping routes once I
> have multiple base stations up.
>
> Does this sound ok to you?  Its the BATMAN on two interfaces thing I'm
> concerned about - will it work I wonder?
>
> thanks for any info
>
> Derek
>
>
>
>
>
> I was hoping on setting up a
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

