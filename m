From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Batman problem with tun0
Date: Wed, 4 Jul 2007 17:07:12 +0200
References: <468BAFD3.6060700@fokus.fraunhofer.de>
In-Reply-To: <468BAFD3.6060700@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707041707.12189.lindner_marek@yahoo.de>
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

> I have two Asus wl500gp router, each with atheros(Atheros 5212)
> wlancards, running kamikaze 7.06; kernel ver.:2.6.19.2. and B.A.T.M.A.N.
> 0.2 rv451 (compability version 3)
> one of them has access to the internet.
> The one who has no internet connection, doesn't set a default route to
> the one who has. It only sets this routes:

it looks quite good so far. Blocked TCP is the most obvious reason that the 
tun device does not appear. the client tries to establish a TCP control 
channel (port 1967) to the gateway. If that connection attempt is ignored no 
default route will be set.

Regards,
Marek
