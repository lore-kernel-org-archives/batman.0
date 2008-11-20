Message-ID: <52133.149.5.32.200.1227140000.squirrel@www.rivertowermail.com>
Date: Thu, 20 Nov 2008 00:13:20 -0000 (UTC)
From: "Derek C" <derekbatman@hssl.ie>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] My proposed network - is it ok?
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

Hi all,

I'm getting ready to install a BATMAN based MESH node (10dBM omni) in a
housing estate connected via a 2KM transparent bridge 5Ghz wireless link
to the data centre.

Is it OK to have my base station(s) MESH openwrt boards have BATMAN
running on two interfaces?  the Ethernet NIC (to bridge) - & WIFI omni.

The reason I'm asking is that I'd like the base station(s) to find their
last hop to be the datacentre server (running BATMAN).

I want to keep the Internet NATing in one place (datacentre gateway
server) - this would ensure I'd have no problem with flapping routes once
I have multiple base stations up.

Does this sound ok to you?  Its the BATMAN on two interfaces thing I'm
concerned about - will it work I wonder?

thanks for any info

Derek




I was hoping on setting up a


-- 
Derek C

