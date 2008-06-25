From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Re: routing script
Date: Thu, 26 Jun 2008 00:29:02 +0800
References: <14659.85.41.146.90.1214391124.squirrel@krisma.oltrelinux.com>
	<ba16c324897fee6d1842df2085f702b5.squirrel@wm.ddmesh.de>
In-Reply-To: <ba16c324897fee6d1842df2085f702b5.squirrel@wm.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806260029.02891.lindner_marek@yahoo.de>
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

> As I know you can not directly trigger to change the default route.

I don't know about batman-ex but batman allows that. Depending on your needs 
you have several options:

- If you know what gateway you want you can use the -p option even at runtime:
batmand [-c] -p <IP>

- If you want that batman chooses a better gateway based on the TQ as soon as 
it is available use -r XX (also available at runtime) where XX bgreater than 
3. To switch to a new gateway as soon as its TQ values is 20 points higher 
than the current gateway:
batmand [-c] -r 20

Greetings,
Marek
