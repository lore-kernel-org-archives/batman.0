Message-Id: <C12B8956-7F83-4FBE-A300-B803928CB64C@gmail.com>
From: Scott Raynel <scottraynel@gmail.com>
In-Reply-To: <20081204113558.GA14932@pandem0nium>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"; delsp="yes"
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv-kernelland: Fix memory
	corruption bug
Date: Fri, 5 Dec 2008 23:40:30 +1300
References: <DFF8A357-1AF1-4F11-BE89-46DD131FA7FF@gmail.com>
	<20081204113558.GA14932@pandem0nium>
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On 5/12/2008, at 12:35 AM, Simon Wunderlich wrote:

> Hey Scott,
>
> thank you very much for the fix! Can you confirm if this bug is =20
> related
> to https://dev.open-mesh.net/batman/ticket/86 ?
> This bug has very likely been caused by a memory corruption, but i
> couldn=C2=B4t find where. (i have not experienced any kernel panics by =20
> this
> however ...).


It is quite possible that they are related. The slab error states that =20
a memory allocation was overwritten - the same problem as my patch =20
fixed. However, I can't confirm whether it is the same memory =20
allocation or a different one. The stack trace I got specifically =20
mentioned the kfree() in send_own_packet(), whereas this stack trace =20
does not.

Is that bug easily reproducible? It will be a couple of days before I =20
can try to look at it.

Also, the stack trace is confusing as it appears to indicate a kfree() =20
within hardif_min_mtu(), which I can't find :)

I'll try to do some stress testing of the module with the slab =20
debugger turned on for a while and see what happens.

Cheers,

--
Scott Raynel
WAND Network Research Group
Department of Computer Science
University of Waikato
New Zealand




