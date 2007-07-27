From: "Lui" <batman@schmudde.com>
References: <20070724152109.yhywdc2kj6skcgck@webmail.ddmesh.de>
	<200707271607.24544.lindner_marek@yahoo.de>
Subject: RE: [B.A.T.M.A.N.] dynamic gateway / hna / services
Date: Fri, 27 Jul 2007 16:59:37 +0200
Message-ID: <002201c7d05e$d1382790$3363a8c0@bluebox>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200707271607.24544.lindner_marek@yahoo.de>
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

Marek,

>First of all, "-g" is just flooded through the network. We 
>also want some kind of "dyngw"-plugin but with a better approach:
>By using tunnels to the gateway batman is in a far better situation
>than OLSR. The "is internet really available" check can be done on
>the client side and is therefore much more 

it's about the gateway himself (not a client-of-the-gateway).
A gateway router (has to/)should check his default route and change
his role to 'ordinary-client' => switch working state from -g to
-r/-p Mode. May think about NATed LAN-clients, too...

The "working-tunnel-check" is good tool against 'vandalism' or
mis-configuration in the hand of a gateway-client, but it's no
protection for the gateway against vandalism (i.e.) of his ISP...

Lui
(stucking just in the mentioned situation)


