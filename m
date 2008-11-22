From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] gateX interfaces
Date: Sat, 22 Nov 2008 23:44:13 +0800
References: <60530.149.5.32.200.1227364065.squirrel@www.rivertowermail.com>
In-Reply-To: <60530.149.5.32.200.1227364065.squirrel@www.rivertowermail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200811222344.13407.lindner_marek@yahoo.de>
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

On Saturday 22 November 2008 22:27:45 Derek C wrote:
> Currently I'm constantly killing batmand and starting it up again
> (different debugging levels, etc).
>
> Sometimes I end up with a 2nd gate tunnel (so I'd have a gate0 and a
> gate1).
>
> I understand (guess?) that it's because I do kill -9 and don't give
> batmand a chance to clean up.
>
> Normally is it true that there would only ever be one tunnel (gate0) ?
>
> when multiple nodes are deployed is this still always the case?

Yes, you always will have only one gate0. If you happen to have gate1 make 
sure that you firewalling (NAT) is ok. 
Actually, I have an idea how to make that additional NAT rule unnecessary but 
I can't test it. If you have time join our IRC channel and we can discuss it.

Why are you killing batman with SIGKILL anyways ? Do you want fast access to 
the debug output ? You can start batman with the "-d <debug_level>" option to 
prevent batman from forking into the background (CTRL + C will kill batman).

Regards,
Marek


